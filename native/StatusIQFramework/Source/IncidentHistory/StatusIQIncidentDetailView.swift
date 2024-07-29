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

class StatusIQIncidentDetailView: UIView {
    
    @IBOutlet weak var IncidentTitle: UILabel!
    @IBOutlet weak var incidentStartTimeTitle: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet var affectedComponentsTitle: UILabel!
    @IBOutlet weak var components: UILabel!
    @IBOutlet var incidentStatusUpdatesTitle: UILabel!
    @IBOutlet var updateIncidentStackView: UIStackView!
    
    func instanceFromNib() -> StatusIQIncidentDetailView {
        if let incidentDetailView = self.loadNib() as? StatusIQIncidentDetailView {
            return incidentDetailView
        }
        
        return self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFont()
    }
    
    fileprivate func setFont() {
        self.IncidentTitle.font = StatusIQCommonUtil.getFont(withSize: 17, isBold: true)
        self.incidentStartTimeTitle.font = StatusIQCommonUtil.getFont(withSize: 17, isBold: true)
        self.time.font = StatusIQCommonUtil.getFont(withSize: 14)
        self.affectedComponentsTitle.font = StatusIQCommonUtil.getFont(withSize: 17, isBold: true)
        self.components.font = StatusIQCommonUtil.getFont(withSize: 14)
        self.incidentStatusUpdatesTitle.font = StatusIQCommonUtil.getFont(withSize: 17, isBold: true)
    }
    
    
    func setValues(statusIQActiveIncidentDetails : StatusIQActiveIncidentDetails) {
        
        if let unwrappedincidentStatusUpdateArray = statusIQActiveIncidentDetails.incident_status_updates {
            for incidentStatusUpdate in unwrappedincidentStatusUpdateArray {
                let incidentUpdateView = StatusIQSingleIncidentInfoView().instanceFromNib()
                incidentUpdateView.setValues(incidentUpdatesObject: incidentStatusUpdate)
                updateIncidentStackView.addArrangedSubview(incidentUpdateView)
            }
        }
        self.IncidentTitle.text = statusIQActiveIncidentDetails.incident_title
        self.IncidentTitle.textColor = StatusIQCommonUtil.getStatusUIColor(statusInt: statusIQActiveIncidentDetails.incident_severity_id)
        self.time.text = StatusIQCommonUtil.getIncidentDurationDateFormat(dateString:  statusIQActiveIncidentDetails.incident_began_at ?? "")
        self.time.setCardView()

        if let affectedComponentsArray = statusIQActiveIncidentDetails.incident_affected_components {
            let displayNameArray = affectedComponentsArray.map { $0.display_name }
            let affectedComponentsString = displayNameArray.joined(separator: ", ") // "1, 2, 3"
            self.components.text = affectedComponentsString
        }
        
    }
}
