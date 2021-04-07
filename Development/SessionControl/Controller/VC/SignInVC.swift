//
//  LoginVC.swift
//  Renov8
//
//  Created by Dharmesh Avaiya on 1/1/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import Foundation
import IQKeyboardManagerSwift
import FacebookLogin
import FBSDKLoginKit
import GoogleSignIn
import AppleSignIn
import AuthenticationServices

class SignInVC: BaseVC, UITextFieldDelegate, UITextViewDelegate, AppleLoginDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    @IBOutlet weak var txtEmail: SCEmailTextField!
    @IBOutlet weak var txtPassword: SCPasswordTextField!
    @IBOutlet weak var btnRememberMe: SCRememberMeButton!
    
    var returnKeyHandler: IQKeyboardReturnKeyHandler?
    
    //facebook
    let fbManager = LoginManager()
    let permissionEmail = "email"
    
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
        
        if PreferenceManager.shared.rememberMeEmail.isEmpty == false {
            txtEmail.text = PreferenceManager.shared.rememberMeEmail
            btnRememberMe.isRemeber = true
        } else {
            btnRememberMe.isRemeber = false
        }
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
        
        if ValidationManager.shared.isEmpty(text: txtPassword.text) == true {
            DisplayAlertManager.shared.displayAlert(target: self, animated: true, message: LocalizableConstants.ValidationMessage.enterPassword) {
            }
            return false
        }
            
        return true
    }
    
    func performLogin() {
        
        let deviceToken = PreferenceManager.shared.deviceToken ?? String()
             
        let parameter: [String: Any] = [
            Request.Parameter.email: txtEmail.text ?? String(),
            Request.Parameter.password: txtPassword.text ?? String(),
            Request.Parameter.deviceToken: deviceToken,
            Request.Parameter.deviceType: DeviceType.iOS.rawValue
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.login, parameter: parameter, showLoader: false, decodingType: ResponseModal<UserModal>.self, successBlock: { (response: ResponseModal<UserModal>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                         
                if let stringUser = try? response.data?.jsonString() {
                    PreferenceManager.shared.currentUser = stringUser
                }
                NavigationManager.shared.setupLanding()
                
            } else {
                
                delay {
                    
                    if response.code == Status.Code.emailNotVerified {
                       
                        DisplayAlertManager.shared.displayAlertWithNoYes(target: self, animated: true, message: LocalizableConstants.SuccessMessage.mailNotVerifiedYet, handlerNo: {
                            
                        }, handlerYes: {
                               
                            delay {
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
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.resentVerificationLink, parameter: parameter, showLoader: true, decodingType: BaseResponseModal.self, successBlock: { (response: BaseResponseModal) in
            
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
    
    func performFacebookLogin(_ firstName: String, _ lastName: String, _ facebookId: String, _ email: String, _ image: String) {
        
        let deviceToken = PreferenceManager.shared.deviceToken ?? String()
             
        let parameter: [String: Any] = [
            Request.Parameter.firstName: firstName,
            Request.Parameter.lastName: lastName,
            Request.Parameter.email:email,
            Request.Parameter.facebookId: facebookId,
            Request.Parameter.image: image,
            Request.Parameter.deviceToken: deviceToken,
            Request.Parameter.deviceType: DeviceType.iOS.rawValue
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.fLogin, parameter: parameter, showLoader: false, decodingType: ResponseModal<UserModal>.self, successBlock: { (response: ResponseModal<UserModal>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                         
                if let stringUser = try? response.data?.jsonString() {
                    PreferenceManager.shared.currentUser = stringUser
                }
                NavigationManager.shared.setupLanding()
                
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
    
    func performAppleLogin(_ firstName: String, _ lastName: String, _ appleId: String, _ email: String) {
        
        let deviceToken = PreferenceManager.shared.deviceToken ?? String()
             
        let parameter: [String: Any] = [
            Request.Parameter.firstName: firstName,
            Request.Parameter.lastName: lastName,
            Request.Parameter.email:email,
            Request.Parameter.appleId: appleId,
            Request.Parameter.deviceToken: deviceToken,
            Request.Parameter.deviceType: DeviceType.iOS.rawValue
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.aLogin, parameter: parameter, showLoader: false, decodingType: ResponseModal<UserModal>.self, successBlock: { (response: ResponseModal<UserModal>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                         
                if let stringUser = try? response.data?.jsonString() {
                    PreferenceManager.shared.currentUser = stringUser
                }
                NavigationManager.shared.setupLanding()
                
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
    
    //MARK: Unwind
    
    @IBAction func signIn(_ unwindSegue: UIStoryboardSegue) {
        print(unwindSegue)
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnSignInTap(_ sender: Any) {
        
        PreferenceManager.shared.isGuest = false
        
        if btnRememberMe.isRemeber {
            PreferenceManager.shared.rememberMeEmail = txtEmail.text ?? String()
        } else {
            PreferenceManager.shared.rememberMeEmail = String()
        }
        
        if validate() == false {
            return
        }
        
        self.view.endEditing(true)
       
        LoadingManager.shared.showLoading()
        
        delayInLoading {
           
            /*self.performLogin()*/
            
            LoadingManager.shared.hideLoading()
            
            NavigationManager.shared.setupPermission()
        }
    }
    
    @IBAction func btnFacebookTap(_ sender: Any) {
        
        fbManager.logIn(permissions: [permissionEmail], from: self) { (result: LoginManagerLoginResult?, error: Error?) in
            if let error = error {
                DisplayAlertManager.shared.displayAlert(message: error.localizedDescription)
            } else if let result = result {
                debugPrint(result)
                guard result.grantedPermissions.count != .zero else { return }
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start { (graphRequstCnnection: GraphRequestConnection?, response: Any?, graphError: Error?) in
                    if let error = graphError {
                        LoadingManager.shared.hideLoading()
                        delay {
                            DisplayAlertManager.shared.displayAlert(message: error.localizedDescription)
                        }
                    } else if let dict = response as? [String: Any] {
                        let fbModal = FacebookModal.init(fromDictionary: dict)
                        debugPrint(fbModal.toDictionary())
                        delay {
                            LoadingManager.shared.showLoading()
                            delayInLoading {
                                self.performFacebookLogin(fbModal.firstName, fbModal.lastName, fbModal.facebookId, fbModal.email, fbModal.picture?.data.url ?? String())
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func btnAppleSignInTap(_ sender: Any) {
        
        /*guard let window = view.window else { return }
         
         let appleLoginManager = AppleLoginManager()
         appleLoginManager.delegate = self
         appleLoginManager.performAppleLoginRequest(in: window)*/
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @IBAction func btnGoogleTap(_ sender: Any) {
        
        GIDSignIn.sharedInstance()?.signIn()
    }
        
    @IBAction func btnContinueAsGuestTap(_ sender: Any) {
        
        PreferenceManager.shared.isGuest = true
        NavigationManager.shared.setupGuest()
    }
    
    @IBAction func btnSignUpTap(_ sender: Any) {
        
        //Nothing to handle
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
    
    //MARK: AppleLoginDelegate
    
    func didCompleteAuthorizationWith(user: AppleUser) {
    
        print(user)
        
        LoadingManager.shared.showLoading()
        
        delayInLoading {
            /** var id: String
             var token: [String: Any]?
             var firstName: String
             var lastName: String
             var fullName: String {
                 return firstName + " " + lastName
             }
             var email: String*/
            self.performAppleLogin(user.firstName, user.lastName, user.id, user.email)
        }
    }

    func didCompleteAuthorizationWith(error: Error) {
        
        DisplayAlertManager.shared.displayAlert(message: error.localizedDescription)
    }
    
    //------------------------------------------------------
    
    //MARK: ASAuthorizationControllerDelegate
    
    // ASAuthorizationControllerDelegate function for successful authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let userFirstName = appleIDCredential.fullName?.givenName ?? String()
            let userLastName = appleIDCredential.fullName?.familyName ?? String()
            let userEmail = appleIDCredential.email ?? String()
            
            DispatchQueue.main.async {
                
                LoadingManager.shared.showLoading()
                
                delayInLoading {
                    self.performAppleLogin(userFirstName, userLastName, userIdentifier, userEmail)
                }
            }
            
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            print(username)
            print(password)
        }
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
        
        txtEmail.text = "dharmesh.avaiya@mailinator.com"
        txtPassword.text = "!Test@123"
        
        #endif
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        setup()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}
