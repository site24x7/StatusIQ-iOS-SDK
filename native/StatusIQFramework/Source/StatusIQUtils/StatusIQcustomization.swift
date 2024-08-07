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

public class StatusIQCustomization: NSObject {
//    public static var backgroundColor : UIColor = StatusIQCommonUtil.hexStringToUIColor(hex : "#F7F7F7")
    
    public static var backgroundColor : UIColor = UIColor(named: "StatusIQPrimaryBGColor", in: StatusIQCommonUtil.getBundle(), compatibleWith: nil) ?? UIColor()
    
//    public static var navigationBarBackgroundColor : UIColor = UIColor.white
    public static var navigationBarBackgroundColor : UIColor = UIColor(named: "StatusIQNavigationBarBackgroundColor", in: StatusIQCommonUtil.getBundle(), compatibleWith: nil) ?? UIColor()

    public static var fontName : String = "" //"Verdana"
    
    public static func setBackgroundColor(bgColor : UIColor = StatusIQCommonUtil.hexStringToUIColor(hex : "#ebebeb")) {
        self.backgroundColor = bgColor
    }

    public static func setNavigationBarBackgroundColor(barColor : UIColor = StatusIQCustomization.navigationBarBackgroundColor) {
        self.navigationBarBackgroundColor = barColor
    }
    
    public static func setFontName(fontName : String) {
        self.fontName = fontName
    }
}



