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
public class StatusIQComponentData: NSObject {
    
    var uptime_perc : String = ""
    var total_incident_count : String = ""
    var statusHistoryArray = [[String : UIImage]]()
    
    init(withData responseData : [String: Any] ) {
        
        if let componentDetail = StatusIQCommonUtil.statusData.currentStatusArray.filter({( $0.display_name == StatusIQServiceStatus.componentName )}).first, let componentId =  componentDetail.enc_component_id{
            if let serviceDetail = responseData[componentId] as? [String: Any]{
                
                if serviceDetail["uptime_perc"] != nil, let value = serviceDetail["uptime_perc"] as? CGFloat {
                    uptime_perc = "\(value)"
                }

                if serviceDetail["total_incident_count"] != nil, let value = serviceDetail["total_incident_count"] as? UInt {
                    total_incident_count = String(value)
                }
                
                if let statusHistoryData = serviceDetail["status_history"] as? [String : AnyObject], let dayWiseStatusHistory = statusHistoryData["day_wise_status_history"] as? [AnyObject] {

                    for historyObject in dayWiseStatusHistory  {
                        if let unwrappedHistoryObject = historyObject as? [String : Any], let dateString = unwrappedHistoryObject["date"] as? String {
                            let dateFormatter =  DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

                            if let date = dateFormatter.date(from: dateString){
                                let dateComponents  = Calendar.current.dateComponents([.month, .day], from: date)
                                
                                if let  monthDayDate = Calendar.current.date(from: dateComponents){
                                    let dateformatter = DateFormatter()
                                    dateformatter.dateFormat = "MMM dd"
                                    let monthdayString  = dateformatter.string(from: monthDayDate)
                                    var statusHistoryObject : [String :UIImage ] = [:]
                                    if let statusNumber = unwrappedHistoryObject["status"] as? UInt {
                                        let statusIcon = StatusIQCommonUtil.getStatusIcon(statusInt:  statusNumber)
                                        statusHistoryObject[monthdayString] = statusIcon
                                        self.statusHistoryArray.append(statusHistoryObject)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }    
}
