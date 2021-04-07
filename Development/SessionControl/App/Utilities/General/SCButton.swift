//
//  PMButton.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import Foundation
import UIKit

class SCBaseButton: UIButton {

    var fontDefaultSize : CGFloat {
        return self.titleLabel?.font.pointSize ?? 0.0
    }
    var fontSize : CGFloat = 0.0
    
    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fontSize = getDynamicFontSize(fontDefaultSize: fontDefaultSize)
    }
}

class SCRegularButton: SCBaseButton {

    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.titleLabel?.font = SCFont.poppinsRegular(size: self.fontSize)
        self.imageView?.contentMode = .scaleAspectFit
    }
}

class SCSemiBoldButton: SCBaseButton {

    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.titleLabel?.font = SCFont.poppinsBold(size: self.fontSize)
        self.imageView?.contentMode = .scaleAspectFit
    }
}

class SCBoldButton: SCBaseButton {

    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.titleLabel?.font = SCFont.poppinsBold(size: self.fontSize)
        self.imageView?.contentMode = .scaleAspectFit
    }
}

class SCRememberMeButton: SCRegularButton {

    var isRemeber: Bool = false {
        didSet {
            if isRemeber {
                self.setImage(UIImage(named: SCImageName.iconChecked), for: .normal)
            } else {
                self.setImage(UIImage(named: SCImageName.iconUnchecked), for: .normal)
            }
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        isRemeber = false
        
        let padding: CGFloat = 4
        imageEdgeInsets = UIEdgeInsets(top: padding, left: CGFloat.zero, bottom: padding, right: padding)
        
        addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @objc func click(_ sender: SCRememberMeButton) {
        sender.isRemeber.toggle()
    }
    
    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
}

class SCActiveButton: SCRegularButton {

    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
                
        self.cornerRadius = SCSettings.cornerRadius
        self.shadowOffset = CGSize.zero
        self.shadowOpacity = SCSettings.shadowOpacity
        
        self.backgroundColor = SCColor.appOrange
        //self.setBackgroundImage(UIImage(named: TFImageName.background), for: .normal)
        self.clipsToBounds = true
    }
    
    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
             
       setup()
    }
}

class SCDeactiveButton: SCRegularButton {

    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
                
        self.cornerRadius = SCSettings.cornerRadius
        self.shadowOffset = CGSize.zero
        self.shadowColor = SCColor.appOrange
        self.shadowOpacity = SCSettings.shadowOpacity
        self.borderWidth = SCSettings.borderWidth
        self.borderColor = SCColor.appOrange
            
        self.backgroundColor = SCColor.appFont
        //self.setBackgroundImage(UIImage(named: TFImageName.background), for: .normal)
        self.clipsToBounds = true
    }
    
    /// common lable layout
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
             
       setup()
    }
}
