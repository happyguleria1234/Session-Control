//
//  SessionConfirmedCell.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 4/1/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit

class SessionConfirmedCell: UITableViewCell {

    @IBOutlet weak var btnPayNow: SCActiveButton!
    
    //------------------------------------------------------
    
    //MARK: Init
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        selectionStyle = .none
    }
    
    //------------------------------------------------------
}
