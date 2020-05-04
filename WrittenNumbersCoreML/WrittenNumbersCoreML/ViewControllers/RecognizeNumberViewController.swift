//
//  RecognizeNumberViewController.swift
//  WrittenNumbersCoreML
//
//  Created by Wylan L Neely on 4/11/20.
//  Copyright © 2020 Wylan L Neely. All rights reserved.
//

import UIKit
import Vision
import CoreML

class RecognizeNumberViewController: UIViewController {
    
    //MARK: Properties

    var requests = [VNRequest]()
    var predictorController = ScreenWrittenNumberPredictController()
    
    //MARK: App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Outlets
    
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var numberLabel: UILabel!
    
    //MARK: Actions
  
    @IBAction func clearCanvas(_ sender: Any) {
        canvasView.clearCanvas()
    }
    
    @IBAction func recognizeDigit(_ sender: Any) {
        let image = UIImage(view: canvasView)
        let scaledIMage = scaleImage(image: image, toSize: CGSize(width: 28, height: 28))
        
        self.predictorController.requestPrediction(with: scaledIMage) { (success) in
            if success {
                let mostConfidentSymbol = predictorController.highestConfidenceSymbol
                DispatchQueue.main.async {
                    self.numberLabel.text = mostConfidentSymbol }
            } else {
                DispatchQueue.main.async {
                    self.numberLabel.text = "No"
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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toConfidanceView" {
            let presentedVC = segue.destination as! ConfidanceViewController
            
        }

    }
   


}

