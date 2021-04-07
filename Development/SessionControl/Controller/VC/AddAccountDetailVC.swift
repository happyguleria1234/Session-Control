//
//  AddAccountDetailVC.swift
//  SessionControl
//
//  Created by Apple on 07/04/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import Foundation
import IQKeyboardManagerSwift

class AddAccountDetailVC: BaseVC , UITextFieldDelegate{

    var returnKeyHandler: IQKeyboardReturnKeyHandler?

    @IBOutlet weak var addBackImageTxtFld: SCAddImagesTextField!
    @IBOutlet weak var addFrontImageTxtFld: SCAddImagesTextField!
    @IBOutlet weak var ssnNumberTxtFld: SCAccountHolderNameTextField!
    @IBOutlet weak var routingNumberTxtFld: SCAccountHolderNameTextField!
    @IBOutlet weak var accountNumberTxtFld: SCAccountHolderNameTextField!
    @IBOutlet weak var accountHolderNameLblTxtFld: SCAccountHolderNameTextField!
    
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
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
    
    @IBAction func submitBtn(_ sender: Any) {
    }
    
}
