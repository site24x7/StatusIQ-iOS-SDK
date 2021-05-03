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

class StatusInfoTableViewCell: UITableViewCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var operationalLabel: UILabel!
    @IBOutlet var underMaintenance: UILabel!
    @IBOutlet var degradedPerfomance: UILabel!
    @IBOutlet var majorOutage: UILabel!
    @IBOutlet var partialOutage: UILabel!
    @IBOutlet var informational: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.setCardViewDesign()
        self.setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    fileprivate func setFont() {
        self.operationalLabel.font = StatusIQCommonUtil.getFont(withSize: 13)
        self.underMaintenance.font = StatusIQCommonUtil.getFont(withSize: 13)
        self.degradedPerfomance.font = StatusIQCommonUtil.getFont(withSize: 13)
        self.majorOutage.font = StatusIQCommonUtil.getFont(withSize: 13)
        self.partialOutage.font = StatusIQCommonUtil.getFont(withSize: 13)
        self.informational.font = StatusIQCommonUtil.getFont(withSize: 13)
    }

}
