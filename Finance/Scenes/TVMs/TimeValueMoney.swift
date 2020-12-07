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

// UI Text Fields
let TVMnumbertxtbox = UITextField() // Number of compounding periods
let TVMratetxtbox = UITextField() // interest rates
let TVMPVtxtbox = UITextField() // Present Value
let TVMFVtxtbox = UITextField() // Future Value

//UI Labels
let rateLbl = UILabel()
let numberLbl = UILabel()
let presentValueLbl = UILabel()
let finalValueLbl = UILabel()

// Final Totals
let futureValueAnswer = UILabel()
let presentValueAnswer = UILabel()
let rateValue = UILabel()
let numberValue = UILabel()

//calc buttons
let PVcalc = UIButton()
let FVcalc = UIButton()
let Ratecalc = UIButton()
let Numcalc = UIButton()

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
        TVMPVtxtbox.delegate = self
        TVMFVtxtbox.delegate = self
        
        //PickerView Delegates
        pickerView.delegate = self
        pickerView.dataSource = self
        
        lookingFor.delegate = self
        lookingFor.inputView = pickerView
        
    }
    
    @IBOutlet weak var ContentView: UIView!
    func header(){
        //Creating Label
        let questionLbl = UILabel()
        questionLbl.frame = CGRect(x: 35, y: 70, width: 250, height: 40)
        questionLbl.text = "Lump Sum Annuity"
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
        dismiss(animated: false, completion: nil)
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
            dismiss(animated: false, completion: nil)
        }
        
    }
    func addingBackgroundShapes(){
        self.ContentView.backgroundColor = UIColor.black
        self.view.backgroundColor = UIColor(named: "SpecialGreen")
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
        self.ContentView.addSubview(questionLbl)
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
        self.ContentView.addSubview(lookingFor)
    }
    @objc func firstRes(){
        lookingFor.resignFirstResponder()
        TVMnumbertxtbox.resignFirstResponder()
        TVMratetxtbox.resignFirstResponder()
        TVMPVtxtbox.resignFirstResponder()
        TVMFVtxtbox.resignFirstResponder()
    }
    func removeEverything(){
        TVMnumbertxtbox.removeFromSuperview()
        TVMratetxtbox.removeFromSuperview()
        TVMPVtxtbox.removeFromSuperview()
        TVMFVtxtbox.removeFromSuperview()
        
        rateLbl.removeFromSuperview()
        numberLbl.removeFromSuperview()
        presentValueLbl.removeFromSuperview()
        finalValueLbl.removeFromSuperview()
        
        futureValueAnswer.removeFromSuperview()
        presentValueAnswer.removeFromSuperview()
        rateValue.removeFromSuperview()
        numberValue.removeFromSuperview()
        
        PVcalc.removeFromSuperview()
        FVcalc.removeFromSuperview()
        Ratecalc.removeFromSuperview()
        Numcalc.removeFromSuperview()
    }
    func PresentValue(){
        //TVM Fields remove
        removeEverything()
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
        self.ContentView.addSubview(rateLbl)
        
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
        self.ContentView.addSubview(TVMratetxtbox)
        //Number Label
        
        numberLbl.frame = CGRect(x: 35, y: 320, width: 250, height: 40)
        numberLbl.text = "Number"
        numberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        numberLbl.textColor = UIColor.white
        numberLbl.layer.zPosition = 2
        self.ContentView.addSubview(numberLbl)
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
        self.ContentView.addSubview(TVMnumbertxtbox)
        //FV Label
        
        finalValueLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        finalValueLbl.text = "Future Value"
        finalValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        finalValueLbl.textColor = UIColor.white
        finalValueLbl.layer.zPosition = 2
        self.ContentView.addSubview(finalValueLbl)
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
        self.ContentView.addSubview(TVMFVtxtbox)
        // PV Label
        
        // Calculation Button
        PVcalc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        PVcalc.setTitle("Calculate", for: .normal)
        PVcalc.backgroundColor = UIColor(named: "SpecialGreen")
        PVcalc.layer.borderColor = UIColor.darkGray.cgColor
        PVcalc.layer.borderWidth = 1
        PVcalc.layer.cornerRadius = 5.0
        PVcalc.layer.zPosition = 2
        PVcalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        PVcalc.addTarget(self, action: #selector(PVcalculation), for: .touchUpInside)
        self.ContentView.addSubview(PVcalc)
    }
    @objc func PVcalculation(){
        //Calculating PV
        
        //Resign first responder
        lookingFor.resignFirstResponder()
        TVMnumbertxtbox.resignFirstResponder()
        TVMratetxtbox.resignFirstResponder()
        TVMPVtxtbox.resignFirstResponder()
        TVMFVtxtbox.resignFirstResponder()
        
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
            presentValueLbl.text = "Present Value"
            presentValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            presentValueLbl.textColor = UIColor.white
            presentValueLbl.layer.zPosition = 2
            self.ContentView.addSubview(presentValueLbl)
            //Add Future Value Label Amount
            
            presentValueAnswer.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            presentValueAnswer.text = "\(currencyDefault)\(round(100.0 * finalCalc) / 100.0)"
            presentValueAnswer.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            presentValueAnswer.textColor = UIColor.white
            presentValueAnswer.layer.zPosition = 2
            self.ContentView.addSubview(presentValueAnswer)
        }
    }
    func FutureValue(){
        removeEverything()
        // Looking for FV
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
        self.ContentView.addSubview(rateLbl)
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
        self.ContentView.addSubview(TVMratetxtbox)
        //Number Label
        numberLbl.frame = CGRect(x: 35, y: 320, width: 250, height: 40)
        numberLbl.text = "Number"
        numberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        numberLbl.textColor = UIColor.white
        numberLbl.layer.zPosition = 2
        self.ContentView.addSubview(numberLbl)
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
        self.ContentView.addSubview(TVMnumbertxtbox)

        //PV Label
        presentValueLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        presentValueLbl.text = "Present Value"
        presentValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        presentValueLbl.textColor = UIColor.white
        presentValueLbl.layer.zPosition = 2
        self.ContentView.addSubview(presentValueLbl)
        
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
        self.ContentView.addSubview(TVMPVtxtbox)
        
        // Calculation Button
        FVcalc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        FVcalc.setTitle("Calculate", for: .normal)
        FVcalc.backgroundColor = UIColor(named: "SpecialGreen")
        FVcalc.layer.borderColor = UIColor.darkGray.cgColor
        FVcalc.layer.borderWidth = 1
        FVcalc.layer.cornerRadius = 5.0
        FVcalc.layer.zPosition = 2
        FVcalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        FVcalc.addTarget(self, action: #selector(FVcalculation), for: .touchUpInside)
        self.ContentView.addSubview(FVcalc)
    }
    @objc func FVcalculation(){
        //Calculating FV
        //Resign first responder
        lookingFor.resignFirstResponder()
        TVMnumbertxtbox.resignFirstResponder()
        TVMratetxtbox.resignFirstResponder()
        TVMPVtxtbox.resignFirstResponder()
        TVMFVtxtbox.resignFirstResponder()
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
            self.ContentView.addSubview(finalValueLbl)
            //Add Future Value Label Amount
            futureValueAnswer.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            futureValueAnswer.text = "\(currencyDefault)\(round(100.0 * finalCalc) / 100.0)"
            futureValueAnswer.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            futureValueAnswer.textColor = UIColor.white
            futureValueAnswer.layer.zPosition = 2
            self.ContentView.addSubview(futureValueAnswer)
        }
    }
    func RateValue(){
        removeEverything()
        // Looking for Rate
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
        self.ContentView.addSubview(numberLbl)
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
        self.ContentView.addSubview(TVMnumbertxtbox)
        //FV Label
        presentValueLbl.frame = CGRect(x: 35, y: 320, width: 250, height: 40)
        presentValueLbl.text = "Present Value"
        presentValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        presentValueLbl.textColor = UIColor.white
        presentValueLbl.layer.zPosition = 2
        self.ContentView.addSubview(presentValueLbl)
        
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
        self.ContentView.addSubview(TVMPVtxtbox)
        //FV Label
        
        finalValueLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        finalValueLbl.text = "Future Value"
        finalValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        finalValueLbl.textColor = UIColor.white
        finalValueLbl.layer.zPosition = 2
        self.ContentView.addSubview(finalValueLbl)
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
        self.ContentView.addSubview(TVMFVtxtbox)
        
        // Calculation Button
        Ratecalc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        Ratecalc.setTitle("Calculate", for: .normal)
        Ratecalc.backgroundColor = UIColor(named: "SpecialGreen")
        Ratecalc.layer.borderColor = UIColor.darkGray.cgColor
        Ratecalc.layer.borderWidth = 1
        Ratecalc.layer.cornerRadius = 5.0
        Ratecalc.layer.zPosition = 2
        Ratecalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        Ratecalc.addTarget(self, action: #selector(Ratecalculation), for: .touchUpInside)
        self.ContentView.addSubview(Ratecalc)
    }
    @objc func Ratecalculation(){
        //Calculating Rate
        //Resign first responder
        lookingFor.resignFirstResponder()
        TVMnumbertxtbox.resignFirstResponder()
        TVMratetxtbox.resignFirstResponder()
        TVMPVtxtbox.resignFirstResponder()
        TVMFVtxtbox.resignFirstResponder()
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
            futureValueAnswer.frame = CGRect(x: 35, y: 540, width: 250, height: 40)
            futureValueAnswer.text = "Rate:"
            futureValueAnswer.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            futureValueAnswer.textColor = UIColor.white
            futureValueAnswer.layer.zPosition = 2
            self.ContentView.addSubview(futureValueAnswer)
            //Add Future Value Label Amount
            rateValue.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            rateValue.text = "\(round(100.0 * finalCalc) / 100.0)%"
            rateValue.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            rateValue.textColor = UIColor.white
            rateValue.layer.zPosition = 2
            self.ContentView.addSubview(rateValue)
        }
    }
    func NumberofPeriodValue(){
        removeEverything()
        // Looking for Number of Periods
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
        self.ContentView.addSubview(rateLbl)
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
        self.ContentView.addSubview(TVMratetxtbox)

        //PV Label
        presentValueLbl.frame = CGRect(x: 35, y: 320, width: 250, height: 40)
        presentValueLbl.text = "Present Value"
        presentValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        presentValueLbl.textColor = UIColor.white
        presentValueLbl.layer.zPosition = 2
        self.ContentView.addSubview(presentValueLbl)
        
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
        self.ContentView.addSubview(TVMPVtxtbox)
        
        //FV Label
        finalValueLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        finalValueLbl.text = "Future Value"
        finalValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        finalValueLbl.textColor = UIColor.white
        finalValueLbl.layer.zPosition = 2
        self.ContentView.addSubview(finalValueLbl)
        
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
        self.ContentView.addSubview(TVMFVtxtbox)
        
        // Calculation Button
        Numcalc.frame = CGRect(x: 35, y: 490, width: 250, height: 40) // hieght extra 10
        Numcalc.setTitle("Calculate", for: .normal)
        Numcalc.backgroundColor = UIColor(named: "SpecialGreen")
        Numcalc.layer.borderColor = UIColor.darkGray.cgColor
        Numcalc.layer.borderWidth = 1
        Numcalc.layer.cornerRadius = 5.0
        Numcalc.layer.zPosition = 2
        Numcalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        Numcalc.addTarget(self, action: #selector(Periodcalculation), for: .touchUpInside)
        self.ContentView.addSubview(Numcalc)
    }
    @objc func Periodcalculation(){
        //Calculating Periods
        //Resign first responder
        lookingFor.resignFirstResponder()
        TVMnumbertxtbox.resignFirstResponder()
        TVMratetxtbox.resignFirstResponder()
        TVMPVtxtbox.resignFirstResponder()
        TVMFVtxtbox.resignFirstResponder()
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
            futureValueAnswer.frame = CGRect(x: 35, y: 540, width: 250, height: 40)
            futureValueAnswer.text = "Number of Periods:"
            futureValueAnswer.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            futureValueAnswer.textColor = UIColor.white
            futureValueAnswer.layer.zPosition = 2
            self.ContentView.addSubview(futureValueAnswer)
            //Add Future Value Label Amount
            numberValue.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            numberValue.text = "\(round(100.0 * abs(finalCalc)) / 100.0)"
            numberValue.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            numberValue.textColor = UIColor.white
            numberValue.layer.zPosition = 2
            self.ContentView.addSubview(numberValue)
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
            PVcalc.removeFromSuperview()
            FVcalc.removeFromSuperview()
            Ratecalc.removeFromSuperview()
            Numcalc.removeFromSuperview()
            TVMnumbertxtbox.removeFromSuperview()
            TVMratetxtbox.removeFromSuperview()
            TVMFVtxtbox.removeFromSuperview()
            TVMPVtxtbox.removeFromSuperview()
            rateLbl.removeFromSuperview()
            numberLbl.removeFromSuperview()
            presentValueLbl.removeFromSuperview()
            finalValueLbl.removeFromSuperview()
            futureValueAnswer.removeFromSuperview()
            presentValueAnswer.removeFromSuperview()
            rateValue.removeFromSuperview()
            numberValue.removeFromSuperview()
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
