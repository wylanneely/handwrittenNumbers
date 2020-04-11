//
//  ViewController.swift
//  WrittenNumbersCoreML
//
//  Created by Wylan L Neely on 4/11/20.
//  Copyright © 2020 Wylan L Neely. All rights reserved.
//

import UIKit
import Vision
import CoreML

class ViewController: UIViewController {

    var requests = [VNRequest]()
    
    func setUpVision(){
        guard let visionModel = try? VNCoreMLModel(for: MNIST().model) else {
            fatalError("Vision Model failed to load")
        }
        let classificationRequest = VNCoreMLRequest(model: visionModel, completionHandler: self.handleCLassification)
        self.requests = [classificationRequest]
    }
    
    func handleCLassification(request:VNRequest, error: Error?) {
        guard let observations = request.results else { print("No results") ; return }
        
        let classifications = observations
            .flatMap({$0 as? VNClassificationObservation})
            .filter({$0.confidence > 0.8 })
            .map({$0.identifier})
        
        DispatchQueue.main.async {
            self.numberLabel.text = classifications.first
        }
    }
    
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var numberLabel: UILabel!
    
    
    
    
    @IBAction func clearCanvas(_ sender: Any) {
        canvasView.clearCanvas()
    }
    
    @IBAction func recognizeDigit(_ sender: Any) {
        let image = UIImage(view: canvasView)
        let scaledIMage = scaleImage(image: image, toSize: CGSize(width: 28, height: 28))
        
        let imageRequestHandler = VNImageRequestHandler(cgImage: scaledIMage.cgImage!, options: [:])
        
        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print(error)
        }
        
    }
    
    func scaleImage(image: UIImage, toSize size:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVision()
        }


}

