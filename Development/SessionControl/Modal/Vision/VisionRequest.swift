//
//  VisionRequest.swift
//  SearchByImage
//
//  Created by arakawa.yasuhisa on 2018/09/04.
//  Copyright © 2018年 yasuhisa.arakawa. All rights reserved.
//

import AVKit
import Vision

/// request completion handler
typealias CompletionHandler = (([VNClassificationObservation], Error?) -> ())?

/// VisionRequest Class
@available(iOS 12.0, *)
class VisionRequest: NSObject {
    
    private let model = try? VNCoreMLModel(for: AnimalTracking_2().model)
    private let context = CIContext()
    
    /// Observe CoreMLRequest results from CMSampleBuffer.
    ///
    /// - Parameters:
    ///   - sampleBuffer: captured buffer
    ///   - targetRect: target rect
    ///   - completionHandler: use observation results this closure
    func observeFromSampleBuffer(sampleBuffer: CMSampleBuffer, targetRect: CGRect, completionHandler: CompletionHandler) -> Void {
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        
        guard let cgImage = self.context.createCGImage(ciImage, from: targetRect) else { return }
        
        guard let coreMLModel = self.model else { return }
        
        let coreMLRequest = VNCoreMLRequest(model: coreMLModel) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else { return }
            
            completionHandler?(results, error)
        }
        
        try? VNImageRequestHandler(cgImage: cgImage, options: [:]).perform([coreMLRequest])
    }
    
    /// Observe CoreMLRequest results from UIImage.
    ///
    /// - Parameters:
    ///   - image: UIImage
    ///   - completionHandler: use observation results this closure
    func observeFromImage(image: UIImage, completionHandler: CompletionHandler) {
        guard let cgImage = image.cgImage else { return }
        
        guard let coreMLModel = self.model else { return }
        
        let coreMLRequest = VNCoreMLRequest(model: coreMLModel) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else { return }
            
            completionHandler?(results, error)
        }
        
        try? VNImageRequestHandler(cgImage: cgImage, options: [:]).perform([coreMLRequest])
    }
    
}
