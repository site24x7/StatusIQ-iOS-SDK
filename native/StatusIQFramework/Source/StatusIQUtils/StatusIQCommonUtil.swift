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

public class StatusIQCommonUtil: NSObject {
    
    public static var statusData = StatusIQBuilder(withData: [:])
    
    private static var OPERATIONAL : String = "Operational"
    private static var MAJOR_OUTAGE : String = "Major-outage"
    private static var MAINTENENCE : String = "Maintenance"
    private static var DEGRADED_PERFORMANCE : String = "Degraded-performance"
    private static var PARTIAL_OUTAGE : String = "Partial-outage"
    private static var SUSPENDED : String = "Suspendes"
    private static var INPROGRESS : String = "In-progress"
    private static var INFORMATIONAL : String = "Informational"
    
    private static var DEGRADED_COLOR :String = "#FFC050"
    private static var OUTAGE_COLOR :String = "#e94a35"
    private static var MAINTENANCE_COLOR :String = "#438bce"
    private static var PARTIAL_OUTAGE_COLOR :String = "#E99500"
    private static var OPERATIONAL_COLOR :String = "#F97260"
    private static var INFORMATIONAL_COLOR :String = "#70747c"
    
    public static func getBundle() -> Bundle? {
        let url = Bundle(for: self.self).url(forResource: "StatusIQ", withExtension: "bundle")
        if let unwrappedUrl = url, let unwrappedBundle = Bundle(url: unwrappedUrl) {
            return unwrappedBundle
        }
        return nil
    }
    
