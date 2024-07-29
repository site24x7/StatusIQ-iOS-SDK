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
    
    public static var statusPageUrl = "https://status.site24x7.com/sp/api/u/summary_details"
    public static var isComponentStatusAlone = false
    public static var componentName = ""

    static var unwrappedStatusPageUrl =  ""
    static var unwrappedIsComponentStatusAlone =  false
    static var unwrappedComponentName =  ""
    static var unwrappedTheme : UIUserInterfaceStyle = .dark
    
    public static func sdkInit() -> UIViewController { //Via info.plist
        self.initializeVariables(isFromInfoList: true)
        return self.getStatusStoryboard()
    }
    
    public static func sdkInit(withStatusPageUrl url: String, isComponentStatusAlone: Bool = false, withComponentName componentName: String = "", withTheme theme: UIUserInterfaceStyle = .light) -> UIViewController { //Via method
        self.unwrappedStatusPageUrl = url
        self.unwrappedIsComponentStatusAlone = isComponentStatusAlone
        self.unwrappedComponentName = componentName
        
        self.unwrappedTheme = theme

        self.initializeVariables(isFromInfoList: false)
        return self.getStatusStoryboard()
    }
    
    private static func getStatusStoryboard() -> UIViewController {
        let storyboard = UIStoryboard(name: "StatusIQStoryboard", bundle: StatusIQCommonUtil.getBundle())
        var mainVC = UIViewController()
        
        if self.isComponentStatusAlone {
            mainVC = storyboard.instantiateViewController(withIdentifier: "StatusIQIdentifier")
        }else {
            mainVC = storyboard.instantiateViewController(withIdentifier: "StatusIQPageIdentifier")

//            if let statusIQPageVC = storyboard.instantiateViewController(withIdentifier: "StatusIQPageIdentifier") as? StatusIQPageViewController {
//                mainVC = statusIQPageVC
//            }
        }
        mainVC.overrideUserInterfaceStyle = self.unwrappedTheme
        mainVC.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        return mainVC
    }
    
    private static func initializeVariables(isFromInfoList : Bool) {
        if isFromInfoList {
            if let bundle = StatusIQCommonUtil.getBundle() {
                if let path = bundle.path(forResource: "StatusIQInfo", ofType: "plist") {
                    if let dictionary = NSDictionary(contentsOfFile: path) {
                        if let unwrappedstatusPageUrl = dictionary["Status page url"] as? String {
                            self.statusPageUrl = unwrappedstatusPageUrl
                        }
                        if let unwrappedfetchComponent = dictionary["Show Component status alone"] as? Bool{
                            self.isComponentStatusAlone = unwrappedfetchComponent
                        }
                        if let unwrappedcomponentName = dictionary["Component Name"] as? String {
                            self.componentName = unwrappedcomponentName
                        }
                        if let unwrappedTheme = dictionary["Theme"] as? Int {
                            self.unwrappedTheme = UIUserInterfaceStyle(rawValue: unwrappedTheme) ?? .light
                        }
                    }
                }
            }
        } else {
            self.statusPageUrl = self.unwrappedStatusPageUrl
            self.isComponentStatusAlone = self.unwrappedIsComponentStatusAlone
            self.componentName = self.unwrappedComponentName
        }
        
        if !self.statusPageUrl.isEmpty {
            if !self.statusPageUrl.contains("sp/api/u/summary_details") {
                if !(self.statusPageUrl.last == "/") {
                    self.statusPageUrl += "/"
                }
                self.statusPageUrl += "sp/api/u/summary_details"
            }
        }
    }
    
}


