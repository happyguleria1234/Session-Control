//
//  SavedTracksCell.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 3/4/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import SDWebImage
import Toucan

class NotificationsCell: UITableViewCell {
    
    @IBOutlet weak var imgAnimal: UIImageView!
    @IBOutlet weak var lblName: SCRegularLabel!
    @IBOutlet weak var lblDate: SCRegularLabel!
    @IBOutlet weak var lblSavedDate: SCRegularLabel!
    @IBOutlet weak var lblDescription: SCRegularLabel!
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup(_ request: RequestModal) {
        
        //image
        imgAnimal.sd_addActivityIndicator()
        imgAnimal.sd_setIndicatorStyle(UIActivityIndicatorView.Style.medium)
        imgAnimal.sd_showActivityIndicatorView()
        if let image = request.image, image.isEmpty == false {
            let imgURL = URL(string: image)
            imgAnimal.sd_setImage(with: imgURL) { ( serverImage: UIImage?, _: Error?, _: SDImageCacheType, _: URL?) in
                if let serverImage = serverImage {
                    self.imgAnimal.image = Toucan.init(image: serverImage).resizeByCropping(CGSize.init(width: self.imgAnimal.bounds.width * 2, height: self.imgAnimal.bounds.height * 2)).image
                }
                self.imgAnimal.sd_removeActivityIndicator()
            }
        } else {
            self.imgAnimal.sd_removeActivityIndicator()
        }
        
        lblName.text = request.name
        lblDate.text = request.createDate
        
        let date = DateTimeManager.shared.dateFrom(unix: Int(request.createDate ?? String()) ?? .zero, inFormate: DateFormate.MMM_DD_COM_yyyy)
        lblDate.text = date
        lblDescription.text = nil                
    }
    
    func setup(name: String?, date: String?, status: RequestStatus) {
        
        lblName.text = name
        lblDate.text = date
        
        switch status {
        case .pending:
            lblDescription.text = "request submitted"
        case .approved:
            lblDescription.text = "request approved."
        case .declined:
            lblDescription.text = "request declined."
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        imgAnimal.circle()
    }
    
    //------------------------------------------------------
}
