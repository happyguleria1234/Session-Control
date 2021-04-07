//
//  BaseVC.swift
//  Renov8
//
//  Created by Dharmesh Avaiya on 1/1/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import Foundation

class BaseVC : UIViewController, UIGestureRecognizerDelegate {
    
    var currentUser: UserModal? {
        return PreferenceManager.shared.currentUserModal
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
    
    public func push(controller: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: animated)
        }
    }
    
    public func pop(animated: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: animated)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func handleError(code: Int?) {
    
        if code == 105 {
            
            let message = localized(code: code ?? 0)
            DisplayAlertManager.shared.displayAlert(animated: true, message: message, handlerOK: {
                //NavigationManager.shared.setupSingInOption()
            })
            
        } else {
            
            let message = localized(code: code ?? 0)
            DisplayAlertManager.shared.displayAlert(animated: true, message: message, handlerOK: nil)
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = SCColor.appBlack
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NavigationManager.shared.isEnabledBottomMenu = false
    }
    
    //------------------------------------------------------
}
