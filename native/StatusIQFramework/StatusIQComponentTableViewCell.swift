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
    
    @IBOutlet var containerTopView: UIView!
    @IBOutlet var containerBottomView: UIView!
    @IBOutlet weak var expandIcon: UIImageView!
    
    @IBOutlet var containerTopLayoutConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func setDesignProperties(isChildElement : Bool) {
        self.containerUIView.backgroundColor = UIColor.white
        if isChildElement {
            self.containerUIView.backgroundColor = StatusIQCommonUtil.hexStringToUIColor(hex: "#F7F7F7")
            self.containerUIView.addBorder(toSide: .Top, withColor: UIColor.clear.cgColor, andThickness: 0)
        }
    }
    
    fileprivate func setFont() {
        self.lastChecked.font = StatusIQCommonUtil.getFont(withSize: 13)
    }
    
    func setValues(statusIQCurrentStatus : StatusIQCurrentStatus) {
        self.setDesignProperties(isChildElement: statusIQCurrentStatus.isChildElement ?? false)
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
    }
    
}
