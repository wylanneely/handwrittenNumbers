//
//  CharacterPrediction.swift
//  WrittenNumbersCoreML
//
//  Created by Wylan L Neely on 4/13/20.
//  Copyright © 2020 Wylan L Neely. All rights reserved.
//

import Foundation
import Vision

struct SymbolPrediction {
    
    let symbol: String
    
    let character: Character?
    let number: Int?
    
    var confidence: VNConfidence? = nil

    var confidenceLevel: String?
    var confidenceFloat: Float?
    

    fileprivate var predictionSessionUUID: UUID? = nil
    
    mutating func updatePrediction(with confidence: VNConfidence, and sessionUUID: UUID) {
        self.predictionSessionUUID = sessionUUID
        self.confidence = confidence
        self.confidenceLevel = confidence.description
        self.confidenceFloat = confidence.magnitude
    }
    
   fileprivate mutating func updatePredictionSessionUUID(uuid: UUID) {
        self.predictionSessionUUID = uuid
    }
   fileprivate mutating func updateConfidenceLevel(uuid: UUID) {
          self.predictionSessionUUID = uuid
      }
    
    init(symbol: String) {
        self.symbol = symbol
        switch symbol {
        case "0": number = 0; character = nil
        case "1": number = 1; character = nil
        case "2": number = 2; character = nil
        case "3": number = 3; character = nil
        case "4": number = 4; character = nil
        case "5": number = 5; character = nil
        case "6": number = 6; character = nil
        case "7": number = 7; character = nil
        case "8": number = 8; character = nil
        case "9": number = 9; character = nil
        default: number = nil; character = symbol.first
        }
            self.confidenceLevel = confidence?.description
            self.confidenceFloat = confidence?.magnitude
    }
    
    init(confidence:VNConfidence, uuid: UUID, symbol: String) {
        self.confidence = confidence
        self.predictionSessionUUID = uuid
        self.symbol = symbol
        self.confidenceLevel = confidence.description
        self.confidenceFloat = confidence.magnitude
        switch symbol {
        case "0": number = 0; character = nil
        case "1": number = 1; character = nil
        case "2": number = 2; character = nil
        case "3": number = 3; character = nil
        case "4": number = 4; character = nil
        case "5": number = 5; character = nil
        case "6": number = 6; character = nil
        case "7": number = 7; character = nil
        case "8": number = 8; character = nil
        case "9": number = 9; character = nil
        default: number = nil; character = symbol.first
        }
    }
}
