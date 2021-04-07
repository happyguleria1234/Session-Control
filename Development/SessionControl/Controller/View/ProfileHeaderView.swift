//
//  ProfileHeaderView.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 3/4/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import SDWebImage
import Toucan

class ProfileHeaderView: UIView {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: SCRegularLabel!
    @IBOutlet weak var lblEmail: SCRegularLabel!
    
    //------------------------------------------------------
    
    //MARK: Custom
    
    func setupData(_ currentUser: UserModal?) {
        
        //image
        imgProfile.sd_addActivityIndicator()
        imgProfile.sd_setIndicatorStyle(UIActivityIndicatorView.Style.medium)
        imgProfile.sd_showActivityIndicatorView()
        imgProfile.image = getPlaceholderImage()
        if let image = currentUser?.image, image.isEmpty == false {
            let imgURL = URL(string: image)
            imgProfile.sd_setImage(with: imgURL) { ( serverImage: UIImage?, _: Error?, _: SDImageCacheType, _: URL?) in
                if let serverImage = serverImage {
                    self.imgProfile.image = Toucan.init(image: serverImage).resizeByCropping(SCSettings.profileImageSize).maskWithRoundedRect(cornerRadius: SCSettings.profileImageSize.width/2, borderWidth: SCSettings.profileBorderWidth, borderColor: SCColor.appOrange).image
                }
                self.imgProfile.sd_removeActivityIndicator()
            }
        } else {
            self.imgProfile.sd_removeActivityIndicator()
        }
        
        //firstname
        //lblName.text = currentUser?.fullName
        
        //email
        //lblEmail.text = currentUser?.email
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //imgProfile.circle()
    }
    
    //------------------------------------------------------
}
