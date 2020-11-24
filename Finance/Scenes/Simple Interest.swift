//
//  Simple Interest.swift
//  Finance
//
//  Created by Jordan Klein on 11/21/20.
//

import Foundation
import UIKit

class SimpleInt: UIViewController{
    let backgroundShape = CAShapeLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        background()
    }
    func background(){
        view.backgroundColor = UIColor.black
        let path = UIBezierPath()
        path.move(to: CGPoint(x:0,y:0))
        path.addLine(to: CGPoint(x:view.bounds.maxX, y:0))
        path.addLine(to: CGPoint(x:view.bounds.maxX, y:90))
        path.addLine(to: CGPoint(x:0, y:155))
        
        backgroundShape.path = path.cgPath
        backgroundShape.zPosition = 1
        backgroundShape.fillColor = UIColor(named: "SpecialGreen")?.cgColor
        view.layer.addSublayer(backgroundShape)
    }
}
