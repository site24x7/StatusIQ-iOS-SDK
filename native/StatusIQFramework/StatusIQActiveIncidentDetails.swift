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

struct StatusIQActiveIncidentDetails: Codable {  // active incident details 
    
    var incident_desc : String = ""
    var incident_title : String = ""
    var incident_severity : String = ""
    var incident_severity_id : UInt = 0
    var incident_type : UInt = 0
    var enc_inc_id : String = ""
    var email_sent_count : UInt = 0
    var incident_began_at : String?
    var incident_ended_at : String?
    var created_by : UInt = 0
    var sms_sent_count : UInt = 0
    var incident_status_updates : [incidentStatusUpdate]?
    var incident_affected_components : [incidentAffectedComponents]?
    var isExpand : Bool? = false

}

struct incidentStatusUpdate : Codable {
    var incident_status : String = ""
    var incident_status_desc : String = ""
    var email_sent_count : UInt = 0
    var incident_status_id : UInt = 0
    var status_updated_at : String = ""
    var enc_inc_state_progress_id : String = ""
    var sms_sent_count : UInt = 0
}

struct incidentAffectedComponents : Codable{
    var display_name = ""
}
