//
//  TFRequestView.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 3/4/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import Foundation
import UIKit

enum RequestStatus: String {
    
    case pending = "Pending"
    case approved = "Approved"
    case declined = "Declined"
}

class SCRequestView: UIView {

    var status: RequestStatus = .pending {
        didSet {
            switch status {
            case .pending:
                self.backgroundColor = SCColor.pending
            case .approved:
                self.backgroundColor = SCColor.approved
            case .declined:
                self.backgroundColor = SCColor.declined
            }
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        
        self.cornerRadius = SCSettings.cornerRadius
        self.shadowOffset = CGSize.zero
        self.shadowOpacity = SCSettings.shadowOpacity
                
        self.clipsToBounds = true
        status = .pending
    }
    
    //------------------------------------------------------
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    //------------------------------------------------------
}
