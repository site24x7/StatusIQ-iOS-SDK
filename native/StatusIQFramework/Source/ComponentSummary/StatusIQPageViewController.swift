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

enum DataAvailability {
    case ActiveAndComponent, Active, Component, NoData
}

public class StatusIQPageViewController : UIViewController {
    
    @IBOutlet weak var componentTableView: UITableView!
    
    fileprivate var statusData = StatusIQBuilder(withData: [:])
    fileprivate let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    fileprivate var placeholderLabel = UILabel()
    
    fileprivate var serviceStatusLabel = UILabel()
    fileprivate var timeZoneLabel = UILabel()
    
    fileprivate var dataAvailability: DataAvailability = .NoData

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        StatusIQCommonUtil.resetStatusData()
    }
    
    @IBAction func incidentHistoryAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = StatusIQServiceStatus.theme
        self.navigationController?.overrideUserInterfaceStyle = StatusIQServiceStatus.theme
        self.navigationController?.navigationBar.barTintColor = StatusIQCustomization.navigationBarBackgroundColor
        self.view.backgroundColor = StatusIQCustomization.backgroundColor
        
        if StatusIQServiceStatus.statusPageUrl.isEmpty {
            StatusIQAdapter.errorHandle(parentView: self.view, errorMessage: "Status page base URL not found")
        }else {
            self.setStatusDataFromServer()
        }
        
        self.setTableViewProperties()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setNavSubTitleData(isHidden: true)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !StatusIQCommonUtil.getTimeZone().isEmpty {
            self.setNavSubTitleData(isHidden: false)
        }
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
    }

    fileprivate func setTableViewProperties() {
        componentTableView.dataSource = self
        componentTableView.dataSource = self

        componentTableView.delegate = self
        componentTableView.isUserInteractionEnabled = true
        componentTableView.isScrollEnabled = true
    }
    
    fileprivate func setNavSubTitleData(isHidden: Bool = false ) {
        if let navigationBar = self.navigationController?.navigationBar {
            
            let timezone = StatusIQCommonUtil.getTimeZone()
            let serviceStatusWidth = "Service Status".size(OfFont: StatusIQCommonUtil.getFont(withSize: 15, isBold: true)).width
            let timezoneWidth = timezone.size(OfFont: StatusIQCommonUtil.getFont(withSize: 12)).width

            let navigationWidth = navigationBar.frame.width
            let navigationHeight = navigationBar.frame.height

            let firstFrame = CGRect(x: navigationWidth/2 - serviceStatusWidth/2, y: 8, width: navigationWidth, height: navigationHeight/2)
            let secondFrame = CGRect(x: navigationWidth/2 - timezoneWidth/2, y: 23, width: navigationWidth, height: navigationBar.frame.height/2)
            
            serviceStatusLabel.frame = firstFrame
            serviceStatusLabel.text = isHidden ? "" : "Service Status"
            serviceStatusLabel.font = StatusIQCommonUtil.getFont(withSize: 15, isBold: true)
            
            timeZoneLabel.frame = secondFrame
            timeZoneLabel.text = isHidden ? "" : timezone
            timeZoneLabel.font = StatusIQCommonUtil.getFont(withSize: 12)
            
            navigationBar.addSubview(serviceStatusLabel)
            navigationBar.addSubview(timeZoneLabel)
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
                    self.setEnumValueBasedOnData()
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
    
    fileprivate func setEnumValueBasedOnData() {
        if !self.statusData.activeIncidentDetailArray.isEmpty && !self.statusData.currentStatusArray.isEmpty {
            self.dataAvailability = .ActiveAndComponent
        }else if !self.statusData.activeIncidentDetailArray.isEmpty {
            self.dataAvailability = .Active
        } else if !self.statusData.currentStatusArray.isEmpty {
            self.dataAvailability = .Component
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
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        let titleLabel = UILabel(frame: CGRect(x: 36, y: 0, width: self.view.frame.size.width - 50, height: 40))
        
        headerView.addSubview(titleLabel)
        headerView.backgroundColor = StatusIQCustomization.backgroundColor
        titleLabel.text = title
        titleLabel.font = StatusIQCommonUtil.getFont(withSize: 16, isBold: true)
        titleLabel.textAlignment = .left
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch dataAvailability {
            
        case .ActiveAndComponent:
            if indexPath.section == 0 {
                return self.getActiveIncidentCell(indexPath: indexPath)
            } else if indexPath.section == 1  {
                return self.getStatusInfoCell(indexPath: indexPath)
            } else if indexPath.section == 2 {
                return self.getComponentCell(indexPath: indexPath)
            }
        case .Active:
            if indexPath.section == 0 {
                return self.getActiveIncidentCell(indexPath: indexPath)
            }
        case .Component:
            if indexPath.section == 0 {
                return self.getStatusInfoCell(indexPath: indexPath)
            } else if indexPath.section == 1  {
                return self.getComponentCell(indexPath: indexPath)
            }
        case .NoData:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if !self.statusData.activeIncidentDetailArray.isEmpty && !self.statusData.currentStatusArray.isEmpty {
            return 2 + 1  //(Active incident, component summary and status info)
        }else if !self.statusData.activeIncidentDetailArray.isEmpty || !self.statusData.currentStatusArray.isEmpty {
            return 1 + 1  //(Component summary and status info)
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch dataAvailability {
            
        case .ActiveAndComponent:
            if section == 0 {
                return self.statusData.activeIncidentDetailArray.count
            } else if section == 1  {
                return 1 //Status Info
            } else if section == 2 {
                return self.statusData.currentStatusArray.count
            }
        case .Active:
            if section == 0 {
                return self.statusData.activeIncidentDetailArray.count
            } 
        case .Component:
            if section == 0 {
                return 1 //Status Info
            } else if section == 1  {
                return self.statusData.currentStatusArray.count
            }
        case .NoData:
            return 0
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

        switch dataAvailability {
            
        case .ActiveAndComponent:
            if section == 0 {
                titleText = "Active Incidents"
            } else if section == 1  {
                titleText = "Components Summary"
            } else if section == 2 {
                titleText = ""
            }
        case .Active:
            if section == 0 {
                titleText = "Active Incidents"
            }
        case .Component:
            if section == 0 {
                titleText = "Components Summary"
            } else if section == 1  {
                titleText = ""
            }
        case .NoData:
            titleText = ""
        }
        return getSectionHeaderView(withSectionTitle: titleText)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch dataAvailability {
            
        case .ActiveAndComponent:
            if section == 0 {
                return 40
            } else if section == 1  {
                return 40
            } else if section == 2 {
                return 0

            }
        case .Active:
            if section == 0 {
                return 40
            }
        case .Component:
            if section == 0 {
                return 40
            }
        case .NoData:
            return 0
        }
        return 0
    }
    
    private func getActiveIncidentCell(indexPath: IndexPath) -> UITableViewCell {
        if let cell = componentTableView.dequeueReusableCell(withIdentifier: "ActiveIncidentCell", for: indexPath) as? StatusIQActiveIncidentTableViewCell {
            cell.collapseExpandDelegate = self
            cell.currentIndexPath = indexPath
            cell.setValues(statusIQActiveIncidentDetails: self.statusData.activeIncidentDetailArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    private func getComponentCell(indexPath: IndexPath) -> UITableViewCell {
        if let cell = componentTableView.dequeueReusableCell(withIdentifier: "componentStatusCell", for: indexPath) as? StatusIQComponentTableViewCell {
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
            var isLastData = false
            if self.statusData.currentStatusArray.count - 1 == indexPath.row {
                isLastData = true
            }
            cell.setValues(statusIQCurrentStatus: self.statusData.currentStatusArray[indexPath.row], indexRow: indexPath.row, isLastData: isLastData)
            return cell
        }
        return UITableViewCell()
    }
    
    private func getStatusInfoCell(indexPath: IndexPath) -> UITableViewCell {
        if let statusInfoTableViewCell   = self.componentTableView.dequeueReusableCell(withIdentifier: "StatusInfoIdentifier", for: indexPath) as? StatusInfoTableViewCell {
            return statusInfoTableViewCell
        }
        return UITableViewCell()
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
