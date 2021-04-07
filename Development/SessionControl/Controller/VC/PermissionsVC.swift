//
//  PermissionsVC.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 3/31/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import Foundation

enum Permissions: CaseIterable {
    case none
    case location
    case notification
}

protocol PermissionCellDelegate {
    
    func permission(cell: PermissionsCell, did allow: Bool, permissionType: Permissions)
}

class PermissionsCell: UICollectionViewCell {
    
    @IBOutlet weak var imgPermissionType: UIImageView!
    @IBOutlet weak var lblTitle: SCBoldLabel!
    @IBOutlet weak var lblDescription: SCRegularLabel!
    
    var delegate: PermissionCellDelegate?
    
    private var permissionType: Permissions = .none
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup(permissionType: Permissions) {
        
        self.permissionType = permissionType
        
        switch permissionType {
        case .none:
            imgPermissionType.image = nil
            lblTitle.text = nil
            lblDescription.text = nil
            break
        case .location:
            
            imgPermissionType.image = UIImage(named: SCImageName.permissionLocation)
            lblTitle.text = LocalizableConstants.Controller.Permissions.locationPermissionTitle.localized()
            lblDescription.text = LocalizableConstants.Controller.Permissions.locationPermissionDescription.localized()
            
        case .notification:
           
            imgPermissionType.image = UIImage(named: SCImageName.permissionNotification)
            lblTitle.text = LocalizableConstants.Controller.Permissions.notificationPermissionTitle.localized()
            lblDescription.text = LocalizableConstants.Controller.Permissions.notificationPermissionDescription.localized()
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnAllowTap(_ sender: Any) {
        
        delegate?.permission(cell: self, did: true, permissionType: self.permissionType)
    }
    
    @IBAction func btnNotNowTap(_ sender: Any) {
        
        delegate?.permission(cell: self, did: false, permissionType: self.permissionType)
    }
    
    //------------------------------------------------------
}

class PermissionsVC: BaseVC, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PermissionCellDelegate {
    
    @IBOutlet weak var collectionPermission: UICollectionView!
     
    var permissions: [Permissions] = [.location, .notification]
    var currentIndex: Int = .zero
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    func setup() {
        collectionPermission.isScrollEnabled = false
    }
    
    func updateUI() {
        collectionPermission.reloadData()
    }
    
    func moveNext() {
        let nextIndex = currentIndex + 1
        if permissions.indices.contains(nextIndex) {
            let x = collectionPermission.contentOffset.x + collectionPermission.bounds.width
            let y = collectionPermission.contentOffset.y
            collectionPermission.setContentOffset(CGPoint(x: x, y: y), animated: true)
            currentIndex = nextIndex
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return permissions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let permission = permissions[indexPath.row]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PermissionsCell.self), for: indexPath) as? PermissionsCell {
            cell.delegate = self
            cell.setup(permissionType: permission)
            return cell
        }
        return UICollectionViewCell()
    }
    
    //------------------------------------------------------
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.bounds.size
    }
       
    //------------------------------------------------------
    
    //MARK: PermissionCellDelegate
    
    func permission(cell: PermissionsCell, did allow: Bool, permissionType: Permissions) {
        
        if permissionType == .notification {
            NavigationManager.shared.setupLanding()
        } else {
            self.moveNext()
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}
