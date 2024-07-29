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

import UIKit

class StatusIQActiveIncidentTableViewCell: UITableViewCell {

    @IBOutlet weak var IncidentTitle: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var components: UILabel!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var incidentStartTimeTitle: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var updatesLabel: UILabel!
    @IBOutlet weak var componentsLabel: UILabel!
    @IBOutlet weak var showLess: UIButton!
    @IBOutlet var updateIncidentStackView: UIStackView!
    
    @IBOutlet weak var showAll: UIButton!
    @IBOutlet var showAllTopConstraint: NSLayoutConstraint!
    @IBOutlet var showLessBottomConstraint: NSLayoutConstraint!
    @IBOutlet var showAllBottomConstraint: NSLayoutConstraint!
    
    var collapseExpandDelegate : CollapseExpandProtocol?
    var currentIndexPath = IndexPath()
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.containerView.setCardViewDesign()
        self.setFont()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func showAllAction(_ sender: Any) {
        self.showAllandLess(text : "showall")
        self.collapseExpandDelegate?.buttonAction(selectedIndexPath: currentIndexPath)
    }
    
    @IBAction func showLessAction(_ sender: Any) {
        self.showAllandLess(text : "showless")
        self.collapseExpandDelegate?.buttonAction(selectedIndexPath: currentIndexPath)
    }
    
    fileprivate func setFont() {
        self.IncidentTitle.font = StatusIQCommonUtil.getFont(withSize: 17, isBold: true)
        self.desc.font =  StatusIQCommonUtil.getFont(withSize: 14)
        self.incidentStartTimeTitle.font = StatusIQCommonUtil.getFont(withSize: 16, isBold: true)
        self.time.font =  StatusIQCommonUtil.getFont(withSize: 13)
        self.showAll.titleLabel?.font =  StatusIQCommonUtil.getFont(withSize: 13)
        self.componentsLabel.font = StatusIQCommonUtil.getFont(withSize: 16, isBold: true)
        self.components.font =  StatusIQCommonUtil.getFont(withSize: 15)
        self.updatesLabel.font = StatusIQCommonUtil.getFont(withSize: 16, isBold: true)
        self.showLess.titleLabel?.font =  StatusIQCommonUtil.getFont(withSize: 13)
    }
    
    fileprivate func showAllandLess(text : String)  {

        if text == "showall" {
            self.showLessBottomConstraint.isActive = true
            self.showAllBottomConstraint.isActive = false
            self.components.isHidden = false
            self.componentsLabel.isHidden = false
            self.showLess.isHidden = false
            self.updateIncidentStackView.isHidden = false
            self.updatesLabel.isHidden = false
            self.showAll.isHidden = true
        } else {
            self.showAllBottomConstraint.isActive = true
            self.showLessBottomConstraint.isActive = false
            self.components.isHidden = true
            self.componentsLabel.isHidden = true
            self.showLess.isHidden = true
            self.updateIncidentStackView.isHidden = true

            self.updatesLabel.isHidden = true
            self.showAll.isHidden = false
        }
    }
    
    func setValues(statusIQActiveIncidentDetails : StatusIQActiveIncidentDetails) {
        if let unwrappedincidentStatusUpdateArray = statusIQActiveIncidentDetails.incident_status_updates {
            self.updateIncidentStackView.subviews.forEach {
                $0.removeFromSuperview()
            }
            for incidentStatusUpdate in unwrappedincidentStatusUpdateArray {
                let incidentUpdateView = StatusIQSingleIncidentInfoView().instanceFromNib()
                incidentUpdateView.setValues(incidentUpdatesObject: incidentStatusUpdate)
                updateIncidentStackView.addArrangedSubview(incidentUpdateView)
            }
        }
        self.IncidentTitle.text = statusIQActiveIncidentDetails.incident_title
        self.IncidentTitle.backgroundColor = StatusIQCommonUtil.getStatusUIColor(statusInt: statusIQActiveIncidentDetails.incident_severity_id)
        self.IncidentTitle.textColor = UIColor.white
        self.desc.text = statusIQActiveIncidentDetails.incident_desc
        self.desc.sizeToFit()
        self.time.text = StatusIQCommonUtil.getIncidentDurationDateFormat(dateString:  statusIQActiveIncidentDetails.incident_began_at ?? "")
        self.time.setCardView()

        if let affectedComponentsArray = statusIQActiveIncidentDetails.incident_affected_components {
            let displayNameArray = affectedComponentsArray.map { $0.display_name }
            let affectedComponentsString = displayNameArray.joined(separator: ", ") // "1, 2, 3"
            self.components.text = affectedComponentsString
        }
            
        if statusIQActiveIncidentDetails.isExpand ?? false {
            self.showAllandLess(text: "showall")
        }else {
            self.showAllandLess(text: "showless")
        }
    }
}
