//
//  CanvasView.swift
//  WrittenNumbersCoreML
//
//  Created by Wylan L Neely on 4/11/20.
//  Copyright © 2020 Wylan L Neely. All rights reserved.
//


import UIKit

class CanvasView: UIView {

    //MARK: Properties
    
    var lineColor: UIColor!
    var lineWidth: CGFloat!
    var path: UIBezierPath!
    var touchPoint: CGPoint!
    var startingPoint: CGPoint!
    
    //MARK: SetUp

    override func layoutSubviews() {
        self.clipsToBounds = true
        self.isMultipleTouchEnabled = false
        lineColor = UIColor.white
        lineWidth = 10
    }
    
    //MARK: Update
    
    func drawShapeLayer() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
        self.setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        startingPoint = touch?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        touchPoint = touch?.location(in: self)
        path = UIBezierPath()
        path.move(to: startingPoint); path.addLine(to: touchPoint)
        startingPoint = touchPoint
        
        drawShapeLayer()
    }
    
    func clearCanvas() {
        path.removeAllPoints()
        self.layer.sublayers = nil
        self.setNeedsDisplay()
    }
}
