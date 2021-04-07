//
//  ForgotPasswordVC.swift
//  Renov8
//
//  Created by Dharmesh Avaiya on 2/1/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import Foundation
import IQKeyboardManagerSwift
import KRPullLoader

class ForgotPasswordVC: BaseVC, UITextFieldDelegate, UITextViewDelegate {
        
    @IBOutlet weak var txtEmail: SCEmailTextField!    
    
    var returnKeyHandler: IQKeyboardReturnKeyHandler?
        
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
        
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnKeyHandler?.delegate = self
        
        txtEmail.text = PreferenceManager.shared.rememberMeEmail
    }
       
    func validate() -> Bool {
        
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
        
        return true
    }
    
    func performResetPassword() {
        
        let deviceToken = PreferenceManager.shared.deviceToken ?? String()
        
        let parameter: [String: Any] = [
            Request.Parameter.email: txtEmail.text ?? String(),
            Request.Parameter.deviceToken: deviceToken,
            Request.Parameter.deviceType: DeviceType.iOS.rawValue
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.forgotPassword, parameter: parameter, showLoader: false, decodingType: BaseResponseModal.self, successBlock: { (response: BaseResponseModal) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
               
                delay {
                    
                    DisplayAlertManager.shared.displayAlert(animated: true, message: LocalizableConstants.SuccessMessage.newPasswordSent, handlerOK: {
                        
                        self.pop()
                    })
                }
                
            } else {
                
                delay {
                    
                    if response.code == Status.Code.emailNotVerified {
                        
                        DisplayAlertManager.shared.displayAlertWithNoYes(target: self, animated: true, message: LocalizableConstants.SuccessMessage.mailNotVerifiedYet, handlerNo: {
                            
                        }, handlerYes: {
                            
                            LoadingManager.shared.showLoading()
                            
                            delayInLoading {
                                self.performResentEmailVerification()
                            }
                        })
                        
                    } else {
                        
                       self.handleError(code: response.code)
                    }
                }
            }
            
        }, failureBlock: { (error: ErrorModal) in
            
            LoadingManager.shared.hideLoading()
            
            delay {
                DisplayAlertManager.shared.displayAlert(animated: true, message: error.errorDescription, handlerOK: nil)
            }
        })
    }
    
    func performResentEmailVerification() {
        
        let parameter: [String: Any] = [
            Request.Parameter.email: txtEmail.text ?? String()
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.resentVerificationLink, parameter: parameter, showLoader: false, decodingType: BaseResponseModal.self, successBlock: { (response: BaseResponseModal) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success || response.code == Status.Code.emailNotVerified {
                
                delay {
                    
                    DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: LocalizableConstants.SuccessMessage.verificationMailSent) {
                    }
                }
                
            } else {
                
                delay {
                    
                    self.handleError(code: response.code)
                }
            }
            
        }, failureBlock: { (error: ErrorModal) in
            
            LoadingManager.shared.hideLoading()
            
            delay {
                DisplayAlertManager.shared.displayAlert(animated: true, message: error.errorDescription, handlerOK: nil)
            }
        })
        
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnBackTap(_ sender: Any) {
        pop()
    }
    
    
    @IBAction func btnSubmitTap(_ sender: Any) {
        
        if validate() == false {
            return
        }
        
        self.view.endEditing(true)
        
        LoadingManager.shared.showLoading()

        delayInLoading {
            self.performResetPassword()
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

