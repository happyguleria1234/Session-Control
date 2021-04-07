//
//  AppDelegate.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UIKit
import FBSDKCoreKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, GIDSignInDelegate {
    
    var window: UIWindow?
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    /// keyboard configutation
    private func configureKeboard() {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarTintColor = SCColor.appFont
        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses = [UIScrollView.self, UIStackView.self, UIView.self, UISearchBar.self]
    }
    
    /// to get custom added font names
    private func getCustomFontDetails() {
        #if DEBUG
        for family in UIFont.familyNames {
            let sName: String = family as String
            debugPrint("family: \(sName)")
            for name in UIFont.fontNames(forFamilyName: sName) {
                debugPrint("name: \(name as String)")
            }
        }
        #endif
    }
    
    public func configureNavigationBar() {
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = SCColor.appBackground
            appearance.titleTextAttributes = [.foregroundColor: SCColor.appWhite, .font: SCFont.poppinsRegular(size: SCFont.defaultRegularFontSize)]
            appearance.largeTitleTextAttributes = [.foregroundColor: SCColor.appWhite, .font: SCFont.poppinsRegular(size: SCFont.defaultRegularFontSize)]
            
            UINavigationBar.appearance().barTintColor = SCColor.appBackground
            UINavigationBar.appearance().tintColor = SCColor.appWhite
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().barTintColor = SCColor.appBackground
            UINavigationBar.appearance().tintColor = SCColor.appWhite
            UINavigationBar.appearance().isTranslucent = false
        }
    }
    
    func registerRemoteNotificaton(_ application: UIApplication) {
       
        if #available(iOS 10.0, *) {
            
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
        } else {
            
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
    }
    
    func performGoogleSignIn(_ firstName: String, _ lastName: String, _ googleId: String, _ email: String, _ image: String) {
        
        let deviceToken = PreferenceManager.shared.deviceToken ?? String()
             
        let parameter: [String: Any] = [
            Request.Parameter.firstName: firstName,
            Request.Parameter.lastName: lastName,
            Request.Parameter.email:email,
            Request.Parameter.googleId: googleId,
            Request.Parameter.image: image,
            Request.Parameter.deviceToken: deviceToken,
            Request.Parameter.deviceType: DeviceType.iOS.rawValue
        ]
        
        RequestManager.shared.requestPOST(requestMethod: Request.Method.gLogin, parameter: parameter, showLoader: false, decodingType: ResponseModal<UserModal>.self, successBlock: { (response: ResponseModal<UserModal>) in
            
            LoadingManager.shared.hideLoading()
            
            if response.code == Status.Code.success {
                         
                if let stringUser = try? response.data?.jsonString() {
                    PreferenceManager.shared.currentUser = stringUser
                }
                NavigationManager.shared.setupLanding()
            }
            
        }, failureBlock: { (error: ErrorModal) in
            
            LoadingManager.shared.hideLoading()
            
            delay {
                DisplayAlertManager.shared.displayAlert(animated: true, message: error.errorDescription, handlerOK: nil)
            }
        })
    }
    
    func handleRemoteNotification(userInfo: [AnyHashable: Any], completion: @escaping(_ flag: Bool) -> Void ) {
        debugPrint("handleRemoteNotification:\(userInfo)")
        completion(true)
        
        if PreferenceManager.shared.currentUser != nil {
            NavigationManager.shared.setupLanding(true)
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         
        configureKeboard()
        getCustomFontDetails()
        configureNavigationBar()                       
        
        //RealmManager.shared.save(channelDownload: false)
        window?.tintColor = SCColor.appFont
        
        //crashlytics and Analytics configuration
        FirebaseApp.configure()
        
        //facebook SignIn
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        // google sign-in
         GIDSignIn.sharedInstance().clientID = "957427498793-60odharhbpen5do47deu7ko68651ikq8.apps.googleusercontent.com"
         GIDSignIn.sharedInstance().delegate = self
        
        //push notification
        registerRemoteNotificaton(application)
        
        if let remoteNotification = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] {
            debugPrint("LaunchOptionsKey.remoteNotification:\(remoteNotification)")
            //Redirection is gonna be handle from received notification
        } else {
            if PreferenceManager.shared.currentUser != nil {
                NavigationManager.shared.setupLanding()
            }
        }
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        let googleSignIN = GIDSignIn.sharedInstance().handle(url)
        let facebookSignIn = ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
        
        return googleSignIN || facebookSignIn
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        return .portrait
    }
    
    //------------------------------------------------------
    
    //MARK: - UNUserNotificationCenterDelegate
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        PreferenceManager.shared.deviceToken = deviceToken.hexString
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugPrint("didFailToRegisterForRemoteNotificationsWithError: \(error.localizedDescription)")
        
        DisplayAlertManager.shared.displayAlert(animated: true, message: error.localizedDescription, handlerOK: nil)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
       
        handleRemoteNotification(userInfo: response.notification.request.content.userInfo) { (flag) in
            completionHandler()
        }
    }
    
    //------------------------------------------------------
    
    //MARK: GIDSignInDelegate
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        let googleId = user.userID ?? String()
        //let idToken = user.authentication.idToken
        let firstName = user.profile.givenName ?? String()
        let lastName = user.profile.familyName ?? String()
        let email = user.profile.email ?? String()
        let image = user.profile.imageURL(withDimension: 300)
        
        delay {
            
            LoadingManager.shared.showLoading()
            
            delayInLoading {
                self.performGoogleSignIn(firstName, lastName, googleId, email, image?.absoluteString ?? String())
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
        // Perform any operations when the user disconnects from app here.
    }
    
    //------------------------------------------------------
}

