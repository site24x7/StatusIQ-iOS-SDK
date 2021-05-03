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

public class StatusIQBuilder: NSObject {
    var activeIncidentDetailArray  = [StatusIQActiveIncidentDetails]()
    var currentStatusArray  = [StatusIQCurrentStatus]()
    var resolvedIncidentDetailArray  = [StatusIQResolvedIncidentDetails]()
    var updatedAt : String = ""
    var servicePageEncID = ""
    var statusPageOverallStatus = ""
    var statusPageOverallStatusDesc = ""
//    var statusHistoryDetailArray  = ""
//    var maintainanceDetail  = ""
//    var statusPageDetail  = ""
    
    init(withData data : [String: Any] ) {
        if let activeIncidentDetails = data["active_incident_details"] as? [[String : Any]]{
            self.activeIncidentDetailArray = []
            self.activeIncidentDetailArray = StatusIQAdapter.parseJsonData(responseData: activeIncidentDetails, dataStructObj: StatusIQActiveIncidentDetails.self)
        }
        
        if let currentStatus = data["current_status"] as? [[String : Any]]{
            self.currentStatusArray = []
            self.currentStatusArray = StatusIQAdapter.parseJsonData(responseData: currentStatus, dataStructObj: StatusIQCurrentStatus.self)
        }

        if let resolvedIncidentDetails = data["resolved_incident_details"] as? [[String : Any]]{
            self.resolvedIncidentDetailArray = []
            self.resolvedIncidentDetailArray = StatusIQAdapter.parseJsonData(responseData: resolvedIncidentDetails, dataStructObj: StatusIQResolvedIncidentDetails.self)
        }
        if let statuspage_details = data["statuspage_details"] as? [String : AnyObject] {
            if let updatedAt = statuspage_details["updated_at"] as? String {
                self.updatedAt = updatedAt
            }
            if let enc_statuspage_id = statuspage_details["enc_statuspage_id"] as? String {
                self.servicePageEncID = enc_statuspage_id
            }
            
            if let current_status = statuspage_details["current_status"] as? [String : AnyObject] {
                if let statusPageOverallStatusDesc = current_status["description"] as? String {
                    self.statusPageOverallStatusDesc = statusPageOverallStatusDesc
                }
                if let statusPageOverallStatus = current_status["severity"] as? String {
                    self.statusPageOverallStatus = statusPageOverallStatus
                }
            }
        }
    }


}
