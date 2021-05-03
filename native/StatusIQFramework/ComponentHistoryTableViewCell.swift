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

class ComponentHistoryTableViewCell: UITableViewCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var componentHistoryTitleLabel: UILabel!
    @IBOutlet var uptimeTitleLabel: UILabel!
    @IBOutlet var incidentCountTitleLabel: UILabel!
    @IBOutlet var uptimeValueLabel: UILabel!
    @IBOutlet var incidentCountValueLabel: UILabel!
    @IBOutlet var filterLabel: UILabel!
    @IBOutlet var containerStackView: UIStackView!
    @IBOutlet var stackView1: UIStackView!
    @IBOutlet var stackView2: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.setCardViewDesign()
        self.setFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func setFont() {
        self.componentHistoryTitleLabel.font = StatusIQCommonUtil.getFont(withSize: 17, isBold: true)
        self.uptimeTitleLabel.font = StatusIQCommonUtil.getFont(withSize: 15)
        self.incidentCountTitleLabel.font = StatusIQCommonUtil.getFont(withSize: 15)
        self.uptimeValueLabel.font = StatusIQCommonUtil.getFont(withSize: 15)
        self.incidentCountValueLabel.font = StatusIQCommonUtil.getFont(withSize: 15)
        self.filterLabel.font = StatusIQCommonUtil.getFont(withSize: 17, isBold: true)
    }
    
    func setValues(statusIQComponentData : StatusIQComponentData) {
        
        self.uptimeValueLabel.text = statusIQComponentData.uptime_perc
        self.incidentCountValueLabel.text = statusIQComponentData.total_incident_count
        let statusHistoryArray = statusIQComponentData.statusHistoryArray

        for(index, statusHistory) in statusHistoryArray.enumerated() {
        
            let dates  = [String]  (statusHistory.keys)
            let statusArr = [UIImage] (statusHistory.values)

            let date = dates[0]
            let statusImage = statusArr[0]
            
            let dateAndStatusView = DateAndStatusView().instanceFromNib()
            dateAndStatusView.setValues(statusImage: statusImage, date: date)            
            if index < 4 {
                self.stackView1.addArrangedSubview(dateAndStatusView)
            }else {
                self.stackView2.addArrangedSubview(dateAndStatusView)
            }
        }
    }
}
