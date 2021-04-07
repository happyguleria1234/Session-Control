//
//  ProfileVC.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 3/4/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import Foundation
import GoogleSignIn
import FacebookLogin

class ProfileVC: BaseVC, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblProfile: UITableView!
    
    struct ProfileItems {
        static let accountInformation = LocalizableConstants.Controller.Profile.accountInformation
        static let accountInformationIcon = SCImageName.iconAccountInformation
        static let paymentMethods = LocalizableConstants.Controller.Profile.paymentMethods
        static let paymentMethodsIcon = SCImageName.iconPaymentMethods
        static let changePassword = LocalizableConstants.Controller.Profile.changePassword
        static let changePasswordIcon = SCImageName.iconChangePassword
        static let allowLocation = LocalizableConstants.Controller.Profile.allowLocation
        static let allowLocationIcon = SCImageName.iconAllowLocation
        static let allowNotification = LocalizableConstants.Controller.Profile.allowNotification
        static let allowNotificationIcon = SCImageName.iconAllowNotification
        static let switchToStudioProfile = LocalizableConstants.Controller.Profile.switchToStudioProfile
        static let switchToStudioProfileIcon = SCImageName.iconSwitchToStudioProfile
        static let termsAndCondition = LocalizableConstants.Controller.Profile.termsAndCondition
        static let termsAndConditionIcon = SCImageName.iconTermsAndCondition
        static let cancellationPolicy = LocalizableConstants.Controller.Profile.cancellationPolicy
        static let cancellationPolicyIcon = SCImageName.iconCancellationPolicy
        static let logout = LocalizableConstants.Controller.Profile.logout
        static let logoutIcon = SCImageName.iconLogout
    }
    
    var itemSocials: [ [String:String] ] = [
        ["name": ProfileItems.accountInformation, "image": ProfileItems.accountInformationIcon],
        ["name": ProfileItems.paymentMethods, "image": ProfileItems.paymentMethodsIcon],
        ["name": ProfileItems.allowLocation, "image": ProfileItems.allowLocationIcon],
        ["name": ProfileItems.allowNotification, "image": ProfileItems.allowNotificationIcon],
        ["name": ProfileItems.switchToStudioProfile, "image": ProfileItems.switchToStudioProfileIcon],
        ["name": ProfileItems.termsAndCondition, "image": ProfileItems.termsAndConditionIcon],
        ["name": ProfileItems.cancellationPolicy, "image": ProfileItems.cancellationPolicyIcon],
        ["name": ProfileItems.logout, "image": ProfileItems.logoutIcon]
    ]
    
    var itemNormal: [ [String:String] ] = [
        ["name": ProfileItems.accountInformation, "image": ProfileItems.accountInformationIcon],
        ["name": ProfileItems.paymentMethods, "image": ProfileItems.paymentMethodsIcon],
        ["name": ProfileItems.changePassword, "image": ProfileItems.changePasswordIcon],
        ["name": ProfileItems.allowLocation, "image": ProfileItems.allowLocationIcon],
        ["name": ProfileItems.allowNotification, "image": ProfileItems.allowNotificationIcon],
        ["name": ProfileItems.switchToStudioProfile, "image": ProfileItems.switchToStudioProfileIcon],
        ["name": ProfileItems.termsAndCondition, "image": ProfileItems.termsAndConditionIcon],
        ["name": ProfileItems.cancellationPolicy, "image": ProfileItems.cancellationPolicyIcon],
        ["name": ProfileItems.logout, "image": ProfileItems.logoutIcon]
    ]
    
    var items: [ [String: String] ] {
        if PreferenceManager.shared.currentUserModal?.isSocialLogin == true {
            return itemSocials
        } else {
            return itemNormal
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
        
        var identifier = String(describing: ProfileCell.self)
        var nibProfileCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblProfile.register(nibProfileCell, forCellReuseIdentifier: identifier)
        
        identifier = String(describing: ProfileSwitchCell.self)
        nibProfileCell = UINib(nibName: identifier, bundle: Bundle.main)
        tblProfile.register(nibProfileCell, forCellReuseIdentifier: identifier)
    }
    
    func updateUI() {
        
        tblProfile.reloadData()
    }
    
    func performGetUserProfile() {
        
        let deviceToken = PreferenceManager.shared.deviceToken ?? String()
             
        let parameter: [String: Any] = [
            Request.Parameter.userId: currentUser?.userID ?? String(),
            Request.Parameter.deviceToken: deviceToken,
            Request.Parameter.deviceType: DeviceType.iOS.rawValue
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.getProfile, parameter: parameter, showLoader: false, decodingType: ResponseModal<UserModal>.self, successBlock: { (response: ResponseModal<UserModal>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                         
                if let stringUser = try? response.data?.jsonString() {
                    PreferenceManager.shared.currentUser = stringUser
                }
                self.updateUI()
                
            } /*else {
                
                delay {
                    
                    self.handleError(code: response.code)
                }
            }*/
            
        }, failureBlock: { (error: ErrorModal) in
            
            LoadingManager.shared.hideLoading()
            
            /*delay {
                DisplayAlertManager.shared.displayAlert(animated: true, message: error.errorDescription, handlerOK: nil)
            }*/
        })
    }
    
    private func performSignOut(completion:((_ flag: Bool) -> Void)?) {
        
        let parameter: [String: Any] = [
            Request.Parameter.userId: self.currentUser?.userID ?? String(),
            Request.Parameter.deviceToken: PreferenceManager.shared.deviceToken ?? String(),
            Request.Parameter.deviceType: DeviceType.iOS.rawValue
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.signout, parameter: parameter, showLoader: false, decodingType: BaseResponseModal.self, successBlock: { (response: BaseResponseModal) in
                            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                
                delay {
                    completion?(true)
                }
                
            } else {
                
                if response.code == Status.Code.emailNotVerified {
                    
                    delay {
                        completion?(true)
                    }
                    
                } else {
                    
                    completion?(false)
                    
                    delay {
                        
                       self.handleError(code: response.code)
                    }
                }
            }
            
        }, failureBlock: { (error: ErrorModal) in
            
            LoadingManager.shared.hideLoading()
            
            completion?(false)
            
            delay {
                self.handleError(code: error.code)
            }
        })
        
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        let name = item["name"]
        let image = item["image"]!
        if name == ProfileItems.allowLocation || name == ProfileItems.allowNotification {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileSwitchCell.self)) as? ProfileSwitchCell {
                cell.setup(image: image, name: name?.localized())
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileCell.self)) as? ProfileCell {
                cell.setup(image: image, name: name?.localized())
                return cell
            }
        }
        return UITableViewCell()
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let view: ProfileHeaderView = UIView.fromNib()
        view.setupData(currentUser)
        view.layoutSubviews()
        return view.bounds.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: ProfileHeaderView = UIView.fromNib()
        view.setupData(currentUser)
        view.layoutSubviews()
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = items[indexPath.row]
        let name = item["name"]
        
        if name == ProfileItems.changePassword {//change password
            
            let controller = NavigationManager.shared.changePasswordVC
            controller.textTitle = name?.localized()
            push(controller: controller)
            
        } else if name == ProfileItems.logout{
            
            DisplayAlertManager.shared.displayAlertWithNoYes(target: self, animated: true, message: LocalizableConstants.ValidationMessage.confirmLogout.localized()) {
                
                //Nothing to handle
                
            } handlerYes: {
                
                LoadingManager.shared.showLoading()
                
                delayInLoading {
                
                    LoadingManager.shared.hideLoading()
                    /*self.performSignOut { (flag: Bool) in
                        if flag {*/
                            
                            GIDSignIn.sharedInstance()?.signOut()
                            LoginManager().logOut()
                            PreferenceManager.shared.currentUser = nil
                            NavigationManager.shared.setupSingIn()
                        //}
                    //}
                }
            }
        } else if name == ProfileItems.switchToStudioProfile{
            let controller = NavigationManager.shared.studioProfileVC
            controller.textTitle = name?.localized()
            push(controller: controller)
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
        
        NavigationManager.shared.isEnabledBottomMenu = true
        performGetUserProfile()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
        
    //------------------------------------------------------
}

