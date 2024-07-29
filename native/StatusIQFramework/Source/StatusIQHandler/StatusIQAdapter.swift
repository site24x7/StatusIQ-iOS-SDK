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

public class StatusIQAdapter: NSObject {

    public static func statusDataHandling(responseData : Any) -> StatusIQBuilder {
        if let dataDict =  responseData as? [String :Any] {
            if let data = dataDict["data"] as? [String : Any] {
                let statusIQBuilder = StatusIQBuilder(withData: data)
                StatusIQCommonUtil.statusData = statusIQBuilder
                return statusIQBuilder
            }
        }
        return StatusIQBuilder(withData: [:])
    }
    
    public static func componentDataHandling(responseData : Any) -> StatusIQComponentData   {
        if let dataDict =  responseData as? [String :Any] {
            if let data = dataDict["data"] as? [String : Any] {
                let StatusIQBuilder = StatusIQComponentData(withData: data)
                return StatusIQBuilder
            }
        }
        return StatusIQComponentData(withData: [:])
    }
    
    public static func parseJsonData<T : Codable>(responseData: [[String : Any]], dataStructObj : T.Type) -> [T] {
        var structObjArray = [T]()
        if  let jsonData = try? JSONSerialization.data(withJSONObject:responseData) {
            let decoder = JSONDecoder()
            do {
                let unwrappedStructObjArray = try decoder.decode([T].self, from: jsonData)
                structObjArray = unwrappedStructObjArray
            } catch {
            }
        }
        return structObjArray
    }
    
    public static func errorHandle(parentView : UIView, errorMessage : String = "Oops! Something went wrong, please try again later") {
        DispatchQueue.main.async {
            let imageError  =  UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            imageError.center =  CGPoint(x: parentView.center.x, y: parentView.center.y - 80)
            imageError.image = UIImage(named: "exclamation-mark", in: StatusIQCommonUtil.getBundle(), compatibleWith: .none)
            parentView.addSubview(imageError)

            let label = UILabel(frame: CGRect(x: 0, y: 0, width: parentView.frame.size.width - 100, height: 100))
            label.center = CGPoint(x: parentView.center.x, y: parentView.center.y - 30)
            label.numberOfLines = 2
            label.textAlignment = .center
            label.text = errorMessage //"Sorry, unable to fetch service status"
            label.textColor = UIColor.gray
            parentView.addSubview(label)
        }
    }
}
