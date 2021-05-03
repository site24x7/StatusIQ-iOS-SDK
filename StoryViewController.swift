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

class StoryViewController: UIViewController {
    
    @IBOutlet var detailTextView: UITextView!
    var currentPageTag = "1"
    
    fileprivate let freedomFightersData = [
        
        "1" : "\n\tCloud computing is the delivery of on-demand computing services -- from applications to storage and processing power -- typically over the internet and on a pay-as-you-go basis.\n\n How does cloud computing work?\nRather than owning their own computing infrastructure or data centers, companies can rent access to anything from applications to storage from a cloud service provider.\nOne benefit of using cloud computing services is that firms can avoid the upfront cost and complexity of owning and maintaining their own IT infrastructure, and instead simply pay for what they use, when they use it.\nIn turn, providers of cloud computing services can benefit from significant economies of scale by delivering the same services to a wide range of customers.",
                                           
        "2" : "\n\tThe public cloud refers to the cloud computing model in which IT services are delivered via the internet. As the most popular model of cloud computing services, the public cloud offers vast choices in terms of solutions and computing resources to address the growing needs of organizations of all sizes and verticals.\n\nServices on the public cloud may be free, freemium, or subscription-based, wherein you’re charged based on the computing resources you consume.The computing functionality may range from common services—email, apps, and storage—to the enterprise-grade OS platform or infrastructure environments used for software development and testing.\n\nThe cloud vendor is responsible for developing, managing, and maintaining the pool of computing resources shared between multiple tenants from across the network.",
        
        "3" : "\n\tThe private cloud refers to any cloud solution dedicated for use by a single organization. In the private cloud, you’re not sharing cloud computing resources with any other organization.\n\nThe data center resources may be located on-premise or operated by a third-party vendor off-site. The computing resources are isolated and delivered via a secure private network, and not shared with other customers.\n\nPrivate cloud is customizable to meet the unique business and security needs of the organization. With greater visibility and control into the infrastructure, organizations can operate compliance-sensitive IT workloads without compromising on the security and performance previously only achieved with dedicated on-premise data centers.",
    
        "4" : "\n\tThe hybrid cloud is any cloud infrastructure environment that combines both public and private cloud solutions.The resources are typically orchestrated as an integrated infrastructure environment. Apps and data workloads can share the resources between public and private cloud deployment based on organizational business and technical policies.\n\nThis is a common example of hybrid cloud: Organizations can use private cloud environments for their IT workloads and complement the infrastructure with public cloud resources to accommodate occasional spikes in network traffic.\n\nOr, perhaps you use the public cloud for workloads and data that aren’t sensitive, saving cost, but opt for the private cloud for sensitive data.\n\nAs a result, access to additional computing capacity does not require the high CapEx of a private cloud environment but is delivered as a short-term IT service via a public cloud solution. The environment itself is seamlessly integrated to ensure optimum performance and scalability to changing business needs.",
        
        "5" : "\n\t\"Multicloud\" means multiple public clouds. A company that uses a multicloud deployment incorporates multiple public clouds from more than one cloud provider. Instead of a business using one vendor for cloud hosting, storage, and the full application stack, in a multicloud configuration they use several.\n\nMulticloud deployments have a number of uses. A multicloud deployment can leverage multiple IaaS (Infrastructure-as-a-Service) vendors, or it could use a different vendor for IaaS, PaaS (Platform-as-a-Service), and SaaS (Software-as-a-Service) services. Multicloud can be purely for the purpose of redundancy and system backup, or it can incorporate different cloud vendors for different services."
    ]
    
    fileprivate let freedomFighterNames = ["1" : "What is Cloud computing?", "2" : "Public Cloud", "3" : "Private Cloud", "4" : "Hybrid Cloud", "5" : "Multi Cloud"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.freedomFighterNames[self.currentPageTag]
        self.detailTextView.text = self.freedomFightersData[self.currentPageTag]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
