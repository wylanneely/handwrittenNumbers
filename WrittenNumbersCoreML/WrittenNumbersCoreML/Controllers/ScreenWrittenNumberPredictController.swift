//
//  ScreenWrittenNumberPredictController.swift
//  WrittenNumbersCoreML
//
//  Created by Wylan L Neely on 4/18/20.
//  Copyright © 2020 Wylan L Neely. All rights reserved.
//

import Foundation
import CoreML
import Vision
import UIKit

class ScreenWrittenNumberPredictController {
    
    var visionModel: VNCoreMLModel?
    var predictionRequests = [VNRequest]()
    
    fileprivate var currentPredictions:[VNClassificationObservation] = []
    fileprivate var predictions = [String: SymbolPrediction]()

    
    var highestConfidenceSymbol: String? {
        return  currentPredictions.sorted(by: { $0.confidence > $1.confidence }).map({$0.identifier}).first
    }
    
    init(){
        guard let model = try? VNCoreMLModel(for: MNIST().model) else {
            self.visionModel = nil
            fatalError("Machine Learning Model: FAILED TO LOAD")
        }
        self.visionModel = model
        loadPredictionRequests()
        createSymbolPredictors()
    }
    
    func createSymbolPredictors(){
        let zeroPrediction: SymbolPrediction = SymbolPrediction(symbol: "0")
        let onePrediction: SymbolPrediction = SymbolPrediction(symbol: "1")
        let twoPrediction: SymbolPrediction = SymbolPrediction(symbol: "2")
        let threePrediction: SymbolPrediction = SymbolPrediction(symbol: "3")
        let fourPrediction: SymbolPrediction = SymbolPrediction(symbol: "4")
        let fivePrediction: SymbolPrediction = SymbolPrediction(symbol: "5")
        let sixPrediction: SymbolPrediction = SymbolPrediction(symbol: "6")
        let sevenPrediction: SymbolPrediction = SymbolPrediction(symbol: "7")
        let eightPrediction: SymbolPrediction = SymbolPrediction(symbol: "8")
        let ninePrediction: SymbolPrediction = SymbolPrediction(symbol: "9")
        self.predictions  = ["0":zeroPrediction,"1":onePrediction,"2":twoPrediction,"3":threePrediction,"4":fourPrediction,"5":fivePrediction,"6":sixPrediction,"7":sevenPrediction,"8":eightPrediction,"9":ninePrediction]
    }
    
    public subscript(_ symbol: String) -> SymbolPrediction? {
            get { return predictions[symbol] }
            set { predictions[symbol] = newValue }
        }

     private func loadPredictionRequests(){
         
         let requests = VNCoreMLRequest(model: visionModel!, completionHandler: predictionRequestHandler)
         requests.imageCropAndScaleOption = .centerCrop
         predictionRequests = [requests]
     }
     
    public func requestPrediction(with image: UIImage, completion: (_ success:Bool) -> Void) {
         
         let imageRequestHandler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
         
         //  let imageOrientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))!
         //   let imageRequesttHandler = VNImageRequestHandler(cgImage: image.cgImage!, orientation: imageOrientation, options: [:])
         
         do {
             try imageRequestHandler.perform(predictionRequests)
             completion(true)
         } catch {
             completion(false)
             print(error)
         }
     }
     
     fileprivate func predictionRequestHandler(request:VNRequest, error: Error?) {
         guard let observations = request.results else {
             print("No results") ; return }
         let classifications = observations
             .compactMap({$0 as? VNClassificationObservation})
         extractPredictions(from: classifications)
         self.currentPredictions = classifications
     }
     
     fileprivate func extractPredictions(from classificationObservations: [VNClassificationObservation]) {
         let sessionUUID = UUID()
         for observation in classificationObservations {
                 let id = observation.identifier
             let confidence =  observation.confidence
             updateSymbolPrediction(symbol: id, confidence: confidence, uuid: sessionUUID)
         }
             }
     
    fileprivate func updateSymbolPrediction(symbol: String, confidence:VNConfidence, uuid: UUID) {
       let updatedPrediction = SymbolPrediction(confidence: confidence, uuid: uuid, symbol: symbol)
         predictions[symbol] = updatedPrediction
     }
     
     fileprivate func updateSortClassifications(observations: [VNClassificationObservation]) {
         self.currentPredictions = observations.sorted(by: {$0.confidence > $1.confidence})
     }
     
    
    
    
}
