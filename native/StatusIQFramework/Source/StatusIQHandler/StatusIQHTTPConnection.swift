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

public class StatusIQHTTPConnection: NSObject {

    public static func getDataFromServer(url : String, callback: @escaping (Any ,Error?) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if let  unwrappedData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: unwrappedData)
                    callback(json, error)
                } catch {
                   callback("", error)
                }
            }else {
                callback("", error)
            }
        })
        task.resume()
    }
}
