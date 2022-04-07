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


protocol CollapseExpandProtocol {
    func buttonAction(selectedIndexPath : IndexPath)
}

class ContentSizeTableView: UITableView {
    
    override var contentSize: CGSize  {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
public class StatusIQPageViewController : UIViewController {
    
    @IBOutlet weak var componentTableView: UITableView!
    
    fileprivate var statusData = StatusIQBuilder(withData: [:])
    fileprivate let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    fileprivate var placeholderLabel = UILabel()

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        StatusIQCommonUtil.resetStatusData()
    }
    
    @IBAction func incidentHistoryAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = StatusIQCustomization.navigationBarBackgroundColor
        self.view.backgroundColor = StatusIQCustomization.backgroundColor
        
        if StatusIQServiceStatus.statusPageUrl.isEmpty {
            StatusIQAdapter.errorHandle(parentView: self.view, errorMessage: "Status page base URL not found")
        }else {
            self.setStatusDataFromServer()
        }
        
        self.setTableViewProperties()
    }
    
    fileprivate func setTableViewProperties() {
        self.componentTableView.estimatedSectionHeaderHeight = 100
        componentTableView.dataSource = self
        componentTableView.dataSource = self

        componentTableView.delegate = self
        componentTableView.isUserInteractionEnabled = true
        componentTableView.isScrollEnabled = true
    }
    
    fileprivate func setNavSubTitleData() {
        if let navigationBar = self.navigationController?.navigationBar {
            
            let timezone = StatusIQCommonUtil.getTimeZone()
            let serviceStatusWidth = "Service Status".size(OfFont: StatusIQCommonUtil.getFont(withSize: 15, isBold: true)).width
            let timezoneWidth = timezone.size(OfFont: StatusIQCommonUtil.getFont(withSize: 12)).width

            let navigationWidth = navigationBar.frame.width
            let navigationHeight = navigationBar.frame.height

            let firstFrame = CGRect(x: navigationWidth/2 - serviceStatusWidth/2, y: 8, width: navigationWidth, height: navigationHeight/2)
            let secondFrame = CGRect(x: navigationWidth/2 - timezoneWidth/2, y: 23, width: navigationWidth, height: navigationBar.frame.height/2)
            
            let firstLabel = UILabel(frame: firstFrame)
            firstLabel.text = "Service Status"
            firstLabel.font = StatusIQCommonUtil.getFont(withSize: 15, isBold: true)
            
            let secondLabel = UILabel(frame: secondFrame)
            secondLabel.text = timezone
            secondLabel.font = StatusIQCommonUtil.getFont(withSize: 12)
            
            navigationBar.addSubview(firstLabel)
            navigationBar.addSubview(secondLabel)
        }
    }

    fileprivate func setStatusDataFromServer() {
        self.activityIndicatorView.setWindowLoading(withSuperView: self.view)
        StatusIQHTTPConnection.getDataFromServer(url: StatusIQServiceStatus.statusPageUrl) { (data, error) in
            DispatchQueue.main.async {
                self.activityIndicatorView.hideLoading()
                if error == nil {
                    self.statusData = StatusIQAdapter.statusDataHandling(responseData: data)
                    if self.statusData.resolvedIncidentDetailArray.isEmpty {
                        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
                    }
                    self.setNavSubTitleData()
                    if self.statusData.activeIncidentDetailArray.isEmpty && self.statusData.currentStatusArray.isEmpty {
                        StatusIQAdapter.errorHandle(parentView: self.view, errorMessage: "There is no data")
                    }
                }else {
                    self.title = "Service Status"
                    if let errormessage = error?.localizedDescription {
                        StatusIQAdapter.errorHandle(parentView: self.view, errorMessage: errormessage)
                    }else {
                        StatusIQAdapter.errorHandle(parentView: self.view)
                    }
                }
                self.componentTableView.reloadData()
            }
        }
    }
    
