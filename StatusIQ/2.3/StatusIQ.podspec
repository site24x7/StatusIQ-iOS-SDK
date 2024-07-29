Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "StatusIQ"
  s.version      = "2.3"
  s.summary      = "StatusIQ"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.homepage = "https://github.com/site24x7/StatusIQ-iOS-SDK.git"
  s.description  = "description"
  s.license      = { :type => "MIT", :text=> <<-LICENSE
  MIT License

  Copyright (c) 2024 Zoho

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in allcd 
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE
  LICENSE
}
  s.author       = { "nandhini guru" => "nandhini.guru@zohocorp.com" ,"Muralikrishnan" => "muralikrishnan@zohocorp.com"}
  s.ios.deployment_target = '14.0'
  s.swift_version = '4.0'


  s.frameworks = 'UIKit','Foundation', 'CoreMedia'
    
  s.source_files = ['native/StatusIQFramework/*{swift}', 'native/StatusIQFramework/Source/ComponentSummary/*{swift}', 'native/StatusIQFramework/Source/IncidentHistory/*{swift}', 'native/StatusIQFramework/Source/StatusIQComponentAlone/*{swift}', 'native/StatusIQFramework/Source/StatusIQHandler/*{swift}', 'native/StatusIQFramework/Source/StatusIQUtils/*{swift}' ]
  
  s.resources = ['native/StatusIQFramework/Resource/*{xcassets,storyboard}', 'native/StatusIQFramework/Source/IncidentHistory/*{xib}', 'native/StatusIQFramework/Source/StatusIQComponentAlone/*{xib}']
    
  s.resource_bundles = { 'StatusIQBundle' => ['native/StatusIQFramework/Resource/*.{plist,storyboard,xcassets}', 'native/StatusIQFramework/Source/IncidentHistory/*{xib}', 'native/StatusIQFramework/Source/StatusIQComponentAlone/*{xib}']}

  s.source       = { :git => "https://github.com/site24x7/StatusIQ-iOS-SDK.git", :tag => s.version.to_s} # commit ID from Authkey support

  s.module_name  = 'StatusIQ'
  s.requires_arc = true
end
