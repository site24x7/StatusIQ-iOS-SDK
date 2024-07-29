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

class StatusIQComponentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerUIView: UIView!
    @IBOutlet weak var lastChecked: UILabel!
    @IBOutlet weak var componentName: UILabel!
    @IBOutlet weak var statusIcon: UIImageView!
    
    @IBOutlet var containerRightView: UIView!
    @IBOutlet var containerleftView: UIView!
    @IBOutlet var containerTopView: UIView!
    @IBOutlet var containerBottomView: UIView!
    @IBOutlet weak var expandIcon: UIImageView!
    
    @IBOutlet var statusImageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var containerTopLayoutConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func setcontainerUIViewDesignProperties(indexRow : Int, isLastData: Bool) {
        if indexRow == 0 {
            containerUIView.clipsToBounds = true
            containerUIView.layer.cornerRadius = 5
            containerUIView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else if isLastData {
            containerUIView.clipsToBounds = true
            containerUIView.layer.cornerRadius = 5
            containerUIView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            containerUIView.clipsToBounds = false
            containerUIView.layer.cornerRadius = 0
        }
    }
    
    fileprivate func setBorderProperties(isChildElement: Bool) {
        
        if isChildElement {
            statusImageLeadingConstraint.constant = 47
            self.containerUIView.backgroundColor = .clear
            containerTopView.isHidden = true
            containerBottomView.isHidden = true
            containerRightView.isHidden = false
            containerleftView.isHidden = false
        } else {
            statusImageLeadingConstraint.constant = 20
            containerTopView.isHidden = false
            containerBottomView.isHidden = false
            containerRightView.isHidden = false
            containerleftView.isHidden = false

            self.containerUIView.backgroundColor = UIColor(named: "StatusIQSecondaryBGColor", in: StatusIQCommonUtil.getBundle(), compatibleWith: nil) ?? UIColor()
        }
    }
    
    fileprivate func setFont() {
        self.lastChecked.font = StatusIQCommonUtil.getFont(withSize: 13)
    }
    
    func setValues(statusIQCurrentStatus : StatusIQCurrentStatus, indexRow : Int, isLastData: Bool) {
        
        self.setcontainerUIViewDesignProperties(indexRow : indexRow, isLastData: isLastData)
        if(statusIQCurrentStatus.display_name != nil )
        {
            self.componentName.font = StatusIQCommonUtil.getFont(withSize: 15)

            self.componentName.text = statusIQCurrentStatus.display_name
            
            if self.lastChecked != nil {
                self.lastChecked.text = StatusIQCommonUtil.getIncidentDurationDateFormat(dateString: statusIQCurrentStatus.last_polled_time ?? "")
            }
            
            if let componentStatusInt = statusIQCurrentStatus.component_status  {
                self.statusIcon.image = StatusIQCommonUtil.getStatusIcon(statusInt: componentStatusInt)
            }
            
            self.expandIcon.isHidden = true
        } else if(statusIQCurrentStatus.componentgroup_display_name != nil) {
            self.componentName.font = StatusIQCommonUtil.getFont(withSize: 15, isBold: true)

            self.expandIcon.isHidden = false
            self.componentName.text = statusIQCurrentStatus.componentgroup_display_name
            if self.lastChecked != nil {
                self.lastChecked.removeFromSuperview()
            }
            
            if let componentStatusNumber = statusIQCurrentStatus.componentgroup_status  {
                self.statusIcon.image = StatusIQCommonUtil.getStatusIcon(statusInt: componentStatusNumber)
            }
            
            if statusIQCurrentStatus.isGroupExpand ?? false {
                self.expandIcon.image = UIImage(named: "icons8-collapse-arrow-24", in: StatusIQCommonUtil.getBundle(), compatibleWith: .none)
            }else{
                self.expandIcon.image = UIImage(named: "icons8-expand-arrow-24", in: StatusIQCommonUtil.getBundle(), compatibleWith: .none)
            }
        }
        self.setBorderProperties(isChildElement: statusIQCurrentStatus.isChildElement ?? false)
    }
    
}
