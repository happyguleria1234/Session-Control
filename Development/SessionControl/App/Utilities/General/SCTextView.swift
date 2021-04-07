//
//  SCTextView.swift
//  SessionControl
//
//  Created by Apple on 07/04/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import Foundation
import UIKit

class SCBaseTextView: UITextView {
    
    public var fontDefaultSize : CGFloat {
        return font?.pointSize ?? 0.0
    }
    public var fontSize : CGFloat = 0.0
    
    public var padding: Double = 8
    
    private var leftEmptyView: UIView {
        return UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: padding, height: Double.zero)))
    }
    private var rightEmptyView: UIView {
        return leftEmptyView
    }
    
    override func becomeFirstResponder() -> Bool {
        HighlightLayer()
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        resetLayer()
        return super.resignFirstResponder()
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    fileprivate func setupDefault() {
        
        self.cornerRadius = SCSettings.cornerRadius
        self.borderWidth = SCSettings.borderWidth
        self.borderColor = SCColor.appWhite
        self.shadowColor = SCColor.appWhite
        self.shadowOffset = CGSize.zero
        self.shadowOpacity = SCSettings.shadowOpacity
        self.tintColor = SCColor.appWhite
        self.textColor = SCColor.appWhite
    }
    
    fileprivate func HighlightLayer() {
        self.borderColor = SCColor.appOrange
        self.tintColor = SCColor.appOrange
    }
    
    fileprivate func resetLayer() {
        self.borderColor = SCColor.appWhite
        self.tintColor = SCColor.appWhite
    }
        
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}

class SCRegularWithoutBorderTextView: UITextView {

    public var fontDefaultSize : CGFloat {
        return font?.pointSize ?? 0.0
    }
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
                
        let fontSize = getDynamicFontSize(fontDefaultSize: fontDefaultSize)
        self.font = SCFont.poppinsRegular(size: fontSize)
    }
}

class SCRegularTextView: SCBaseTextView {

    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = SCFont.poppinsRegular(size: fontSize)
    }
}

class SCBoldTextView: SCBaseTextView {

    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = SCFont.poppinsBold(size: fontSize)
    }
}

class SCStudioGenresTextView: SCRegularTextView {

    var leftUserView: UIView {
        let imgView = UIImageView(image: UIImage(named: ""))
        imgView.contentMode = .scaleAspectFit
        return imgView
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
//    func setup() {
//
//        leftView = leftUserView
//
//        self.keyboardType = .default
//        self.autocorrectionType = .no
//        self.autocapitalizationType = .words
//        self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "",
//                                                        attributes:[NSAttributedString.Key.foregroundColor: SCColor.appWhite])
//    }
    
    //------------------------------------------------------
    
    //MARK: Override
    
//    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
//        return CGRect(origin: CGPoint(x: CGFloat(padding), y: CGFloat(padding * 1.6)), size: CGSize(width: CGFloat(padding) * 6, height: bounds.height -  CGFloat(padding * 3.2)))
//    }
    
    
//
    //------------------------------------------------------
    
    //MARK: Init
    
    /// common text field layout for inputs
    ///
    /// - Parameter aDecoder: aDecoder description
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
////        setup()
//    }
}
