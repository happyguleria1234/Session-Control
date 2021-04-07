//
//  SavedTracksCell.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 3/4/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblName: SCRegularLabel!
    @IBOutlet weak var imgDisclosureIndicator: UIImageView!
    
    var isDisclosureIndicatorVisible: Bool = true {
        didSet {
            imgDisclosureIndicator.isHidden = !isDisclosureIndicatorVisible
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup(image: String, name: String?) {
        
        imgIcon.image = UIImage(named: image)
        lblName.text = name
        
        if name == ProfileVC.ProfileItems.logout {
            isDisclosureIndicatorVisible = false
        } else {
            isDisclosureIndicatorVisible = true
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        accessoryType = .none
        selectionStyle = .none
    }
    
    //------------------------------------------------------
}
