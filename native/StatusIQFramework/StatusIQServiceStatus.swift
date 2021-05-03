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

public class StatusIQServiceStatus: NSObject {
    
    public static var statusPageUrl : String = "https://testsp.site24x7signals.com/sp/api/u/summary_details"
    public static var componentName : String = ""
    public static var fetchComponent : Bool = false
        
    public static func sdkInit() -> UIViewController {
        self.initializeVariables()
        let storyboard = UIStoryboard(name: "StatusIQStoryboard", bundle: StatusIQCommonUtil.getBundle())

        if self.fetchComponent || !self.componentName.isEmpty{
            let componentDetailVC = storyboard.instantiateViewController(withIdentifier: "StatusIQPageIdentifier")
            let componentDetailNavVC = UINavigationController(rootViewController: componentDetailVC)
            componentDetailNavVC.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            return componentDetailNavVC
        }else {
            if let sdkStoryboard = storyboard.instantiateInitialViewController() {
                sdkStoryboard.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
                return sdkStoryboard
            }
        }
        return UIViewController()
    }
    
    private static func initializeVariables() {
        if let bundle = StatusIQCommonUtil.getBundle() {
            if let path = bundle.path(forResource: "StatusIQInfo", ofType: "plist") {
                if let dictionary = NSDictionary(contentsOfFile: path) {
                    if let unwrappedstatusPageUrl = dictionary["Status page url"] as? String {
                        statusPageUrl = unwrappedstatusPageUrl
                        if !unwrappedstatusPageUrl.contains("sp/api/u/summary_details") {
                            if !(unwrappedstatusPageUrl.last == "/") {
                                statusPageUrl += "/"
                            }
                            statusPageUrl += "sp/api/u/summary_details"
                        }
                    }
                    if let unwrappedfetchComponent = dictionary["Show Component status alone"] as? Bool{
                        fetchComponent = unwrappedfetchComponent
                    }
                    if let unwrappedcomponentName = dictionary["Component Name"] as? String {
                        componentName = unwrappedcomponentName
                    }
                }
            }
        }
    }
}


