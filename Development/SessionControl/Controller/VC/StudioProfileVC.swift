//
//  StudioProfileVC.swift
//  SessionControl
//
//  Created by Apple on 07/04/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class StudioProfileVC: BaseVC , UICollectionViewDelegate , UICollectionViewDataSource, UITextFieldDelegate & UITextViewDelegate {

    var textTitle: String?
    var returnKeyHandler: IQKeyboardReturnKeyHandler?
    
    
    @IBOutlet weak var studioPricingTxtView: SCStudioGenresTextView!
    @IBOutlet weak var studioAndEquipmentTxtView: SCStudioGenresTextView!
    @IBOutlet weak var studioGenresTxtFld: SCGenresTextField!
    @IBOutlet weak var studioCreditsTxtFld: SCStudioCreditsTextField!
    @IBOutlet weak var studioPhoneNumberTxtFld: SCMobileNumberTextField!
    @IBOutlet weak var studioEmailTxtFld: SCEmailTextField!
    @IBOutlet weak var studioAddressTxtFld: SCStudioAddressTextField!
    @IBOutlet weak var studioNameTxtFld: SCStudioNameTextField!
    @IBOutlet weak var uploadImageCollectionView: UICollectionView!
    
    var showImage = ["upload","upload","upload","upload","upload"]
    
    
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
        
        title = textTitle
        
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnKeyHandler?.delegate = self
    }
    
    
    //------------------------------------------------------
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if IQKeyboardManager.shared.canGoNext {
            IQKeyboardManager.shared.goNext()
        } else {
            self.view.endEditing(true)
        }
        return true
    }


    
//    MARK:- Collection View Delegate Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudioProfileAddImagesCell", for: indexPath) as! StudioProfileAddImagesCell
        cell.addImage.image = UIImage(named: showImage[indexPath.row])
        return cell
    }
    
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------

    //MARK: Actions
    
    @IBAction func nxtBtn(_ sender: UIButton) {
        let controller = NavigationManager.shared.addAccountDetailVC
//        controller.textTitle = name?.localized()
        push(controller: controller)
    }
}
