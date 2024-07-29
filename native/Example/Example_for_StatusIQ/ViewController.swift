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
import StatusIQ

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var slideMenu: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.slideMenu.isHidden = true
    }
  
    @IBAction func openMenu(_ sender: Any) {
        self.slideMenu.isHidden = !self.slideMenu.isHidden
    }
    
    @IBAction func menuSideButtonAction(_ sender: UIButton) {
        slideMenu.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let storyVC  = storyboard.instantiateViewController(withIdentifier: "storyPageIdentfier") as? StoryViewController {
            let storyVCNavVC = UINavigationController(rootViewController: storyVC)
            storyVCNavVC.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency

            storyVC.currentPageTag = "\(sender.tag)"
            self.present(storyVCNavVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func serviceStatusAction(_ sender: Any) {
        slideMenu.isHidden = true
        let VC = StatusIQServiceStatus.sdkInit(withStatusPageUrl: "https://status.site24x7.com", withTheme: .dark)
        present(VC, animated: true, completion: nil)
    }
    
}

