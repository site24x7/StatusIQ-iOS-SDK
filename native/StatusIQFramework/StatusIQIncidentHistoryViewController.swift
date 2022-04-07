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

import Foundation
import UIKit

public class StatusIQIncidentHistoryViewController :  UIViewController, UITableViewDataSource, UITableViewDelegate  {
   
    @IBOutlet weak var overallTable: UITableView!
    fileprivate let resolvedIncidentDetailArray = StatusIQCommonUtil.statusData.resolvedIncidentDetailArray

    override public func viewDidLoad() {
        super.viewDidLoad()
        if self.resolvedIncidentDetailArray.isEmpty {
            StatusIQAdapter.errorHandle(parentView: self.view, errorMessage: "There is no data")
        }
        self.navigationController?.navigationBar.barTintColor = StatusIQCustomization.navigationBarBackgroundColor
        self.view.backgroundColor = StatusIQCustomization.backgroundColor
        overallTable.dataSource = self
        overallTable.delegate = self
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resolvedIncidentDetailArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "IncidentHistoryOverallDetailCell", for: indexPath) as? StatusIQIncidentHistoryOverallDetailCell {
            cell.setValues(resolvedIncidentDetail: resolvedIncidentDetailArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

}


