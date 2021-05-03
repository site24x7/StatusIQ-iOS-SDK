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

class ComponentNameTableViewCell: UITableViewCell {

    @IBOutlet var statusImageView: UIImageView!
    @IBOutlet var componentName: UILabel!
    @IBOutlet var lastCheckedValueLabel: UILabel!
    @IBOutlet var lastCheckedTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setValues(serviceStatus: UInt, lastChecked: String) {
        self.componentName.text = StatusIQCommonUtil.getStatusString(statusInt : serviceStatus)
        self.statusImageView.image  =  StatusIQCommonUtil.getStatusIcon(statusInt : serviceStatus)
        self.lastCheckedValueLabel.text = lastChecked
    }
    
    fileprivate func setFont() {
        self.componentName.font = StatusIQCommonUtil.getFont(withSize: 17, isBold: true)
        self.lastCheckedValueLabel.font = StatusIQCommonUtil.getFont(withSize: 14, isBold: true)
        self.lastCheckedTitleLabel.font = StatusIQCommonUtil.getFont(withSize: 14)
    }

}
