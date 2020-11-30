//
//  TVM.swift
//  Finance
//
//  Created by Jordan Klein on 11/21/20.
//

import Foundation
import UIKit

let backbtn = UIButton()

// UI Fields for TVM
let lookingFor = UITextField()
let TVMnumbertxtbox = UITextField() // Number of compounding periods
let TVMratetxtbox = UITextField() // interest rates
let TVMtimetxtbox = UITextField() // number of years
let TVMPVtxtbox = UITextField() // Present Value
let TVMFVtxtbox = UITextField() // Future Value

//UI Labels
let rateLbl = UILabel()
let numberLbl = UILabel()
let presentValueLbl = UILabel()
let finalValueLbl = UILabel()

// Final Totals
let futureValue = UILabel()

class TVM: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    var pickerView = UIPickerView()
    let choices = ["","Present Value","Future Value","Number of Periods","Rate"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingBackgroundShapes() // adding black background and top shape
        gestures()//Gestures
        header() // Time Value Money Header
        Labels() // adding labels
        fields() // what are you searching for?
        
        
        //UI-Fields Delegates
        TVMnumbertxtbox.delegate = self
        TVMratetxtbox.delegate = self
        TVMtimetxtbox.delegate = self
        TVMPVtxtbox.delegate = self
        TVMFVtxtbox.delegate = self
        //PickerView Delegates
        pickerView.delegate = self
        pickerView.dataSource = self
        
        lookingFor.delegate = self
        lookingFor.inputView = pickerView
        
    }
    
    func header(){
        //Creating Label
        let questionLbl = UILabel()
        questionLbl.frame = CGRect(x: 35, y: 70, width: 250, height: 40)
        questionLbl.text = "Lump Sum TVM"
        questionLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        questionLbl.textColor = UIColor.black
        questionLbl.layer.zPosition = 2
        view.addSubview(questionLbl)
        
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
    
    // Labels
    func Labels(){
        // Creating "What are you looking for?
        let questionLbl = UILabel()
        questionLbl.frame = CGRect(x: 35, y: 160, width: 350, height: 40)
        questionLbl.text = "What are you searching for?"
        questionLbl.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        questionLbl.textColor = UIColor.white
        questionLbl.layer.zPosition = 2
        view.addSubview(questionLbl)
    }
    func fields() {
        // Creating Done within the tool keyboard
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.black

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(firstRes))

        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)

        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        // textbox for number of periods
        lookingFor.frame = CGRect(x: 35, y: 200, width: 250, height: 40)
        lookingFor.borderStyle = UITextField.BorderStyle.bezel
        lookingFor.backgroundColor = UIColor.white
        lookingFor.textColor = UIColor.black
        lookingFor.keyboardType = .decimalPad
        lookingFor.inputAccessoryView = doneToolbar
        lookingFor.textAlignment = .center
        lookingFor.tintColor = UIColor.clear
        lookingFor.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.view.addSubview(lookingFor)
    }
    @objc func firstRes(){
        lookingFor.resignFirstResponder()
        TVMnumbertxtbox.resignFirstResponder()
        TVMratetxtbox.resignFirstResponder()
        TVMtimetxtbox.resignFirstResponder()
        TVMPVtxtbox.resignFirstResponder()
        TVMFVtxtbox.resignFirstResponder()
    }
    
    func PresentValue(){
        //TVM Fields remove
        TVMnumbertxtbox.removeFromSuperview()
        TVMtimetxtbox.removeFromSuperview()
        TVMratetxtbox.removeFromSuperview()
        TVMFVtxtbox.removeFromSuperview()
        TVMPVtxtbox.removeFromSuperview()
        rateLbl.removeFromSuperview()
        numberLbl.removeFromSuperview()
        presentValueLbl.removeFromSuperview()
        finalValueLbl.removeFromSuperview()
        futureValue.removeFromSuperview()
        
        //Looking for PV
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        doneToolbar.barStyle = UIBarStyle.black

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(firstRes))

        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)

        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        //Rate Label
        rateLbl.frame = CGRect(x: 35, y: 240, width: 250, height: 40)
        rateLbl.text = "Rate %"
        rateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        rateLbl.textColor = UIColor.white
        rateLbl.layer.zPosition = 2
        self.view.addSubview(rateLbl)
        
        //Rate Field
        TVMratetxtbox.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        TVMratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        TVMratetxtbox.backgroundColor = UIColor.white
        TVMratetxtbox.textColor = UIColor.black
        TVMratetxtbox.keyboardType = .decimalPad
        TVMratetxtbox.inputAccessoryView = doneToolbar
        TVMratetxtbox.textAlignment = .center
        TVMratetxtbox.tintColor = UIColor.clear
        TVMratetxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.view.addSubview(TVMratetxtbox)
        //Number Label
        
        numberLbl.frame = CGRect(x: 35, y: 320, width: 250, height: 40)
        numberLbl.text = "Number"
        numberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        numberLbl.textColor = UIColor.white
        numberLbl.layer.zPosition = 2
        self.view.addSubview(numberLbl)
        //Number of Periods Field
        TVMnumbertxtbox.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        TVMnumbertxtbox.borderStyle = UITextField.BorderStyle.bezel
        TVMnumbertxtbox.backgroundColor = UIColor.white
        TVMnumbertxtbox.textColor = UIColor.black
        TVMnumbertxtbox.keyboardType = .decimalPad
        TVMnumbertxtbox.inputAccessoryView = doneToolbar
        TVMnumbertxtbox.textAlignment = .center
        TVMnumbertxtbox.tintColor = UIColor.clear
        TVMnumbertxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.view.addSubview(TVMnumbertxtbox)
        //FV Label
        
        finalValueLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        finalValueLbl.text = "Future Value"
        finalValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        finalValueLbl.textColor = UIColor.white
        finalValueLbl.layer.zPosition = 2
        self.view.addSubview(finalValueLbl)
        //Future Value Field
        TVMFVtxtbox.frame = CGRect(x: 35, y: 440, width: 250, height: 40)
        TVMFVtxtbox.borderStyle = UITextField.BorderStyle.bezel
        TVMFVtxtbox.backgroundColor = UIColor.white
        TVMFVtxtbox.textColor = UIColor.black
        TVMFVtxtbox.keyboardType = .decimalPad
        TVMFVtxtbox.inputAccessoryView = doneToolbar
        TVMFVtxtbox.textAlignment = .center
        TVMFVtxtbox.tintColor = UIColor.clear
        TVMFVtxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.view.addSubview(TVMFVtxtbox)
        // PV Label
        
        // Calculation Button
        calc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        calc.setTitle("Calculate", for: .normal)
        calc.backgroundColor = UIColor(named: "SpecialGreen")
        calc.layer.borderColor = UIColor.darkGray.cgColor
        calc.layer.borderWidth = 1
        calc.layer.cornerRadius = 5.0
        calc.layer.zPosition = 2
        calc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        calc.addTarget(self, action: #selector(PVcalculation), for: .touchUpInside)
        self.view.addSubview(calc)
    }
    @objc func PVcalculation(){
        //Calculating PV
        if TVMFVtxtbox.hasText == false || TVMratetxtbox.hasText == false || TVMnumbertxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            // Calculation passes through validation
            let finalValue = Double(TVMFVtxtbox.text!)!
            let rate = Double(TVMratetxtbox.text!)! / 100
            let number = Double(TVMnumbertxtbox.text!)!
            print("Present Value: \(finalValue)")
            print("Rate: \(rate)")
            print("Number: \(number)")
            // Lump sum formula is PV  =  FV / (1 + i)^n
            let firstCalc = (1 + rate)
            print(firstCalc)
            let secondCalc = pow(firstCalc, number)
            print(secondCalc)
            let finalCalc = finalValue / secondCalc
            print(finalCalc)
            
            //Add Future Value Label
            presentValueLbl.frame = CGRect(x: 35, y: 530, width: 250, height: 40)
            presentValueLbl.text = "Future Value"
            presentValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            presentValueLbl.textColor = UIColor.white
            presentValueLbl.layer.zPosition = 2
            self.view.addSubview(presentValueLbl)
            //Add Future Value Label Amount
            let presentValueAnswer = UILabel()
            presentValueAnswer.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            presentValueAnswer.text = "$\(round(100.0 * finalCalc) / 100.0)"
            presentValueAnswer.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            presentValueAnswer.textColor = UIColor.white
            presentValueAnswer.layer.zPosition = 2
            self.view.addSubview(presentValueAnswer)
        }
    }
    func FutureValue(){
        // Looking for FV
        //TVM Fields remove
        TVMnumbertxtbox.removeFromSuperview()
        TVMtimetxtbox.removeFromSuperview()
        TVMratetxtbox.removeFromSuperview()
        TVMFVtxtbox.removeFromSuperview()
        TVMPVtxtbox.removeFromSuperview()
        rateLbl.removeFromSuperview()
        numberLbl.removeFromSuperview()
        presentValueLbl.removeFromSuperview()
        finalValueLbl.removeFromSuperview()
        futureValue.removeFromSuperview()
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.black

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(firstRes))

        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)

        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        //Rate Label
        rateLbl.frame = CGRect(x: 35, y: 240, width: 250, height: 40)
        rateLbl.text = "Rate %"
        rateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        rateLbl.textColor = UIColor.white
        rateLbl.layer.zPosition = 2
        self.view.addSubview(rateLbl)
        //Rate Field
        TVMratetxtbox.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        TVMratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        TVMratetxtbox.backgroundColor = UIColor.white
        TVMratetxtbox.textColor = UIColor.black
        TVMratetxtbox.keyboardType = .decimalPad
        TVMratetxtbox.inputAccessoryView = doneToolbar
        TVMratetxtbox.textAlignment = .center
        TVMratetxtbox.tintColor = UIColor.clear
        TVMratetxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.view.addSubview(TVMratetxtbox)
        //Number Label
        numberLbl.frame = CGRect(x: 35, y: 320, width: 250, height: 40)
        numberLbl.text = "Number"
        numberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        numberLbl.textColor = UIColor.white
        numberLbl.layer.zPosition = 2
        self.view.addSubview(numberLbl)
        //Number of Periods Field
        TVMnumbertxtbox.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        TVMnumbertxtbox.borderStyle = UITextField.BorderStyle.bezel
        TVMnumbertxtbox.backgroundColor = UIColor.white
        TVMnumbertxtbox.textColor = UIColor.black
        TVMnumbertxtbox.keyboardType = .decimalPad
        TVMnumbertxtbox.inputAccessoryView = doneToolbar
        TVMnumbertxtbox.textAlignment = .center
        TVMnumbertxtbox.tintColor = UIColor.clear
        TVMnumbertxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.view.addSubview(TVMnumbertxtbox)

        //PV Label
        presentValueLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        presentValueLbl.text = "Present Value"
        presentValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        presentValueLbl.textColor = UIColor.white
        presentValueLbl.layer.zPosition = 2
        self.view.addSubview(presentValueLbl)
        
        //Present Value Field
        TVMPVtxtbox.frame = CGRect(x: 35, y: 440, width: 250, height: 40)
        TVMPVtxtbox.borderStyle = UITextField.BorderStyle.bezel
        TVMPVtxtbox.backgroundColor = UIColor.white
        TVMPVtxtbox.textColor = UIColor.black
        TVMPVtxtbox.keyboardType = .decimalPad
        TVMPVtxtbox.inputAccessoryView = doneToolbar
        TVMPVtxtbox.textAlignment = .center
        TVMPVtxtbox.tintColor = UIColor.clear
        TVMPVtxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.view.addSubview(TVMPVtxtbox)
        
        // Calculation Button
        calc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        calc.setTitle("Calculate", for: .normal)
        calc.backgroundColor = UIColor(named: "SpecialGreen")
        calc.layer.borderColor = UIColor.darkGray.cgColor
        calc.layer.borderWidth = 1
        calc.layer.cornerRadius = 5.0
        calc.layer.zPosition = 2
        calc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        calc.addTarget(self, action: #selector(FVcalculation), for: .touchUpInside)
        self.view.addSubview(calc)
    }
    @objc func FVcalculation(){
        //Calculating FV
        //if statement to check through each field (ensuring they are not negative)
        if TVMPVtxtbox.hasText == false || TVMratetxtbox.hasText == false || TVMnumbertxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            // Calculation passes through validation
            let presentValue = Double(TVMPVtxtbox.text!)!
            let rate = Double(TVMratetxtbox.text!)! / 100
            let number = Double(TVMnumbertxtbox.text!)!
            print("Present Value: \(presentValue)")
            print("Rate: \(rate)")
            print("Number: \(number)")
            //Formula is FV  =  PV x (1 + i)^n
            let firstCalc = (1 + rate)
            print(firstCalc)
            let secondCalc = pow(firstCalc, number)
            print(secondCalc)
            let finalCalc = presentValue * secondCalc
            print(finalCalc)
            
            //Add Future Value Label
            finalValueLbl.frame = CGRect(x: 35, y: 530, width: 250, height: 40)
            finalValueLbl.text = "Future Value"
            finalValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            finalValueLbl.textColor = UIColor.white
            finalValueLbl.layer.zPosition = 2
            self.view.addSubview(finalValueLbl)
            //Add Future Value Label Amount
            
            futureValue.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            futureValue.text = "$\(round(100.0 * finalCalc) / 100.0)"
            futureValue.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            futureValue.textColor = UIColor.white
            futureValue.layer.zPosition = 2
            self.view.addSubview(futureValue)
        }
    }
    func RateValue(){
        // Looking for Rate
        //TVM Fields remove
        TVMnumbertxtbox.removeFromSuperview()
        TVMtimetxtbox.removeFromSuperview()
        TVMratetxtbox.removeFromSuperview()
        TVMFVtxtbox.removeFromSuperview()
        TVMPVtxtbox.removeFromSuperview()
        rateLbl.removeFromSuperview()
        numberLbl.removeFromSuperview()
        presentValueLbl.removeFromSuperview()
        finalValueLbl.removeFromSuperview()
        futureValue.removeFromSuperview()
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.black

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(firstRes))

        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)

        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        //Number Label
        numberLbl.frame = CGRect(x: 35, y: 240, width: 250, height: 40)
        numberLbl.text = "Number"
        numberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        numberLbl.textColor = UIColor.white
        numberLbl.layer.zPosition = 2
        self.view.addSubview(numberLbl)
        //Number of Periods Field
        TVMnumbertxtbox.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        TVMnumbertxtbox.borderStyle = UITextField.BorderStyle.bezel
        TVMnumbertxtbox.backgroundColor = UIColor.white
        TVMnumbertxtbox.textColor = UIColor.black
        TVMnumbertxtbox.keyboardType = .decimalPad
        TVMnumbertxtbox.inputAccessoryView = doneToolbar
        TVMnumbertxtbox.textAlignment = .center
        TVMnumbertxtbox.tintColor = UIColor.clear
        TVMnumbertxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.view.addSubview(TVMnumbertxtbox)
        //FV Label
        presentValueLbl.frame = CGRect(x: 35, y: 320, width: 250, height: 40)
        presentValueLbl.text = "Present Value"
        presentValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        presentValueLbl.textColor = UIColor.white
        presentValueLbl.layer.zPosition = 2
        self.view.addSubview(presentValueLbl)
        
        //Present Value Field
        TVMPVtxtbox.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        TVMPVtxtbox.borderStyle = UITextField.BorderStyle.bezel
        TVMPVtxtbox.backgroundColor = UIColor.white
        TVMPVtxtbox.textColor = UIColor.black
        TVMPVtxtbox.keyboardType = .decimalPad
        TVMPVtxtbox.inputAccessoryView = doneToolbar
        TVMPVtxtbox.textAlignment = .center
        TVMPVtxtbox.tintColor = UIColor.clear
        TVMPVtxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.view.addSubview(TVMPVtxtbox)
        //FV Label
        
        finalValueLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        finalValueLbl.text = "Future Value"
        finalValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        finalValueLbl.textColor = UIColor.white
        finalValueLbl.layer.zPosition = 2
        self.view.addSubview(finalValueLbl)
        //Future Value Field
        TVMFVtxtbox.frame = CGRect(x: 35, y: 440, width: 250, height: 40)
        TVMFVtxtbox.borderStyle = UITextField.BorderStyle.bezel
        TVMFVtxtbox.backgroundColor = UIColor.white
        TVMFVtxtbox.textColor = UIColor.black
        TVMFVtxtbox.keyboardType = .decimalPad
        TVMFVtxtbox.inputAccessoryView = doneToolbar
        TVMFVtxtbox.textAlignment = .center
        TVMFVtxtbox.tintColor = UIColor.clear
        TVMFVtxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.view.addSubview(TVMFVtxtbox)
        
        // Calculation Button
        calc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        calc.setTitle("Calculate", for: .normal)
        calc.backgroundColor = UIColor(named: "SpecialGreen")
        calc.layer.borderColor = UIColor.darkGray.cgColor
        calc.layer.borderWidth = 1
        calc.layer.cornerRadius = 5.0
        calc.layer.zPosition = 2
        calc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        calc.addTarget(self, action: #selector(Ratecalculation), for: .touchUpInside)
        self.view.addSubview(calc)
    }
    @objc func Ratecalculation(){
        //Calculating Rate
        //if statement to check through each field (ensuring they are not negative)
        if TVMPVtxtbox.hasText == false || TVMFVtxtbox.hasText == false ||  TVMnumbertxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            // Calculation passes through validation
            let presentValue = Double(TVMPVtxtbox.text!)!
            let finalValue = Double(TVMFVtxtbox.text!)!
            let number = Double(TVMnumbertxtbox.text!)!
            
            print("Present Value: \(presentValue)")
            print("Final Value: \(finalValue)")
            print("Number: \(number)")
            // Formula  i = (FV/ PV)^(1 / N) -1
            let firstCalc = (finalValue/presentValue)
            print(firstCalc)
            let secondCalc = pow(firstCalc, 1/number)
            print(secondCalc)
            let finalCalc = (secondCalc - 1) * 100
            print(finalCalc)
            
            //Add Future Value Label
            finalValueLbl.frame = CGRect(x: 35, y: 540, width: 250, height: 40)
            finalValueLbl.text = "Rate:"
            finalValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            finalValueLbl.textColor = UIColor.white
            finalValueLbl.layer.zPosition = 2
            self.view.addSubview(finalValueLbl)
            //Add Future Value Label Amount
            futureValue.frame = CGRect(x: 35, y: 590, width: 250, height: 40)
            futureValue.text = "\(round(100.0 * finalCalc) / 100.0)%"
            futureValue.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            futureValue.textColor = UIColor.white
            futureValue.layer.zPosition = 2
            self.view.addSubview(futureValue)
        }
    }
    func NumberofPeriodValue(){
        // Looking for Number of Periods
        TVMnumbertxtbox.removeFromSuperview()
        TVMtimetxtbox.removeFromSuperview()
        TVMratetxtbox.removeFromSuperview()
        TVMFVtxtbox.removeFromSuperview()
        TVMPVtxtbox.removeFromSuperview()
        rateLbl.removeFromSuperview()
        numberLbl.removeFromSuperview()
        presentValueLbl.removeFromSuperview()
        finalValueLbl.removeFromSuperview()
        futureValue.removeFromSuperview()
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.black

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(firstRes))

        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)

        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        // Should have 3 fields
        
        //FV Label
        rateLbl.frame = CGRect(x: 35, y: 240, width: 250, height: 40)
        rateLbl.text = "Rate %"
        rateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        rateLbl.textColor = UIColor.white
        rateLbl.layer.zPosition = 2
        self.view.addSubview(rateLbl)
        //Future Value Field
        TVMratetxtbox.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        TVMratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        TVMratetxtbox.backgroundColor = UIColor.white
        TVMratetxtbox.textColor = UIColor.black
        TVMratetxtbox.keyboardType = .decimalPad
        TVMratetxtbox.inputAccessoryView = doneToolbar
        TVMratetxtbox.textAlignment = .center
        TVMratetxtbox.tintColor = UIColor.clear
        TVMratetxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.view.addSubview(TVMratetxtbox)

        //PV Label
        presentValueLbl.frame = CGRect(x: 35, y: 320, width: 250, height: 40)
        presentValueLbl.text = "Present Value"
        presentValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        presentValueLbl.textColor = UIColor.white
        presentValueLbl.layer.zPosition = 2
        self.view.addSubview(presentValueLbl)
        
        //Present Value Field
        TVMPVtxtbox.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        TVMPVtxtbox.borderStyle = UITextField.BorderStyle.bezel
        TVMPVtxtbox.backgroundColor = UIColor.white
        TVMPVtxtbox.textColor = UIColor.black
        TVMPVtxtbox.keyboardType = .decimalPad
        TVMPVtxtbox.inputAccessoryView = doneToolbar
        TVMPVtxtbox.textAlignment = .center
        TVMPVtxtbox.tintColor = UIColor.clear
        TVMPVtxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.view.addSubview(TVMPVtxtbox)
        
        //FV Label
        finalValueLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        finalValueLbl.text = "Future Value"
        finalValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        finalValueLbl.textColor = UIColor.white
        finalValueLbl.layer.zPosition = 2
        self.view.addSubview(finalValueLbl)
        
        //Present Value Field
        TVMFVtxtbox.frame = CGRect(x: 35, y: 440, width: 250, height: 40)
        TVMFVtxtbox.borderStyle = UITextField.BorderStyle.bezel
        TVMFVtxtbox.backgroundColor = UIColor.white
        TVMFVtxtbox.textColor = UIColor.black
        TVMFVtxtbox.keyboardType = .decimalPad
        TVMFVtxtbox.inputAccessoryView = doneToolbar
        TVMFVtxtbox.textAlignment = .center
        TVMFVtxtbox.tintColor = UIColor.clear
        TVMFVtxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.view.addSubview(TVMFVtxtbox)
        
        // Calculation Button
        calc.frame = CGRect(x: 35, y: 490, width: 250, height: 40) // hieght extra 10
        calc.setTitle("Calculate", for: .normal)
        calc.backgroundColor = UIColor(named: "SpecialGreen")
        calc.layer.borderColor = UIColor.darkGray.cgColor
        calc.layer.borderWidth = 1
        calc.layer.cornerRadius = 5.0
        calc.layer.zPosition = 2
        calc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        calc.addTarget(self, action: #selector(Periodcalculation), for: .touchUpInside)
        self.view.addSubview(calc)
    }
    @objc func Periodcalculation(){
        //Calculating Periods
        if TVMPVtxtbox.hasText == false || TVMFVtxtbox.hasText == false ||  TVMratetxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            // Calculation passes through validation
            let presentValue = Double(TVMPVtxtbox.text!)!
            let finalValue = Double(TVMFVtxtbox.text!)!
            let rate = Double(TVMratetxtbox.text!)! / 100
            
            print("Present Value: \(presentValue)")
            print("Final Value: \(finalValue)")
            print("Rate: \(rate)")
            // Formula  Number = LN(FV / PV) / LN(1 + i)
            let firstCalc = log((presentValue/finalValue))
            print(firstCalc)
            let secondCalc = log(1+rate)
            print(secondCalc)
            let finalCalc = firstCalc/secondCalc
            print(finalCalc)
            
            //Add Future Value Label
            finalValueLbl.frame = CGRect(x: 35, y: 540, width: 250, height: 40)
            finalValueLbl.text = "Number of Periods:"
            finalValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            finalValueLbl.textColor = UIColor.white
            finalValueLbl.layer.zPosition = 2
            self.view.addSubview(finalValueLbl)
            //Add Future Value Label Amount
            futureValue.frame = CGRect(x: 35, y: 590, width: 250, height: 40)
            futureValue.text = "\(round(100.0 * abs(finalCalc)) / 100.0)"
            futureValue.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            futureValue.textColor = UIColor.white
            futureValue.layer.zPosition = 2
            self.view.addSubview(futureValue)
        }
    }
}

