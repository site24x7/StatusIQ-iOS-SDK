/*
     Copyright (c) 2021, ZOHO CORPORATION PRIVATE LIMITED
   All rights reserved.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import Foundation
import UIKit

public class StatusIQViewController: UITableViewController  {
    
    fileprivate var statusData = StatusIQBuilder(withData: [:])
    fileprivate let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))

    fileprivate var serviceStatus : UInt = 0
    fileprivate var serviceLastChecked : String = ""
    fileprivate var statusIQComponentData = StatusIQComponentData(withData: [:])

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        StatusIQCommonUtil.resetStatusData()
    }
    
    override public func viewDidLoad() {
         super.viewDidLoad()
        self.overrideUserInterfaceStyle = StatusIQServiceStatus.theme
        self.navigationController?.overrideUserInterfaceStyle = StatusIQServiceStatus.theme

        if StatusIQServiceStatus.statusPageUrl.isEmpty {
            StatusIQAdapter.errorHandle(parentView: self.view, errorMessage: "Status page base URL not found")
        }else {
            if !StatusIQServiceStatus.componentName.isEmpty {
                self.setStatusDataFromServer()
            }else {
                StatusIQAdapter.errorHandle(parentView: self.view, errorMessage: "Please provide a component name")
            }
        }
        self.title = "Service Status"
        self.navigationController?.navigationBar.barTintColor = StatusIQCustomization.navigationBarBackgroundColor
        self.view.backgroundColor = StatusIQCustomization.backgroundColor
    }

    fileprivate func setStatusDataFromServer() {
        self.activityIndicatorView.setWindowLoading(withSuperView: self.view)

        var statusPageUrl = StatusIQServiceStatus.statusPageUrl
        StatusIQHTTPConnection.getDataFromServer(url: statusPageUrl) { (data, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.statusData = StatusIQAdapter.statusDataHandling(responseData: data)
                    let selectedComponentDetail = self.statusData.currentStatusArray.filter{( $0.display_name == StatusIQServiceStatus.componentName )}.first
                    
                    if let unwrappedServiceStatus = selectedComponentDetail?.component_status {
                        self.serviceStatus = unwrappedServiceStatus
                    }
                    
                    if let unwrappedLastPolledTime = selectedComponentDetail?.last_polled_time {
                        let dateFormatter =  DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        if let date = dateFormatter.date(from: unwrappedLastPolledTime) {
                            let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
                            let nowComponents = Calendar.current.dateComponents([.hour, .minute], from: Date())
                            if let minDiff = Calendar.current.dateComponents([.minute], from: timeComponents, to: nowComponents).minute{
                                self.serviceLastChecked = String(minDiff)
                                self.serviceLastChecked.append(" mins ago")
                            }
                        }
                    }
                    
                    let componentId = selectedComponentDetail?.enc_component_id ?? ""
                    statusPageUrl = statusPageUrl.replacingOccurrences(of: "u/summary_details", with: "public/status_history")
                    statusPageUrl += "/\(self.statusData.servicePageEncID)?enc_component_ids=\(componentId)"  // service encrypted id,component encrypted id
                    self.setSpecificComponentData(apiurl: statusPageUrl)
                }else {
                    self.activityIndicatorView.hideLoading()
                    self.showError(error: error)
                }
            }
        }
    }
    
    fileprivate func setSpecificComponentData(apiurl : String) {
        self.activityIndicatorView.setWindowLoading(withSuperView: self.view)
        StatusIQHTTPConnection.getDataFromServer(url: apiurl) { (data, error) in
            DispatchQueue.main.async {
                self.activityIndicatorView.hideLoading()
                if error == nil {
                    self.statusIQComponentData = StatusIQAdapter.componentDataHandling(responseData: data)
                    if self.statusIQComponentData.statusHistoryArray.isEmpty {
                        StatusIQAdapter.errorHandle(parentView: self.view, errorMessage: "There is no data or please check the component name")
                    }else {
                        self.tableView.reloadData()
                    }
                }else {
                    self.view.subviews.forEach({ $0.removeFromSuperview() }) // remove all the subviews while getting error
                    self.showError(error: error)
                }
            }
        }
    }
    
    fileprivate func showError(error : Error?) {
        if let errormessage = error?.localizedDescription {
            StatusIQAdapter.errorHandle(parentView: self.view, errorMessage: errormessage)
        }else {
            StatusIQAdapter.errorHandle(parentView: self.view)
        }
    }
}

extension StatusIQViewController {
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !self.statusIQComponentData.statusHistoryArray.isEmpty {
            return 3
        }
        return 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let componentNameTableViewCell   = self.tableView.dequeueReusableCell(withIdentifier: "ComponentNameIdentifier", for: indexPath) as? ComponentNameTableViewCell {
                componentNameTableViewCell.setValues(serviceStatus: self.serviceStatus, lastChecked: self.serviceLastChecked)
                return componentNameTableViewCell
            }
        case 1:
            if let componentHistoryTableViewCell   = self.tableView.dequeueReusableCell(withIdentifier: "ComponentHistoryIdentifier", for: indexPath) as? ComponentHistoryTableViewCell {
                componentHistoryTableViewCell.setValues(statusIQComponentData: self.statusIQComponentData)
                return componentHistoryTableViewCell
            }
        case 2:
            if let statusInfoTableViewCell   = self.tableView.dequeueReusableCell(withIdentifier: "StatusInfoIdentifier", for: indexPath) as? StatusInfoTableViewCell {
                return statusInfoTableViewCell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}
