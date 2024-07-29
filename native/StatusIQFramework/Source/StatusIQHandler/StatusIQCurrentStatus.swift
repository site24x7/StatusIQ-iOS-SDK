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

struct StatusIQCurrentStatus: Codable {
    
    var enc_componentgroup_id  : String? = ""
    var enc_component_id : String? = ""
    var co_permalink : String?

    var componentgroup_display_name : String?
    var display_name : String? = ""
    var last_polled_time : String? = ""
    var componentgroup_status  : UInt?
    var component_status : UInt?
    var isGroupExpand : Bool? = false
    var isChildElement : Bool? = false
    var isChildBorderNotNeed : Bool? = false

    var componentgroup_components : [StatusIQCurrentStatus]? // the component group inside data

}
