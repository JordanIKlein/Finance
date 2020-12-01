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
let intOnlyLoan = UIButton()
let topTri = CAShapeLayer()

let help = UIButton()

class MainMenu: UIViewController {
    
    var shapeTimer: Timer?
    let oval = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingBackgroundShapes() //Adding the top triangle/rect
        spawnShape() // Need to have the rect spawn before 4 seconds occur
        shapeTimer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(spawnShape), userInfo: nil, repeats: true) // Timer to continue the shapes forever
        createLabel() // Adding the 'Calculate'
        buttons() // Adding the buttons
    }
    override func viewWillAppear(_ animated: Bool) {
        addingBackgroundShapes()
        buttons()
    }
    
    
    @IBOutlet weak var ContentView: UIView!
    
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

        animation.duration = 2.5
        oval.add(animation, forKey: "basic animation")
        oval.zPosition = 0
        view.layer.addSublayer(oval)
    }
    
    func createLabel(){
        //Creating Label
        let questionLbl = UILabel()
        questionLbl.frame = CGRect(x: 35, y: 70, width: 200, height: 40)
        questionLbl.text = "Calculate."
        questionLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        questionLbl.textColor = UIColor.black
        questionLbl.layer.zPosition = 2
        view.addSubview(questionLbl)
    }
    
    @objc func IOPressed(_ sender: UIButton){
        sender.shake()
        let newStoryBoard : UIStoryboard = UIStoryboard(name: "InterestOnlyLoan", bundle:nil)
        let VC = newStoryBoard.instantiateViewController(withIdentifier: "InterestOnlyLoan")
        VC.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        self.present(VC, animated: false, completion: nil)
    }
    @objc func tvmPressed(_ sender: UIButton){
        sender.shake()
        let newStoryBoard : UIStoryboard = UIStoryboard(name: "TVM", bundle:nil)
        let VC = newStoryBoard.instantiateViewController(withIdentifier: "TVM")
        VC.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        self.present(VC, animated: false, completion: nil)
    }
    @objc func settingsPressed(_ sender: UIButton){
        sender.shake()
        let newStoryBoard : UIStoryboard = UIStoryboard(name: "Settings", bundle:nil)
        let VC = newStoryBoard.instantiateViewController(withIdentifier: "Settings")
        VC.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        self.present(VC, animated: false, completion: nil)
    }
    @objc func simpleIntPressed(_ sender: UIButton){
        sender.shake()
        let newStoryBoard : UIStoryboard = UIStoryboard(name: "SimpleInt", bundle:nil)
        let VC = newStoryBoard.instantiateViewController(withIdentifier: "SimpleInt")
        VC.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        self.present(VC, animated: false, completion: nil)
    }
    @objc func compoundIntPressed(_ sender: UIButton){
        sender.shake()
        let newStoryBoard : UIStoryboard = UIStoryboard(name: "CompoundInt", bundle:nil)
        let VC = newStoryBoard.instantiateViewController(withIdentifier: "CompoundInt")
        VC.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        self.present(VC, animated: false, completion: nil)
        
    }
    @objc func amortPressed(_ sender: UIButton){
        sender.shake()
        let newStoryBoard : UIStoryboard = UIStoryboard(name: "Amortization", bundle:nil)
        let VC = newStoryBoard.instantiateViewController(withIdentifier: "Amortization")
        VC.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        self.present(VC, animated: false, completion: nil)
    }
    func buttons(){
        // Creating Buttons
        // Interest-Only Loans
        intOnlyLoan.frame = CGRect(x: view.bounds.size.width/2 - 125, y: compoundIntbtn.frame.origin.y - 125, width: 250, height: 52)
        intOnlyLoan.setTitle("Interest-Only Loan", for: .normal)
        intOnlyLoan.backgroundColor = UIColor(named: "SpecialGreen")
        intOnlyLoan.layer.borderColor = UIColor.darkGray.cgColor
        intOnlyLoan.layer.borderWidth = 1
        intOnlyLoan.layer.cornerRadius = 5.0
        intOnlyLoan.layer.zPosition = 2
        intOnlyLoan.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        intOnlyLoan.addTarget(self, action: #selector(IOPressed), for: .touchUpInside)
        intOnlyLoan.pulsate()
        self.ContentView.addSubview(intOnlyLoan)

        //TVM Button
        tvmbtn.frame = CGRect(x: view.bounds.size.width/2 - 125, y: view.bounds.size.height/2 + 625, width: 250, height: 52)
        tvmbtn.setTitle("Lump Sum Annuity", for: .normal)
        tvmbtn.backgroundColor = UIColor(named: "SpecialGreen")
        tvmbtn.layer.borderColor = UIColor.darkGray.cgColor
        tvmbtn.layer.borderWidth = 1
        tvmbtn.layer.cornerRadius = 5.0
        tvmbtn.layer.zPosition = 2
        tvmbtn.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        tvmbtn.addTarget(self, action: #selector(tvmPressed), for: .touchUpInside)
        tvmbtn.pulsate()
        self.ContentView.addSubview(tvmbtn)
        
        //Help Button
        help.frame = CGRect(x: view.bounds.size.width/2 - 125, y: intOnlyLoan.frame.origin.y - 125, width: 250, height: 52)
        help.setTitle("Help", for: .normal)
        help.backgroundColor = UIColor(named: "SpecialGreen")
        help.layer.borderColor = UIColor.darkGray.cgColor
        help.layer.borderWidth = 1
        help.layer.cornerRadius = 5.0
        help.layer.zPosition = 2
        help.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        help.addTarget(self, action: #selector(IOPressed), for: .touchUpInside)
        help.pulsate()
        self.ContentView.addSubview(help)
        
        //Amortization Button
        amortbtn.frame = CGRect(x: view.bounds.size.width/2 - 125, y: tvmbtn.frame.origin.y - 125, width: 250, height: 52)
        amortbtn.setTitle("Amortized Loan", for: .normal)
        
        amortbtn.backgroundColor = UIColor(named: "SpecialGreen")
        amortbtn.layer.borderColor = UIColor.darkGray.cgColor
        amortbtn.layer.borderWidth = 1
        amortbtn.layer.cornerRadius = 5.0
        amortbtn.layer.zPosition = 2
        amortbtn.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        amortbtn.addTarget(self, action: #selector(amortPressed), for: .touchUpInside)
        amortbtn.pulsate()
        self.ContentView.addSubview(amortbtn)
        //Simple Interest Button
        
        simpleIntbtn.frame = CGRect(x: view.bounds.size.width/2 - 125, y: amortbtn.frame.origin.y - 125, width: 250, height: 52)
        simpleIntbtn.setTitle("Simple Interest", for: .normal)
        simpleIntbtn.backgroundColor = UIColor(named: "SpecialGreen")
        simpleIntbtn.layer.borderColor = UIColor.darkGray.cgColor
        simpleIntbtn.layer.borderWidth = 1
        simpleIntbtn.layer.cornerRadius = 5.0
        simpleIntbtn.layer.zPosition = 2
        simpleIntbtn.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        simpleIntbtn.addTarget(self, action: #selector(simpleIntPressed), for: .touchUpInside)
        simpleIntbtn.pulsate()
        self.ContentView.addSubview(simpleIntbtn)
        
        //Compound Interest Button
        compoundIntbtn.frame = CGRect(x: view.bounds.size.width/2 - 125, y: simpleIntbtn.frame.origin.y - 125, width: 250, height: 52)
        compoundIntbtn.setTitle("Compound Interest", for: .normal)
        compoundIntbtn.backgroundColor = UIColor(named: "SpecialGreen")
        compoundIntbtn.layer.borderColor = UIColor.darkGray.cgColor
        compoundIntbtn.layer.borderWidth = 1
        compoundIntbtn.layer.cornerRadius = 5.0
        compoundIntbtn.layer.zPosition = 2
        compoundIntbtn.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        compoundIntbtn.addTarget(self, action: #selector(compoundIntPressed), for: .touchUpInside)
        compoundIntbtn.pulsate()
        self.ContentView.addSubview(compoundIntbtn)
        
        // Creating Icon
        let settingConfiguration = UIImage.SymbolConfiguration(pointSize: 55, weight: .black)
        let settingsImage = UIImage(systemName: "gear", withConfiguration: settingConfiguration)
        //Settings Button
        
        settingsbtn.backgroundColor = .clear
        settingsbtn.layer.borderWidth = 0
        settingsbtn.frame = CGRect(x: view.bounds.size.width - 70, y: 60, width: 50, height: 50)
        settingsbtn.tintColor = UIColor.gray
        settingsbtn.setImage(settingsImage, for: .normal)
        settingsbtn.layer.zPosition = 2
        settingsbtn.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
        settingsbtn.rotate()
        self.view.addSubview(settingsbtn)
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
    func stopButtonAnimation(){
        layer.removeAllAnimations()
        layer.transform = CATransform3DIdentity
    }
    func shake(){
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    func rotate(){
        let spring = CASpringAnimation(keyPath: "transform.rotation")
        spring.damping = 10.0
        spring.fromValue = 3.0 * CGFloat(Double.pi)
        spring.toValue = 4.0 * CGFloat(Double.pi)
        spring.repeatCount = .infinity
        spring.autoreverses = true
        layer.add(spring, forKey: "rotation")
    }

}
