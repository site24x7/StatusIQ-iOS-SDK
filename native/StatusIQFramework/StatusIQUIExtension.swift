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

extension UIActivityIndicatorView {
    func showLoading(withSuperView superView : UIView , withPosition position : CGPoint? = nil) {
        self.center = superView.center
        if let unwrappedPosition = position {
            self.center = unwrappedPosition
        }
        superView.addSubview(self)
        self.startAnimating()
    }
    
    func hideLoading() {
        self.stopAnimating()
        self.removeFromSuperview()
    }
    
    func setWindowLoading(withSuperView superView : UIView) {
        if let keyWindow = UIApplication.shared.keyWindow {
            self.showLoading(withSuperView: superView , withPosition: CGPoint(x: keyWindow.frame.size.width/2, y: keyWindow.frame.size.height/2) )
        }else {
            self.showLoading(withSuperView: superView)
        }
    }
}


extension UIView {
    
    func loadNib() -> UIView {
        let bundleName = Bundle(for: type(of: self))
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundleName)

        if let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView {
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }
        return self
    }
    
    func setCardView(){
        layer.cornerRadius = 5.0
        layer.borderColor  =  UIColor.clear.cgColor
        layer.borderWidth = 5.0
        layer.shadowOpacity = 0.5
        layer.shadowColor =  UIColor.lightGray.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width:5, height: 5)
        layer.masksToBounds = true
    }
    
    func setCardViewDesign() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = StatusIQCommonUtil.hexStringToUIColor(hex: "#EDEBEB").cgColor    }
        
    func setEmptyScreenText( placeholderLabel : UILabel , text : String , withPosition position : CGPoint? = nil) {
        placeholderLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 30)
        placeholderLabel.center = self.center
        placeholderLabel.textAlignment = .center
        if let unwrappedPosition = position {
            placeholderLabel.center = unwrappedPosition
        }
        placeholderLabel.text = text
        placeholderLabel.font =  StatusIQCommonUtil.getFont(withSize: 15)
        if !self.subviews.contains(placeholderLabel) {
            self.addSubview(placeholderLabel)
        }
    }
    
    func removeEmptyScreen(placeholderLabel : UILabel ) {
        if self.subviews.contains(placeholderLabel) {
            placeholderLabel.removeFromSuperview()
        }
    }
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
        
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .Left: border.frame = CGRect(x: 0, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.width - thickness, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: 0, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }
        layer.addSublayer(border)
    }
}

extension String {
    func size(OfFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedStringKey.font: font])
    }
}

