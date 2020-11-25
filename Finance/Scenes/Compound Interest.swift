//
//  Compound Interest.swift
//  Finance
//
//  Created by Jordan Klein on 11/21/20.
//

import Foundation
import UIKit

// UITextfieldsCompound
let COMpritxtBox = UITextField()
let COMratetxtBox = UITextField()
let COMtimetxtBox = UITextField()
// Final result label Compound
let COMtotalcalcLbl = UILabel()
let COMintcalcLbl = UILabel()

class CompoundInt: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        addingBackgroundShapes() // adding black background and top shape
        gestures()
        createLabel() // Header and Back Button
        labels() //Labels
        textBoxes() // Creating the textboxes
        calculateButton() // Creating the calculate button
    }
    func createLabel(){
        //Creating Label
        let questionLbl = UILabel()
        questionLbl.frame = CGRect(x: 35, y: 70, width: 250, height: 40)
        questionLbl.text = "Compound Interest."
        questionLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        questionLbl.textColor = UIColor.black
        questionLbl.layer.zPosition = 2
        view.addSubview(questionLbl)
        
        //Icon for Back
        
        // Creating Icon
        let backConfiguration = UIImage.SymbolConfiguration(pointSize: 55, weight: .black)
        let backImage = UIImage(systemName: "arrow.left", withConfiguration: backConfiguration)
        // Adding Back Button
        backbtn.backgroundColor = .clear
        backbtn.layer.borderWidth = 0
        backbtn.frame = CGRect(x: view.bounds.size.width - 90, y: 60, width: 80, height: 50)
        backbtn.tintColor = UIColor.gray
        backbtn.setImage(backImage, for: .normal)
        backbtn.layer.zPosition = 2
        backbtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view.addSubview(backbtn)
    }
    func gestures(){
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
            edgePan.edges = .left

            view.addGestureRecognizer(edgePan)
    }
    @objc func back(){
        navigationController?.popViewController(animated: true)
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: true, completion: nil)
    }
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            navigationController?.popViewController(animated: true)
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromLeft
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window?.layer.add(transition, forKey: kCATransition)
            dismiss(animated: true, completion: nil)
        }
        
    }
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
    
    
    //Function for adding Labels
    func labels(){
        //Principal Label
        let principalLbl = UILabel()
        principalLbl.frame = CGRect(x: 35, y: 200, width: 250, height: 40)
        principalLbl.text = "Principal"
        principalLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        principalLbl.textColor = UIColor.white
        principalLbl.layer.zPosition = 2
        self.view.addSubview(principalLbl)
        //Rate Label
        let rateLbl = UILabel()
        rateLbl.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        rateLbl.text = "Rate %"
        rateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        rateLbl.textColor = UIColor.white
        rateLbl.layer.zPosition = 2
        self.view.addSubview(rateLbl)
        //Time Label
        let timeLbl = UILabel()
        timeLbl.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        timeLbl.text = "Time"
        timeLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        timeLbl.textColor = UIColor.white
        timeLbl.layer.zPosition = 2
        self.view.addSubview(timeLbl)
        
    }
    //Function for adding text boxes
    func textBoxes(){
        // Principal Amount
        
        COMpritxtBox.frame = CGRect(x: 35, y: 240, width: 200, height: 40)
        COMpritxtBox.borderStyle = UITextField.BorderStyle.bezel
        COMpritxtBox.backgroundColor = UIColor.white
        COMpritxtBox.textColor = UIColor.black
        self.view.addSubview(COMpritxtBox)
        //Rate Amount
        
        COMratetxtBox.frame = CGRect(x: 35, y: 320, width: 100, height: 40)
        COMratetxtBox.borderStyle = UITextField.BorderStyle.bezel
        COMratetxtBox.backgroundColor = UIColor.white
        COMratetxtBox.textColor = UIColor.black
        self.view.addSubview(COMratetxtBox)
        // time amount
        
        COMtimetxtBox.frame = CGRect(x: 35, y: 400, width: 100, height: 40)
        COMtimetxtBox.borderStyle = UITextField.BorderStyle.bezel
        COMtimetxtBox.backgroundColor = UIColor.white
        COMtimetxtBox.textColor = UIColor.black
        self.view.addSubview(COMtimetxtBox)
    }
    func calculateButton() {
        
        calc.frame = CGRect(x: 175, y: 400, width: 200, height: 40)
        calc.setTitle("Calculate", for: .normal)
        calc.backgroundColor = UIColor(named: "SpecialGreen")
        calc.layer.borderColor = UIColor.darkGray.cgColor
        calc.layer.borderWidth = 1
        calc.layer.cornerRadius = 5.0
        calc.layer.zPosition = 2
        calc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        calc.addTarget(self, action: #selector(calculation), for: .touchUpInside)
        self.view.addSubview(calc)
    }
    func dropdown(){
        // add dropdown
        
    }
    //Calculation objc
    @objc func calculation(){
        
        calcLbl.text = ""
        // if month/year is not selected bring error message!
        // Validation Here
        
        //Continue through
        let principal = Double(COMpritxtBox.text!)!
        let rate = Double(COMratetxtBox.text!)!
        let time = Double(COMtimetxtBox.text!)!
        let number = 12
        // monthly or yearly
        let inside = 1 + ((rate/100) / Double(number)) // Good
        
        let exponent = Double(number) * time
        
        let withoutPrincipal = pow(inside, exponent)
        
        let endCalc = principal * withoutPrincipal
        
        // Create Total Amount Label
        let totalAMTLbl = UILabel()
        totalAMTLbl.frame = CGRect(x: 35, y: 440, width: 300, height: 40)
        totalAMTLbl.text = "Total Amount:"
        totalAMTLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        totalAMTLbl.textColor = UIColor.white
        totalAMTLbl.layer.zPosition = 2
        view.addSubview(totalAMTLbl)
        
        // Returns Total Principal with Interest
        COMtotalcalcLbl.frame = CGRect(x: 35, y: 480, width: 300, height: 40)
        COMtotalcalcLbl.text = "\(round(100.0 * endCalc) / 100.0)"
        COMtotalcalcLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        COMtotalcalcLbl.textColor = UIColor.white
        COMtotalcalcLbl.layer.zPosition = 2
        self.view.addSubview(COMtotalcalcLbl)
        
        // Create Total Amount Label
        let totalIntAMTLbl = UILabel()
        totalIntAMTLbl.frame = CGRect(x: 35, y: 520, width: 300, height: 40)
        totalIntAMTLbl.text = "Total Interest:"
        totalIntAMTLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        totalIntAMTLbl.textColor = UIColor.white
        totalIntAMTLbl.layer.zPosition = 2
        view.addSubview(totalIntAMTLbl)
        
        // Returns Total Interest
        COMintcalcLbl.frame = CGRect(x: 35, y: 560, width: 300, height: 40)
        COMintcalcLbl.text = "\(round(100.0 * (endCalc-principal)) / 100.0)"
        COMintcalcLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        COMintcalcLbl.textColor = UIColor.white
        COMintcalcLbl.layer.zPosition = 2
        self.view.addSubview(COMintcalcLbl)
        
    }
    
}
