//
//  Main Menu.swift
//  Finance
//
//  Created by Jordan Klein on 11/21/20.
//

import Foundation
import UIKit
import SpriteKit

//Creation of Buttons
let amortbtn = UIButton()
let simpleIntbtn = UIButton()
let compoundIntbtn = UIButton()
let settingsbtn = UIButton()
let tvmbtn = UIButton()


class MainMenu: UIViewController {
    
    var shapeTimer: Timer?
    let oval = CAShapeLayer()
    let topTri = CAShapeLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingBackgroundShapes() //Adding the top triangle/rect
        spawnShape() // Need to have the rect spawn before 4 seconds occur
        shapeTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(spawnShape), userInfo: nil, repeats: true) // Timer to continue the shapes forever
        createLabel() // Adding the 'Calculate'
        buttons() // Adding the buttons
    }
    //Creating a timer which will spawn in multiple shapes
    func addingBackgroundShapes(){
        view.backgroundColor = UIColor.black
        let path = UIBezierPath()
        path.move(to: CGPoint(x:0,y:0))
        path.addLine(to: CGPoint(x:view.bounds.maxX, y:view.bounds.minY))
        path.addLine(to: CGPoint(x:view.bounds.maxX, y:view.bounds.minY + 140))
        path.addLine(to: CGPoint(x:0, y:160))
        
        topTri.path = path.cgPath
        topTri.zPosition = 1
        topTri.fillColor = UIColor(named: "SpecialGreen")?.cgColor
        view.layer.addSublayer(topTri)
    }
    @objc func spawnShape(){
        
        let ovalPositionX = arc4random_uniform(270)
        let ovalPositionY = view.bounds.size.height/100
        
        oval.path = UIBezierPath(roundedRect: CGRect(x: CGFloat(ovalPositionX), y: ovalPositionY, width: 35, height: 80), cornerRadius: 25).cgPath
        
        oval.fillColor = UIColor(named: "SpecialGreen")?.cgColor
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.fromValue = oval.position
        animation.toValue = CGPoint(x: oval.position.x, y: view.bounds.size.height )
        oval.opacity = 0.35

        animation.duration = 4
        oval.add(animation, forKey: "basic animation")
        oval.zPosition = 0
        view.layer.addSublayer(oval)
    
    }
    
    func createLabel(){
        //Creating Label
        let questionLbl = UILabel()
        questionLbl.frame = CGRect(x: 20, y: 70, width: 200, height: 40)
        questionLbl.text = "Calculate."
        questionLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        questionLbl.textColor = UIColor.black
        questionLbl.layer.zPosition = 2
        view.addSubview(questionLbl)
    }

    
    @objc func tvmPressed(_ sender: UIButton){
        sender.touchIn()
        sender.touchOut()
        let newStoryBoard : UIStoryboard = UIStoryboard(name: "TVM", bundle:nil)
        let VC = newStoryBoard.instantiateViewController(withIdentifier: "TVM")
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
    }
    @objc func settingsPressed(_ sender: UIButton){
        sender.touchIn()
        sender.touchOut()
    }
    @objc func simpleIntPressed(_ sender: UIButton){
        sender.touchIn()
        sender.touchOut()
    }
    @objc func compoundIntPressed(_ sender: UIButton){
        sender.touchIn()
        sender.touchOut()
    }
    @objc func amortPressed(_ sender: UIButton){
        sender.touchIn()
        sender.touchOut()
    }
    func buttons(){
        // Creating Buttons
            
        //TVM Button
        
        tvmbtn.frame = CGRect(x: view.bounds.size.width/2 - 100, y: view.bounds.size.height/2 + 200, width: 200, height: 50)
        tvmbtn.setTitle("TVM", for: .normal)
        tvmbtn.backgroundColor = UIColor(named: "SpecialGreen")
        tvmbtn.layer.borderColor = UIColor.darkGray.cgColor
        tvmbtn.layer.borderWidth = 1
        tvmbtn.layer.cornerRadius = 5.0
        tvmbtn.layer.zPosition = 2
        tvmbtn.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 15)
        tvmbtn.addTarget(self, action: #selector(tvmPressed), for: .touchUpInside)
        self.view.addSubview(tvmbtn)

        //Amortization Button
        
        amortbtn.frame = CGRect(x: view.bounds.size.width/2 - 100, y: tvmbtn.frame.origin.y - 125, width: 200, height: 50)
        amortbtn.setTitle("Amortization", for: .normal)
        
        amortbtn.backgroundColor = UIColor(named: "SpecialGreen")
        amortbtn.layer.borderColor = UIColor.darkGray.cgColor
        amortbtn.layer.borderWidth = 1
        amortbtn.layer.cornerRadius = 5.0
        amortbtn.layer.zPosition = 2
        amortbtn.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 15)
        amortbtn.addTarget(self, action: #selector(amortPressed), for: .touchUpInside)
        self.view.addSubview(amortbtn)
        //Simple Interest Button
        
        simpleIntbtn.frame = CGRect(x: view.bounds.size.width/2 - 100, y: amortbtn.frame.origin.y - 125, width: 200, height: 50)
        simpleIntbtn.setTitle("Simple Interest", for: .normal)
        simpleIntbtn.backgroundColor = UIColor(named: "SpecialGreen")
        simpleIntbtn.layer.borderColor = UIColor.darkGray.cgColor
        simpleIntbtn.layer.borderWidth = 1
        simpleIntbtn.layer.cornerRadius = 5.0
        simpleIntbtn.layer.zPosition = 2
        simpleIntbtn.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 15)
        simpleIntbtn.addTarget(self, action: #selector(simpleIntPressed), for: .touchUpInside)
        self.view.addSubview(simpleIntbtn)
        
        //Compound Interest Button
        
        compoundIntbtn.frame = CGRect(x: view.bounds.size.width/2 - 100, y: simpleIntbtn.frame.origin.y - 125, width: 200, height: 50)
        compoundIntbtn.setTitle("Compound Interest", for: .normal)
        compoundIntbtn.backgroundColor = UIColor(named: "SpecialGreen")
        compoundIntbtn.layer.borderColor = UIColor.darkGray.cgColor
        compoundIntbtn.layer.borderWidth = 1
        compoundIntbtn.layer.cornerRadius = 5.0
        compoundIntbtn.layer.zPosition = 2
        compoundIntbtn.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 15)
        compoundIntbtn.addTarget(self, action: #selector(compoundIntPressed), for: .touchUpInside)
        self.view.addSubview(compoundIntbtn)
        
        // Creating Icon
        let settingConfiguration = UIImage.SymbolConfiguration(pointSize: 55, weight: .black)
        let settingsImage = UIImage(systemName: "gear", withConfiguration: settingConfiguration)
        //Settings Button
        
        settingsbtn.backgroundColor = .clear
        settingsbtn.layer.borderWidth = 0
        settingsbtn.frame = CGRect(x: view.bounds.size.width - 60, y: 60, width: 50, height: 50)
        settingsbtn.tintColor = UIColor.gray
        settingsbtn.setImage(settingsImage, for: .normal)
        settingsbtn.layer.zPosition = 2
        settingsbtn.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
        settingsbtn.tag = 5
        self.view.addSubview(settingsbtn)
    }
        
    func tvmView(){
        let newViewController = TVM()
        self.navigationController?.pushViewController(newViewController, animated: true)
        newViewController.modalPresentationStyle = .fullScreen
    }
    

} // END OF CLASS

extension UIButton{
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    func touchIn(){
        UIView.animate(withDuration: 0.1, delay: 0, options: [.allowUserInteraction,.curveEaseIn], animations: {
            self.transform = .init(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }
    func touchOut(){
        UIView.animate(withDuration: 0.1, delay: 0.1, options: [.allowUserInteraction,.curveEaseOut], animations: {
            self.transform = .identity
        }, completion: nil)
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .rigid)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
}
