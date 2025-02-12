
Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "StatusIQ"
  s.version      = "1.2"
  s.summary      = "StatusIQ"
  s.swift_version = '4.0'

  s.homepage = "https://github.com/site24x7/StatusIQ-iOS-SDK.git"
  s.description  = "description"
  s.license      = { :type => "Apache", :text=> <<-LICENSE
  Apache License
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
  LICENSE

}
  #support email-id -  support@site24x7.com
  s.author = { "Site24x7" => "support@site24x7.com" }
  s.ios.deployment_target = '10.0'

  s.frameworks = 'UIKit','Foundation', 'CoreMedia'
    
    
  s.source_files = ["native/StatusIQFramework/*{swift}"] 
  s.resources = ["native/StatusIQFramework/*{xcassets,storyboard,xib}"]
  #s.exclude_files = ["StatusIQ/StatusIQFramework/*{plist}"]
  s.resource_bundles = { 'StatusIQBundle' => ['native/StatusIQFramework/*.{plist,xib,storyboard,xcassets}']}


  s.source       = { :git => "https://github.com/site24x7/StatusIQ-iOS-SDK.git", :tag => s.version.to_s} # commit ID from Authkey support

  s.module_name  = 'StatusIQ'
  s.requires_arc = true
end