    public static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    public static func getFont(withSize size : CGFloat, isBold : Bool = false) -> UIFont {
        if StatusIQCustomization.fontName.isEmpty {
            if isBold {
                return UIFont.boldSystemFont(ofSize: size)
            }
            return UIFont.systemFont(ofSize: size)
        }else {
            var unwrappedFontName = StatusIQCustomization.fontName
            if isBold {
                unwrappedFontName += "-Bold"
            }
            return UIFont(name: unwrappedFontName, size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
    
    public static func  getIncidentDateFormat(dateString: String) ->String {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateString){
            let dateComponents  = Calendar.current.dateComponents([.year,.month, .day], from: date)
            
            if let  monthDayDate = Calendar.current.date(from: dateComponents) {
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "MMM dd, yyyy"
                let monthdayString  = dateformatter.string(from: monthDayDate)
                return monthdayString
            }
        }
        return ""
    }
    
    public static func  getIncidentDurationDateFormat(dateString: String) ->String {
        //2021-02-11T17:39:34-1200
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if !dateString.isEmpty, let date = dateFormatter.date(from: dateString) {
            let dateComponents  = Calendar.current.dateComponents([.year,.month, .day,.hour,.minute,.second,.timeZone], from: date)
            
            if let  monthDayDate = Calendar.current.date(from: dateComponents) {
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "MMM dd, yyyy HH:MM z"
                //dateformatter.timeZone = TimeZone(abbreviation: "UTC")
                //dateformatter.timeStyle = .medium
                let monthdayString  = dateformatter.string(from: monthDayDate)
                return monthdayString
            }
        }
        return ""
    }

    
    public static func getStatusString(statusInt : UInt) -> String {
        switch(statusInt) {
        case 1 :
            return OPERATIONAL
        case 2 :
            return INFORMATIONAL
        case 3 :
            return DEGRADED_PERFORMANCE
        case 4 :
            return MAINTENENCE
        case 5 :
            return PARTIAL_OUTAGE
        case 6 :
            return MAJOR_OUTAGE
        default :
            return OPERATIONAL
        }
    }
    
    public static func getStatusUIColor(statusInt : UInt) -> UIColor {
        switch(statusInt) {
        case 1 :
            return hexStringToUIColor(hex:  OPERATIONAL_COLOR)
        case 2 :
            return hexStringToUIColor(hex: INFORMATIONAL_COLOR)
        case 3 :
            return hexStringToUIColor(hex: DEGRADED_COLOR)
        case 4 :
            return hexStringToUIColor(hex: MAINTENANCE_COLOR)
        case 5 :
            return hexStringToUIColor(hex: PARTIAL_OUTAGE_COLOR)
        case 6 :
            return hexStringToUIColor(hex: OUTAGE_COLOR)
        default :
            return hexStringToUIColor(hex: OPERATIONAL_COLOR)
        }
    }
    
    public static func selectStatusStringUIColor(statusString : String) -> UIColor {
        switch(statusString) {
        case OPERATIONAL :
            return hexStringToUIColor(hex:  OPERATIONAL_COLOR)
        case INFORMATIONAL :
            return hexStringToUIColor(hex: INFORMATIONAL_COLOR)
        case DEGRADED_PERFORMANCE :
            return hexStringToUIColor(hex: DEGRADED_COLOR)
        case MAINTENENCE :
            return hexStringToUIColor(hex: MAINTENANCE_COLOR)
        case PARTIAL_OUTAGE :
            return hexStringToUIColor(hex: PARTIAL_OUTAGE_COLOR)
        case MAJOR_OUTAGE :
            return hexStringToUIColor(hex: OUTAGE_COLOR)
        default :
            return hexStringToUIColor(hex: OPERATIONAL_COLOR)
        }
    }
    
    public static func getStatusIcon(statusInt : UInt) -> UIImage {
        var statusName = ""
        
        switch(statusInt) {
        case 1 :
            statusName = "operational"
        case 2 :
            statusName = "informational"
        case 3 :
            statusName = "degraded-performance"
        case 4 :
            statusName = "maintenenace"
        case 5 :
            statusName = "partial-outage"
        case 6 :
            statusName = "major-outage"
        default :
            statusName = "operational"
        }
        return UIImage(named: statusName, in: StatusIQCommonUtil.getBundle(), compatibleWith: .none) ?? UIImage()
    }
    
    public static func getIncidentStatusIcon(incidentStatusID : UInt) -> UIImage {
        var statusIncidentName = ""

        switch(incidentStatusID) {
        case 10 :
            statusIncidentName = "acknowledged"
        case 11 :
            statusIncidentName = "investigating"
        case 12 :
            statusIncidentName = "identified"
        case 13 :
            statusIncidentName = "monitoring"
        case 14 :
            statusIncidentName = "resolved"
        case 21 :
            statusIncidentName = "scheduled"
        case 22 :
            statusIncidentName = "progress"
        case 23 :
            statusIncidentName = "monitoring"
        case 24 :
            statusIncidentName = "completed"
        default :
            statusIncidentName = "acknowledged"
        }
        
        return UIImage(named: statusIncidentName, in: StatusIQCommonUtil.getBundle(), compatibleWith: .none) ?? UIImage()
    }
    
    public static func getTimeZone() -> String{
        var timeZoneString : String = ""
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if !statusData.updatedAt.isEmpty {
            if let date = dateFormatter.date(from: statusData.updatedAt) {
                let dateComponents  = Calendar.current.dateComponents([.year,.month, .day,.hour,.minute,.second,.timeZone], from: date)
                if let  monthDayDate = Calendar.current.date(from: dateComponents) {
                    
                    let dateformatter = DateFormatter()
                    dateformatter.dateFormat = "z"
                    //dateformatter.timeZone = TimeZone(abbreviation: "GMT")
                    dateformatter.timeStyle = .full
                    
                    let monthdayString  = dateformatter.string(from: monthDayDate)
                    
                    if let range = monthdayString.range(of: "M ") {
                        timeZoneString = String(describing: monthdayString[range.upperBound...])
                    }
                }
            }
        }
        return timeZoneString
    }

    public static func getElapsedInterval(dateString : String) -> String {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if !dateString.isEmpty, let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
                let now = Date()
                let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .month, .year]
                let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
            
                if let year = components.year, year >= 2 {
                    return "\(year) years ago"
                }
                
                if let year = components.year, year >= 1 {
                    return "Last year"
                }
                
                if let month = components.month, month >= 2 {
                    return "\(month) months ago"
                }
                
                if let month = components.month, month >= 1 {
                    return "Last month"
                }
                
                if let day = components.day, day >= 2 {
                    return "\(day) days ago"
                }
                
                if let day = components.day, day >= 1 {
                    return "Yesterday"
                }
                
                if let hour = components.hour, hour >= 2 {
                    return "\(hour) hours ago"
                }
                
                if let hour = components.hour, hour >= 1 {
                    return "An hour ago"
                }
                
                if let minute = components.minute, minute >= 2 {
                    return "\(minute) minutes ago"
                }
                
                if let minute = components.minute, minute >= 1 {
                    return "A minute ago"
                }
                
                if let second = components.second, second >= 3 {
                    return "\(second) seconds ago"
                }
                
                return "Just now"
        }
        return ""
    }
    
    public static func resetStatusData() {
        statusData = StatusIQBuilder(withData: [:])
    }
}
