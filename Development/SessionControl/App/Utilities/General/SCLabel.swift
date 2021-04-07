//
//  SCLabel.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit

class SCBaseLabel: UILabel {

    private var fontDefaultSize: CGFloat {
        return font.pointSize
    }
    
    public var fontSize: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
       fontSize = getDynamicFontSize(fontDefaultSize: fontDefaultSize)
    }
}

class SCRegularLabel: SCBaseLabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = SCFont.poppinsRegular(size: self.fontSize)
    }
}

class SCSemiBoldLabel: SCBaseLabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = SCFont.poppinsBold(size: self.fontSize)
    }
}

class SCBoldLabel: SCBaseLabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.font = SCFont.poppinsBold(size: self.fontSize)
    }
}
