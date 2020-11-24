//
//  TVM.swift
//  Finance
//
//  Created by Jordan Klein on 11/21/20.
//

import Foundation
import UIKit

class TVM: UIViewController, UIGestureRecognizerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        addingBackgroundShapes() // adding black background and top shape
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
            edgePan.edges = .left

            view.addGestureRecognizer(edgePan)
    }
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            //bring user back to main menu
            let newStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let VC = newStoryBoard.instantiateViewController(withIdentifier: "Main")
            VC.modalPresentationStyle = .fullScreen
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window?.layer.add(transition, forKey: kCATransition)
            self.present(VC, animated: false, completion: nil)
        }
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
