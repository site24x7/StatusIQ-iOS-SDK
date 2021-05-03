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

class StatusIQIncidentHistoryOverallDetailCell: UITableViewCell  {
   
    @IBOutlet weak var containerUIView: UIView!
    @IBOutlet weak var noincidents: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet var IncidentHistoryStackView: UIStackView!
        
    @IBOutlet var stackViewBottomConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.containerUIView.setCardViewDesign()
        self.setFont()
    }
    
    fileprivate func setFont() {
        self.noincidents.font = StatusIQCommonUtil.getFont(withSize: 13)
        self.date.font = StatusIQCommonUtil.getFont(withSize: 17, isBold: true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setValues(resolvedIncidentDetail : StatusIQResolvedIncidentDetails){

        if !resolvedIncidentDetail.grp_by_date.isEmpty {
            self.date.text = StatusIQCommonUtil.getIncidentDateFormat(dateString: resolvedIncidentDetail.grp_by_date)
        }
        
        if let grpIncidentArray = resolvedIncidentDetail.grp_by_incidents_list, !grpIncidentArray.isEmpty && self.IncidentHistoryStackView != nil {
                self.IncidentHistoryStackView.subviews.forEach {
                    $0.removeFromSuperview()
                }
                for activeIncidentDetail in grpIncidentArray {

                    let incidentDetailView = StatusIQIncidentDetailView().instanceFromNib()
                    incidentDetailView.setValues(statusIQActiveIncidentDetails: activeIncidentDetail)
                    IncidentHistoryStackView.addArrangedSubview(incidentDetailView)
                }
            stackViewBottomConstraint.isActive = true

            self.noincidents.isHidden = true
            self.IncidentHistoryStackView.isHidden = false
            
        } else {
            if let grpByStatusMsg = resolvedIncidentDetail.grp_by_status_msg {
                if !grpByStatusMsg.isEmpty && self.noincidents != nil {
                    noincidents.text = "No incidents have been reported."
                }
                stackViewBottomConstraint.isActive = false
                self.IncidentHistoryStackView.isHidden = true
                self.noincidents.isHidden = false

            }
        }

        
    }
}


