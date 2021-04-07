//
//  ImagePreviewVC.swift
//  SessionControl
//
//  Created by Dharmesh Avaiya on 2/8/21.
//  Copyright © 2021 dharmesh. All rights reserved.
//

import UIKit
import Foundation
//import Firebase
import AVFoundation

class ImagePreviewVC: UIViewController {
    
    @IBOutlet weak var imgViewPreview: UIImageView!
    
    var buffer: CMSampleBuffer?
    var image: UIImage?
    //var objectDetector: VisionObjectDetector?
    //private var modelDataHandler: ModelDataHandler? = ModelDataHandler(modelFileInfo: MobileNet.modelInfo, labelsFileInfo: MobileNet.labelsInfo)
    private let visionRequest = VisionRequest()
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Custom
    
    /*func setupDetection() {
        
        let options = VisionObjectDetectorOptions()
        options.detectorMode = .singleImage
        options.shouldEnableMultipleObjects = true
        options.shouldEnableClassification = true  // Optional
        
        objectDetector = Vision.vision().objectDetector()
    }
    
    func performDetection() {
        
        if let uiImage = image {
            
            let cameraPosition = AVCaptureDevice.Position.back
            let metadata = VisionImageMetadata()
            metadata.orientation = imageOrientation(
                deviceOrientation: UIDevice.current.orientation,
                cameraPosition: cameraPosition
            )
            
            let image = VisionImage(image: uiImage)
            //image.metadata = metadata

            objectDetector?.process(image) { detectedObjects, error in
              
                guard error == nil else {
                    DisplayAlertManager.shared.displayAlert(animated: true, message: error!.localizedDescription, handlerOK: nil)
                return
              }
              guard let detectedObjects = detectedObjects, !detectedObjects.isEmpty else {
                DisplayAlertManager.shared.displayAlert(animated: true, message: "No object detected", handlerOK: nil)
                return
              }

              print(detectedObjects)
            }
        }
    }
    
    func imageOrientation(
        deviceOrientation: UIDeviceOrientation,
        cameraPosition: AVCaptureDevice.Position
        ) -> VisionDetectorImageOrientation {
        switch deviceOrientation {
        case .portrait:
            return cameraPosition == .front ? .leftTop : .rightTop
        case .landscapeLeft:
            return cameraPosition == .front ? .bottomLeft : .topLeft
        case .portraitUpsideDown:
            return cameraPosition == .front ? .rightBottom : .leftBottom
        case .landscapeRight:
            return cameraPosition == .front ? .topRight : .bottomRight
        case .faceDown, .faceUp, .unknown:
            return .leftTop
        @unknown default:
            return .topLeft
        }
    }*/
    
    func performClassification() {
        
        if let uiImage = image {
            
            /*let pixelBuffer = CVPixelBuffer.buffer(from: uiImage)
            
            guard let imagePixelBuffer = pixelBuffer else {
                DisplayAlertManager.shared.displayAlert(animated: true, message: "No classification observed") {
                    self.pop()
                }
              return
            }
            
            let result = modelDataHandler?.runModel(onFrame: imagePixelBuffer)

            for inference in result?.inferences ?? [] {
                debugPrint("label: \(inference.label)")
                debugPrint("confidence: \(inference.confidence)")
            }
            
            if let first = result?.inferences.first {
                let title = first.confidence * 100
                let description = first.label
                let message = String(format: "%.2lf\n%@", title, description)
                DisplayAlertManager.shared.displayAlert(animated: true, message: message) {
                    self.pop()
                }
            }*/
            
            self.visionRequest.observeFromImage(image: uiImage) { (results, error) in
                // firstResult
                guard let firstResult = results.first else { return }
                
                DispatchQueue.main.async {
                    // Update UI in this block
                    let title = firstResult.confidence * 100
                    let description = firstResult.identifier
                    let message = String(format: "%.2lf\n%@", title, description)
                    DisplayAlertManager.shared.displayAlert(animated: true, message: message) {
                        self.pop()
                    }
                }
            }
        }
    }
    
    func pop() {
        delay {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgViewPreview.image = image
        //setupDetection()
        //performDetection()
        delay {
            self.performClassification()
        }
    }
       
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}
