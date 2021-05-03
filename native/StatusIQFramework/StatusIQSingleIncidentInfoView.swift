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

class StatusIQSingleIncidentInfoView: UIView {
    
    @IBOutlet var statusImageView: UIImageView!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var statusDescription: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!

    func instanceFromNib() -> StatusIQSingleIncidentInfoView {
        if let incidentDetailView = self.loadNib() as? StatusIQSingleIncidentInfoView {
            return incidentDetailView
        }
        
        return self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }
    
    fileprivate func setFont() {
        self.statusLabel.font = StatusIQCommonUtil.getFont(withSize: 15, isBold: true)
        self.statusDescription.font = StatusIQCommonUtil.getFont(withSize: 15)
        self.dateLabel.font = StatusIQCommonUtil.getFont(withSize: 13)
        self.durationLabel.font = StatusIQCommonUtil.getFont(withSize: 13)
    }
    
    func setValues(incidentUpdatesObject : incidentStatusUpdate) {
        self.statusImageView.image = StatusIQCommonUtil.getIncidentStatusIcon(incidentStatusID: incidentUpdatesObject.incident_status_id)
        self.statusLabel.text = incidentUpdatesObject.incident_status
        self.statusDescription.text = incidentUpdatesObject.incident_status_desc
        self.dateLabel.text = "Posted on \(StatusIQCommonUtil.getIncidentDurationDateFormat(dateString: (incidentUpdatesObject.status_updated_at)))"
        self.durationLabel.text = StatusIQCommonUtil.getElapsedInterval(dateString: incidentUpdatesObject.status_updated_at) 
    }
    

}
