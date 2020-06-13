//
//  ConfidanceViewController.swift
//  WrittenNumbersCoreML
//
//  Created by Wylan L Neely on 4/11/20.
//  Copyright © 2020 Wylan L Neely. All rights reserved.
//

import UIKit
import Vision

class ConfidanceViewController: UIViewController   {
    
    //MARK: Properties
    
    var predictorController = HandwrittenNumberImagesPredictorController()
    
    //MARK: Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleConfidanceDictionary()
    }
    
    func handleConfidanceDictionary() {
        
    }
    
    //MARK: Outlets
    @IBOutlet weak var topConfidanceLabel: UILabel!
    @IBOutlet weak var secondConfidanceLabel: UILabel!
    @IBOutlet weak var thirdConfidanceLabel: UILabel!
    @IBOutlet weak var fourthConfidanceLabel: UILabel!
    @IBOutlet weak var leastConfidanceLabel: UILabel!

}