    fileprivate func insertCell(indexPath : IndexPath, tableView : UITableView) {
        let componentObject = self.statusData.currentStatusArray[indexPath.row]
        var currentIndex = indexPath.row
        var insertDeleteIndexPathArray = [IndexPath]()
        if componentObject.componentgroup_display_name != nil {
            if let groupComponentArray = componentObject.componentgroup_components, !groupComponentArray.isEmpty {
                let objectPresentArray = self.statusData.currentStatusArray.filter { $0.display_name == groupComponentArray[0].display_name }
                
                for itemIndex in 0..<groupComponentArray.count {
                    
                    var unwrappedGroupItem = groupComponentArray[itemIndex]
                    if itemIndex != groupComponentArray.count - 1 && groupComponentArray.count != 1{
                        unwrappedGroupItem.isChildBorderNotNeed = true
                    }
                    unwrappedGroupItem.isChildElement = true
                    currentIndex += 1
                    if objectPresentArray.isEmpty {
                        self.statusData.currentStatusArray.insert(unwrappedGroupItem, at: currentIndex)
                    }else {
                        self.statusData.currentStatusArray.remove(at: indexPath.row + 1)
                    }
                    insertDeleteIndexPathArray.append(IndexPath(row: currentIndex, section: indexPath.section))
                }
                self.componentTableView.beginUpdates()
                if objectPresentArray.isEmpty {
                    self.statusData.currentStatusArray[indexPath.row].isGroupExpand = true
                    self.componentTableView.insertRows(at: insertDeleteIndexPathArray, with: .automatic)
                }else {
                    self.statusData.currentStatusArray[indexPath.row].isGroupExpand = false
                    self.componentTableView.deleteRows(at: insertDeleteIndexPathArray, with: .automatic)
                }
                self.componentTableView.endUpdates()
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
    }
}

//tableview datasource and delegate
extension StatusIQPageViewController : UITableViewDataSource, UITableViewDelegate  {
    
    fileprivate func getSectionHeaderView(withSectionTitle title : String) -> UIView {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = StatusIQCustomization.backgroundColor
        titleLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
        titleLabel.text = title
        titleLabel.font = StatusIQCommonUtil.getFont(withSize: 16, isBold: true)
        titleLabel.textAlignment = .center
        return titleLabel
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 0 && !self.statusData.activeIncidentDetailArray.isEmpty {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveIncidentCell", for: indexPath) as? StatusIQActiveIncidentTableViewCell {
                cell.collapseExpandDelegate = self
                cell.currentIndexPath = indexPath
                cell.setValues(statusIQActiveIncidentDetails: self.statusData.activeIncidentDetailArray[indexPath.row])
                return cell
            }
        } else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "componentStatusCell", for: indexPath) as? StatusIQComponentTableViewCell {
                cell.containerBottomView.isHidden = false
                cell.containerTopView.isHidden = true
                cell.containerTopLayoutConstraint.constant = 0
                if indexPath.row == 0 {
                    cell.containerTopView.isHidden = false
                    cell.containerTopLayoutConstraint.constant = 10
                }
                if self.statusData.currentStatusArray[indexPath.row].isChildBorderNotNeed ?? false {
                    cell.containerBottomView.isHidden = true
                }
                cell.setValues(statusIQCurrentStatus: self.statusData.currentStatusArray[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if !self.statusData.activeIncidentDetailArray.isEmpty && !self.statusData.currentStatusArray.isEmpty {
            return 2
        }else if !self.statusData.activeIncidentDetailArray.isEmpty || !self.statusData.currentStatusArray.isEmpty {
            return 1
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !self.statusData.activeIncidentDetailArray.isEmpty && !self.statusData.currentStatusArray.isEmpty {
            if section == 0 {
                return self.statusData.activeIncidentDetailArray.count
            }else {
                return self.statusData.currentStatusArray.count
            }
        }else if !self.statusData.activeIncidentDetailArray.isEmpty {
            return self.statusData.activeIncidentDetailArray.count
        } else if !self.statusData.currentStatusArray.isEmpty {
            return self.statusData.currentStatusArray.count
        }
        return 0
    }
    
    public func tableView(_  tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = self.componentTableView.cellForRow(at: indexPath) as? StatusIQComponentTableViewCell {
            self.insertCell(indexPath: indexPath, tableView : tableView)
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var titleText = ""
        if !self.statusData.activeIncidentDetailArray.isEmpty && !self.statusData.currentStatusArray.isEmpty {
            if section == 0 {
                titleText = "Active Incidents"
            }else {
                titleText = "Components Summary"
            }
        }else if !self.statusData.activeIncidentDetailArray.isEmpty {
            titleText = "Active Incidents"
        } else if !self.statusData.currentStatusArray.isEmpty {
            titleText = "Components Summary"
        }
        return getSectionHeaderView(withSectionTitle: titleText)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

}


extension StatusIQPageViewController : CollapseExpandProtocol {
    func buttonAction(selectedIndexPath : IndexPath) {
        self.statusData.activeIncidentDetailArray[selectedIndexPath.row].isExpand = !(self.statusData.activeIncidentDetailArray[selectedIndexPath.row].isExpand ?? false)

        self.componentTableView.beginUpdates()
        self.componentTableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        self.componentTableView.endUpdates()
    }
}
