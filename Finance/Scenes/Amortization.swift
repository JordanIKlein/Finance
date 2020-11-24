//
//  Amortization.swift
//  Finance
//
//  Created by Jordan Klein on 11/21/20.
//

import Foundation
import UIKit

class Amortization: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        addingBackgroundShapes() // adding black background and top shape
    }
    
    func addingBackgroundShapes(){
        view.backgroundColor = UIColor.black
        let path = UIBezierPath()
        path.move(to: CGPoint(x:0,y:view.bounds.maxY))
        path.addLine(to: CGPoint(x:view.bounds.maxX, y:view.bounds.maxY ))
        path.addLine(to: CGPoint(x:view.bounds.maxX, y:view.bounds.maxY - 125))
        path.addLine(to: CGPoint(x:0, y:view.bounds.maxY - 175))
        
        topTri.path = path.cgPath
        topTri.zPosition = 1
        topTri.fillColor = UIColor(named: "SpecialGreen")?.cgColor
        view.layer.addSublayer(topTri)
    }
}
