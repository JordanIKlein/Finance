//
//  Main Menu.swift
//  Finance
//
//  Created by Jordan Klein on 11/21/20.
//

import Foundation
import UIKit


//Creation of Buttons
let amortbtn = UIButton()
let simpleIntbtn = UIButton()
let compoundIntbtn = UIButton()
let settingsbtn = UIButton()
let tvmbtn = UIButton()
let intOnlyLoan = UIButton()
let topTri = CAShapeLayer()

let help = UIButton()
let annuityDue = UIButton()
let ordinaryAnnuity = UIButton()


class MainMenu: UIViewController{
    
    @IBOutlet weak var ContentView: UIView!
    
    var shapeTimer: Timer?
    let oval = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLabel()
        buttons() //Help and Settings
        addingBackgroundShapes() //Adding the top triangle/rect
        addingAnnuities()// annuities
        addingLoans()// loans
        addingInterest()// interest
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.addSubview(settingsbtn)
        addingBackgroundShapes()
        buttons() //Help and Settings
        addingAnnuities()// annuities
        addingLoans()// loans
        addingInterest()// interest
    }
    
    //Creating a timer which will spawn in multiple shapes
    func addingBackgroundShapes(){
        self.view.backgroundColor = UIColor(named: "SpecialGreen")
        self.ContentView.backgroundColor = UIColor.black
        let path = UIBezierPath()
        path.move(to: CGPoint(x:0,y:0))
        path.addLine(to: CGPoint(x:view.bounds.maxX, y:view.bounds.minY))
        path.addLine(to: CGPoint(x:view.bounds.maxX, y:view.bounds.minY + 140))
        path.addLine(to: CGPoint(x:0, y:160))
        
        topTri.path = path.cgPath
        topTri.zPosition = 1
        topTri.fillColor = UIColor(named: "SpecialGreen")?.cgColor
        self.view.layer.addSublayer(topTri)
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
    
    func buttons(){
        //Help Button
        help.frame = CGRect(x: view.bounds.size.width/2 - 125, y: 920, width: 250, height: 52)
        help.setTitle("Help", for: .normal)
        help.backgroundColor = UIColor(named: "SpecialGreen")
        help.layer.borderColor = UIColor.darkGray.cgColor
        help.layer.borderWidth = 1
        help.layer.cornerRadius = 5.0
        help.layer.zPosition = 3
        help.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        help.addTarget(self, action: #selector(helpPressed), for: .touchUpInside)
        help.pulsate()
        self.ContentView.addSubview(help)
        // Creating Icon
        let settingConfiguration = UIImage.SymbolConfiguration(pointSize: 55, weight: .black)
        let settingsImage = UIImage(systemName: "gear", withConfiguration: settingConfiguration)
        //Settings Button
        settingsbtn.backgroundColor = .clear
        settingsbtn.layer.borderWidth = 0
        settingsbtn.frame = CGRect(x: view.bounds.size.width - 70, y: 60, width: 50, height: 50)
        settingsbtn.tintColor = UIColor.gray
        settingsbtn.setImage(settingsImage, for: .normal)
        settingsbtn.layer.zPosition = 3
        settingsbtn.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
    }
    
    func addingAnnuities(){
        // Adding the subviews after declaration
        //Annuity Due Button
        annuityDue.frame = CGRect(x: view.bounds.size.width/2 - 125, y: help.frame.origin.y - 110, width: 250, height: 52)
        annuityDue.setTitle("Annuity Due", for: .normal)
        annuityDue.backgroundColor = UIColor(named: "SpecialGreen")
        annuityDue.layer.borderColor = UIColor.darkGray.cgColor
        annuityDue.layer.borderWidth = 1
        annuityDue.layer.cornerRadius = 5.0
        annuityDue.layer.zPosition = 3
        annuityDue.tintColor = UIColor(named: "SpecialGreen")
        annuityDue.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        annuityDue.addTarget(self, action: #selector(AnnuityDuePressed), for: .touchUpInside)
        annuityDue.pulsate()
        self.ContentView.addSubview(annuityDue)
        //Annuity Due Button
        ordinaryAnnuity.frame = CGRect(x: view.bounds.size.width/2 - 125, y: annuityDue.frame.origin.y - 110, width: 250, height: 52)
        ordinaryAnnuity.setTitle("Ordinary Annuity", for: .normal)
        ordinaryAnnuity.backgroundColor = UIColor(named: "SpecialGreen")
        ordinaryAnnuity.layer.borderColor = UIColor.darkGray.cgColor
        ordinaryAnnuity.layer.borderWidth = 1
        ordinaryAnnuity.layer.cornerRadius = 5.0
        ordinaryAnnuity.layer.zPosition = 3
        ordinaryAnnuity.tintColor = UIColor(named: "SpecialGreen")
        ordinaryAnnuity.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        ordinaryAnnuity.addTarget(self, action: #selector(ordinaryAPressed), for: .touchUpInside)
        ordinaryAnnuity.pulsate()
        self.ContentView.addSubview(ordinaryAnnuity)
        
        //TVM Button
        tvmbtn.frame = CGRect(x: view.bounds.size.width/2 - 125, y: ordinaryAnnuity.frame.origin.y - 110, width: 250, height: 52)
        tvmbtn.setTitle("Lump Sum Payment", for: .normal)
        tvmbtn.backgroundColor = UIColor(named: "SpecialGreen")
        tvmbtn.layer.borderColor = UIColor.darkGray.cgColor
        tvmbtn.layer.borderWidth = 1
        tvmbtn.layer.cornerRadius = 5.0
        tvmbtn.layer.zPosition = 3
        tvmbtn.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        tvmbtn.addTarget(self, action: #selector(tvmPressed), for: .touchUpInside)
        tvmbtn.pulsate()
        self.ContentView.addSubview(tvmbtn)
    }
    
    func addingLoans(){
        // Interest-Only Loans
        intOnlyLoan.frame = CGRect(x: view.bounds.size.width/2 - 125, y: amortbtn.frame.origin.y - 110, width: 250, height: 52)
        intOnlyLoan.setTitle("Interest-Only Loan", for: .normal)
        intOnlyLoan.backgroundColor = UIColor(named: "SpecialGreen")
        intOnlyLoan.layer.borderColor = UIColor.darkGray.cgColor
        intOnlyLoan.layer.borderWidth = 1
        intOnlyLoan.layer.cornerRadius = 5.0
        intOnlyLoan.layer.zPosition = 3
        intOnlyLoan.tintColor = UIColor.black
        intOnlyLoan.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        intOnlyLoan.addTarget(self, action: #selector(IOPressed), for: .touchUpInside)
        intOnlyLoan.pulsate()
        self.ContentView.addSubview(intOnlyLoan)
        
        //Amortization Button
        amortbtn.frame = CGRect(x: view.bounds.size.width/2 - 125, y: tvmbtn.frame.origin.y - 110, width: 250, height: 52)
        amortbtn.setTitle("Amortized Loan", for: .normal)
        
        amortbtn.backgroundColor = UIColor(named: "SpecialGreen")
        amortbtn.layer.borderColor = UIColor.darkGray.cgColor
        amortbtn.layer.borderWidth = 1
        amortbtn.layer.cornerRadius = 5.0
        amortbtn.layer.zPosition = 3
        amortbtn.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        amortbtn.addTarget(self, action: #selector(amortPressed), for: .touchUpInside)
        amortbtn.pulsate()
        self.ContentView.addSubview(amortbtn)
    }
    func addingInterest(){ // run after adding loans
        //Compound Interest Button
        compoundIntbtn.frame = CGRect(x: view.bounds.size.width/2 - 125, y: intOnlyLoan.frame.origin.y - 110, width: 250, height: 52)
        compoundIntbtn.setTitle("Compound Interest", for: .normal)
        compoundIntbtn.backgroundColor = UIColor(named: "SpecialGreen")
        compoundIntbtn.layer.borderColor = UIColor.darkGray.cgColor
        compoundIntbtn.layer.borderWidth = 1
        compoundIntbtn.layer.cornerRadius = 5.0
        compoundIntbtn.layer.zPosition = 3
        compoundIntbtn.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        compoundIntbtn.addTarget(self, action: #selector(compoundIntPressed), for: .touchUpInside)
        compoundIntbtn.pulsate()
        
        self.ContentView.addSubview(compoundIntbtn)
        //Simple Interest Button
        simpleIntbtn.frame = CGRect(x: view.bounds.size.width/2 - 125, y: compoundIntbtn.frame.origin.y - 110, width: 250, height: 52)
        simpleIntbtn.setTitle("Simple Interest", for: .normal)
        simpleIntbtn.backgroundColor = UIColor(named: "SpecialGreen")
        simpleIntbtn.layer.borderColor = UIColor.darkGray.cgColor
        simpleIntbtn.layer.borderWidth = 1
        simpleIntbtn.layer.cornerRadius = 5.0
        simpleIntbtn.layer.zPosition = 3
        simpleIntbtn.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        simpleIntbtn.addTarget(self, action: #selector(simpleIntPressed), for: .touchUpInside)
        simpleIntbtn.pulsate()
        self.ContentView.addSubview(simpleIntbtn)
    }
    @objc func helpPressed(_ sender: UIButton){
        NotificationCenter.default.post(name: .showInterstitialAd, object: nil)
        sender.shake()
        let newStoryBoard : UIStoryboard = UIStoryboard(name: "Help", bundle:nil)
        let VC = newStoryBoard.instantiateViewController(withIdentifier: "Help")
        VC.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        self.present(VC, animated: false, completion: nil)
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
    @objc func ordinaryAPressed(_ sender: UIButton){
        sender.shake()
        let newStoryBoard : UIStoryboard = UIStoryboard(name: "OrdinaryAnnuity", bundle:nil)
        let VC = newStoryBoard.instantiateViewController(withIdentifier: "OrdinaryAnnuity")
        VC.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        self.present(VC, animated: false, completion: nil)
    }
    @objc func AnnuityDuePressed(_ sender: UIButton){
        sender.shake()
        let newStoryBoard : UIStoryboard = UIStoryboard(name: "AnnuityDue", bundle:nil)
        let VC = newStoryBoard.instantiateViewController(withIdentifier: "AnnuityDue")
        VC.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        self.present(VC, animated: false, completion: nil)
    }

} // END OF CLASS

extension UIButton{
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 1.0
        pulse.fromValue = 0.99
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.15
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

}
