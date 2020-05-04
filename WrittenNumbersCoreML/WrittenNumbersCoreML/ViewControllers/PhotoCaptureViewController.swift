//
//  PhotoCaptureViewController.swift
//  WrittenNumbersCoreML
//
//  Created by Wylan L Neely on 4/13/20.
//  Copyright © 2020 Wylan L Neely. All rights reserved.
//

import UIKit
import Vision
import CoreML

class PhotoCaptureViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   
    
    //MARK: App Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Properties
    var imagePicker: UIImagePickerController!
    
    var requests = [VNRequest]()
    var predictorController = HandwrittenNumberImagesPredictorController()
    
    //MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var predictedSymbol: UILabel!
    @IBOutlet weak var invertedColorsImageView: UIImageView!
    
    //MARK: Actions
    
    @IBAction func recognizeSymbol(_ sender: Any) {
        let image = UIImage(view: imageView)
      //  let scaledIMage = scaleImage(image: image, toSize: CGSize(width: 299, height: 299))
        
        self.predictorController.requestPrediction(with: image) { (success) in
            if success {
                let mostConfidentSymbol = predictorController.highestConfidenceSymbol
                DispatchQueue.main.async {
                    self.predictedSymbol.text = mostConfidentSymbol}
            } else {
                DispatchQueue.main.async {
                    self.predictedSymbol.text = "No"
            } } }
    }
    
    //MARK: Functions
       
       func scaleImage(image: UIImage, toSize size:CGSize) -> UIImage {
           UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
           image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
           let newImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return newImage!
       }
    
    @IBAction func takePhoto(_ sender: Any) {

        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera

        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: Delegate Functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageView.image = info[.originalImage] as? UIImage
        transformImageForClassifier()
    }
    
    //classifier model trained with black backround and white text
    func transformImageForClassifier(){
        let beginImage = CIImage(image: imageView!.image!)
               if let filter = CIFilter(name: "CIColorInvert") {
                   filter.setValue(beginImage, forKey: kCIInputImageKey)
                let newImage = UIImage(ciImage: filter.outputImage!)
                invertedColorsImageView!.image = newImage.rotate(radians: CGFloat(Double.pi / 2))
               }
    }
    

}
