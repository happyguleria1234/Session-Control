//
//  EditProfileVC.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 3/5/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import Foundation
import IQKeyboardManagerSwift
import Toucan

class EditProfileVC: BaseVC, UITextFieldDelegate, UITextViewDelegate, SCImagePickerDelegate {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtFirstName: SCUsernameTextField!
    @IBOutlet weak var txtLastName: SCUsernameTextField!
    @IBOutlet weak var txtBidthDate: SCBirthDateTextField!
    @IBOutlet weak var txtGender: SCGenderTextField!
    @IBOutlet weak var txtEmail: SCEmailTextField!
    @IBOutlet weak var txtMobileNumber: SCMobileNumberTextField!
    
    var returnKeyHandler: IQKeyboardReturnKeyHandler?
    
    var imagePickerVC: SCImagePickerVC?
    var selectedImage: UIImage? {
        didSet {
            if selectedImage != nil {
                imgProfile.image = selectedImage
            }
        }
    }
    
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
        
        imgProfile.image = getPlaceholderImage()
        
        imagePickerVC = SCImagePickerVC(presentationController: self, delegate: self)
        
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnKeyHandler?.delegate = self
    }
    
    func validate() -> Bool {
        
        if ValidationManager.shared.isEmpty(text: txtFirstName.text) == true {
            DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: LocalizableConstants.ValidationMessage.enterFirstName) {
            }
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtLastName.text) == true {
            DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: LocalizableConstants.ValidationMessage.enterLastName) {
            }
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtBidthDate.text) == true {
            DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: LocalizableConstants.ValidationMessage.selectBirthDate) {
            }
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtGender.text) == true {
            DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: LocalizableConstants.ValidationMessage.selectGender) {
            }
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtEmail.text) == true {
            DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: LocalizableConstants.ValidationMessage.enterEmail) {
            }
            return false
        }
        
        if ValidationManager.shared.isValid(text: txtEmail.text!, for: RegularExpressions.email) == false {
            DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: LocalizableConstants.ValidationMessage.enterValidEmail) {
            }
            return false
        }
        
        if ValidationManager.shared.isEmpty(text: txtMobileNumber.text) == true {
            DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: LocalizableConstants.ValidationMessage.enterMobileNumber) {
            }
            return false
        }
        
        if ValidationManager.shared.isValid(text: txtMobileNumber.text!, for: RegularExpressions.phone) == false {
            DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: LocalizableConstants.ValidationMessage.enterValidMobileNumber) {
            }
            return false
        }
        return true
    }
    
    private func performEditProfile(completion:((_ flag: Bool) -> Void)?) {
                    
        let parameter: [String: Any] = [
            Request.Parameter.firstName: txtFirstName.text ?? String(),
            Request.Parameter.lastName: txtLastName.text ?? String(),
            Request.Parameter.email: txtEmail.text ?? String(),
            Request.Parameter.image: selectedImage?.toString() ?? String(),
            Request.Parameter.deviceToken: PreferenceManager.shared.deviceToken ?? String(),
            Request.Parameter.deviceType: DeviceType.iOS.rawValue
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.editProfile, parameter: parameter, showLoader: false, decodingType: BaseResponseModal.self, successBlock: { (response: BaseResponseModal) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                
                delay {
                    completion?(true)
                }
                
            } else {
                
                completion?(false)
                
                delay {
                    
                   self.handleError(code: response.code)
                }
            }
            
        }, failureBlock: { (error: ErrorModal) in
            
            LoadingManager.shared.hideLoading()
            
            if error.code == Status.Code.emailNotVerified {
                delay {
                    completion?(true)
                }
            } else {
                completion?(false)
                
                delay {
                    self.handleError(code: error.code)
                }
            }
        })
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnCameraTap(_ sender: UIButton) {
        self.imagePickerVC?.present(from: sender)
    }
    
    @IBAction func btnSignUpTap(_ sender: Any) {
        
        if validate() == false {
            return
        }
        self.view.endEditing(true)
        
        LoadingManager.shared.showLoading()
        
        delayInLoading {
            
            LoadingManager.shared.hideLoading()
                        
            self.pop()
            
            /*self.performEditProfile { (flag: Bool) in
                if flag {
                    DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: LocalizableConstants.SuccessMessage.verificationMailSent.localized()) {
                        self.pop()
                    }
                }
            }*/
        }
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
    
    //------------------------------------------------------
    
    //MARK: SCImagePickerDelegate
    
    func didSelect(controller: SCImagePickerVC, image: UIImage?) {
                
        if let imageData = image?.jpegData(compressionQuality: 0), let compressImage = UIImage(data: imageData) {
            //self.selectedImage = resizeImage(image: compressImage, targetSize: CGSize(width: imgProfile.bounds.size.width * 2, height: imgProfile.bounds.size.width * 2))
            self.selectedImage = Toucan.init(image: compressImage).resizeByCropping(SCSettings.profileImageSize).maskWithRoundedRect(cornerRadius: SCSettings.profileImageSize.width/2, borderWidth: SCSettings.profileBorderWidth, borderColor: SCColor.appOrange).image
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgProfile.circle()
    }
    
    //------------------------------------------------------
}
