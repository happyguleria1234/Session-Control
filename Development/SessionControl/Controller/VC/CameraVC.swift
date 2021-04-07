//
//  CameraVC.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 22/08/20.
//  Copyright © 2020 dharmesh. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class CameraVC : UIViewController {

    @IBOutlet weak var viewCamera: SCCustomCameraView!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    @IBOutlet weak var btnSignIn: UIBarButtonItem!
    
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
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnCancelTap(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSignInTap(_ sender: Any) {
        
        NavigationManager.shared.setupSingIn()
    }
    
    @IBAction func btnCapturePhotoTap(_ sender: Any) {
        
        if viewCamera.isOn == true {
           
            viewCamera.capturePhoto { (image, buffer, error) in
                
                guard image != nil else {
                    if let er = error {
                        DisplayAlertManager.shared.displayAlert(animated: true, message: er.localizedDescription, handlerOK: nil)
                    }
                    return
                }
                
                let controller = NavigationManager.shared.imagePreviewVC
                controller.image = image
                controller.buffer = buffer
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if PreferenceManager.shared.isGuest == false {
            btnSignIn.isEnabled = false
            navigationItem.rightBarButtonItem = nil
        } else {
            btnCancel.isEnabled = false
            navigationItem.leftBarButtonItem = nil
            btnSignIn.isEnabled = true
        }
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}

