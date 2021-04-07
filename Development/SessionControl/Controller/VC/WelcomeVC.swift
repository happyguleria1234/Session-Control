//
//  WelcomeVC.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 3/22/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import Foundation

class WelcomeVC: BaseVC {
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Unwind
    
    @IBAction func signIn(_ unwindSegue: UIStoryboardSegue) {
        print(unwindSegue)
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
}