extension TVM: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        choices.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lookingFor.text = choices[row]
        let selectedValue = choices[pickerView.selectedRow(inComponent: 0)]
        if selectedValue == "Present Value" {
            print("Present Value Selected")
            // Present Value Stuff
            PresentValue()
        } else if selectedValue == "Future Value" {
            print("Future Value Selected")
            // Future Value Stuff
            FutureValue()
        } else if selectedValue == "Number of Periods" {
            print("Number of Periods Selected")
            // # of period stuff
            NumberofPeriodValue()
        } else if selectedValue == "Rate" {
            print("Rate Selected")
            RateValue()
            // Rate Stuff
        } else {
            print("Remove Everything")
            // Nothing selected so remove views
            TVMnumbertxtbox.removeFromSuperview()
            TVMratetxtbox.removeFromSuperview()
            TVMFVtxtbox.removeFromSuperview()
            TVMPVtxtbox.removeFromSuperview()
            rateLbl.removeFromSuperview()
            numberLbl.removeFromSuperview()
            presentValueLbl.removeFromSuperview()
            finalValueLbl.removeFromSuperview()
            calc.removeFromSuperview()
            futureValue.removeFromSuperview()
        }
    } // end of picker view change
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let arrayOfString = newString.components(separatedBy: ".")

        if arrayOfString.count > 2 { // limiting how many decimals can exist
            return false
        }
        return true
    }
} // of TVM Class


// Extra Math Formulas
//class func pmt(rate : Double, nper : Double, pv : Double, fv : Double = 0, type : Double = 0) -> Double {
//    return ((-pv * pvif(rate: rate, nper: nper) - fv) / ((1.0 + rate * type) * fvifa(rate: rate, nper: nper)))
//}
//
//class func pow1pm1(x : Double, y : Double) -> Double {
//    return (x <= -1) ? pow((1 + x), y) - 1 : exp(y * log(1.0 + x)) - 1
//}
//
//class func pow1p(x : Double, y : Double) -> Double {
//    return (abs(x) > 0.5) ? pow((1 + x), y) : exp(y * log(1.0 + x))
//}
//
//class func pvif(rate : Double, nper : Double) -> Double {
//    return pow1p(x: rate, y: nper)
//}
//
//class func fvifa(rate : Double, nper : Double) -> Double {
//    return (rate == 0) ? nper : pow1pm1(x: rate, y: nper) / rate
//}
