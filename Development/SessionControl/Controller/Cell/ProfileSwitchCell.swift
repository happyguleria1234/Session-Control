//
//  ProfileSwitchCell.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 3/31/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit

class ProfileSwitchCell: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblName: SCRegularLabel!
    @IBOutlet weak var switchPermission: UISwitch!
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup(image: String, name: String?) {
        
        imgIcon.image = UIImage(named: image)
        lblName.text = name
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func valueDidChanged(_ sender: UISwitch) {
        
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
