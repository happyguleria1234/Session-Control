//
//  NavigationManager.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit

struct PMStoryboard {
        
    public static let main: String = "Main"
    public static let loader: String = "Loader"
}

struct PMNavigation {
        
    public static let signIn: String = "navigationSignIn"
    public static let landing: String = "tabbarLanding"
    public static let home: String = "navigationHome"
    public static let save: String = "navigationSession"
    public static let add: String = "navigationAdd"
    public static let notification: String = "navigationNotification"
    public static let profile: String = "navigationProfile"
    public static let permissions: String = "navigationPermissions"
}

class NavigationManager: NSObject, UITabBarControllerDelegate {
    
    let window = AppDelegate.shared.window
    private var tabbarController: ESTabBarController?
    
    //------------------------------------------------------
    
    //MARK: Storyboards
    
    let mainStoryboard = UIStoryboard(name: PMStoryboard.main, bundle: Bundle.main)
    let loaderStoryboard = UIStoryboard(name: PMStoryboard.loader, bundle: Bundle.main)
    
    //------------------------------------------------------
    
    //MARK: Shared
    
    static let shared = NavigationManager()
    
    //------------------------------------------------------
    
    //MARK: UINavigationController
       
    var signInNC: UINavigationController {
        return mainStoryboard.instantiateViewController(withIdentifier: PMNavigation.signIn) as! UINavigationController
    }
    
    var permissionNC: UINavigationController {
        return mainStoryboard.instantiateViewController(withIdentifier: PMNavigation.permissions) as! UINavigationController
    }
    
    var homeNC: UINavigationController {
        return mainStoryboard.instantiateViewController(withIdentifier: PMNavigation.home) as! UINavigationController
    }
    
    var sessionNC: UINavigationController {
        return mainStoryboard.instantiateViewController(withIdentifier: PMNavigation.save) as! UINavigationController
    }
    
    var addNC: UINavigationController {
        return mainStoryboard.instantiateViewController(withIdentifier: PMNavigation.add) as! UINavigationController
    }
    
    var notificationNC: UINavigationController {
        return mainStoryboard.instantiateViewController(withIdentifier: PMNavigation.notification) as! UINavigationController
    }
    
    var profileNC: UINavigationController {
        return mainStoryboard.instantiateViewController(withIdentifier: PMNavigation.profile) as! UINavigationController
    }
    
    //------------------------------------------------------
    
    //MARK: UITabbarController
       
    public func customIrregularityStyle(delegate: UITabBarControllerDelegate?) -> ESTabBarController {
    
        let tabBarController = ESTabBarController()
        tabBarController.delegate = delegate
        tabBarController.tabBar.shadowImage = UIImage(named: SCImageName.iconTransparent)
        tabBarController.tabBar.shadowColor = UIColor.darkGray
        tabBarController.tabBar.shadowOffset = CGSize.zero
        tabBarController.tabBar.shadowOpacity = 0.7
        tabBarController.tabBar.isTranslucent = true
        //tabBarController.tabBar.backgroundColor = UIColor.white
        tabBarController.tabBar.barTintColor = SCColor.appBackground
        //tabBarController.tabBar.backgroundImage = UIImage(named: TFImageName.iconDarkBackground)
        
        let v1 = homeNC
        let v2 = sessionNC
        let v3 = addNC
        let v4 = notificationNC
        let v5 = profileNC
        
        /*tabBarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        
        tabBarController.didHijackHandler = {
            [weak tabBarController] tabbarController, viewController, index in
               
            let v3 = self.addNC
            v3.modalPresentationStyle = .fullScreen
            tabBarController?.present(v3, animated: true, completion: nil)
        }*/
        
        v1.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: nil, image: UIImage(named: SCImageName.iconHome), selectedImage: UIImage(named: SCImageName.iconHomeSelected))
        v2.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: nil, image: UIImage(named: SCImageName.iconSession), selectedImage: UIImage(named: SCImageName.iconSessionSelected))
        v3.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: nil, image: UIImage(named: SCImageName.iconMessages), selectedImage: UIImage(named: SCImageName.iconMessagesSelected))
        v4.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: nil, image: UIImage(named: SCImageName.iconNotification), selectedImage: UIImage(named: SCImageName.iconNotificationSelected))
        v5.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: nil, image: UIImage(named: SCImageName.iconProfile), selectedImage: UIImage(named: SCImageName.iconProfileSelected))
        
        tabBarController.viewControllers = [v1, v2, v3, v4, v5]
               
        return tabBarController
    }
    
    var landingTC: ESTabBarController {
        //return mainStoryboard.instantiateViewController(withIdentifier: PMNavigation.landing) as! UITabBarController
        return customIrregularityStyle(delegate: self)
    }
    
    public var isEnabledBottomMenu: Bool = false {
        didSet {
            self.tabbarController?.tabBar.isHidden = !isEnabledBottomMenu
        }
    }
    
    //------------------------------------------------------
    
    //MARK: RootViewController
    
    func setupSingIn() {
        AppDelegate.shared.window?.rootViewController = signInNC
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
    func setupPermission() {
        AppDelegate.shared.window?.rootViewController = permissionNC
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
    func setupLanding(_ isFromRemoteNotification: Bool = false) {
        
        //locally save controller to set their properties
        tabbarController = landingTC
        AppDelegate.shared.window?.rootViewController = tabbarController
        AppDelegate.shared.window?.makeKeyAndVisible()                
    }
    
    func setupGuest() {
        
        AppDelegate.shared.window?.rootViewController = self.addNC
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewControllers
    
    public var loadingIndicatorVC: LoadingIndicatorVC {
        return loaderStoryboard.instantiateViewController(withIdentifier: String(describing: LoadingIndicatorVC.self)) as! LoadingIndicatorVC
    }
    
    public var selectCategoriesVC: SelectCategoriesVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: SelectCategoriesVC.self)) as! SelectCategoriesVC
    }
    
    public var permissionsVC: PermissionsVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: PermissionsVC.self)) as! PermissionsVC
    }
    
    public var homeVC: HomeVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: HomeVC.self)) as! HomeVC
    }
    
    public var homeDetailVC: HomeDetailVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: HomeDetailVC.self)) as! HomeDetailVC
    }
    
    public var imagePreviewVC: ImagePreviewVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: ImagePreviewVC.self)) as! ImagePreviewVC
    }
    
    public var changePasswordVC: ChangePasswordVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: ChangePasswordVC.self)) as! ChangePasswordVC
    }
    
    public var chatDetailsVC: ChatDetailsVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: ChatDetailsVC.self)) as! ChatDetailsVC
    }
    
    public var studioProfileVC: StudioProfileVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: StudioProfileVC.self)) as! StudioProfileVC
    }
    
    public var addAccountDetailVC: AddAccountDetailVC {
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: AddAccountDetailVC.self)) as! AddAccountDetailVC
    }
    
    
    //------------------------------------------------------
}
