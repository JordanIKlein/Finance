//
//  AnnuityDue.swift
//  Finance
//
//  Created by Jordan Klein on 11/30/20.
//

import Foundation
import UIKit

// UI Fields for TVM
let ADlookingFor = UITextField()

// UI Text Fields
let ADnumbertxtbox = UITextField() // Number of periADs
let ADratetxtbox = UITextField() // interest rates
let ADPVtxtbox = UITextField() // Present Value
let ADFVtxtbox = UITextField() // Future Value
let ADpmttxtbox = UITextField() // Payment
//UI Labels
let ADrateLbl = UILabel()
let ADnumberLbl = UILabel()
let ADpresentValueLbl = UILabel()
let ADfutureValueLbl = UILabel()
let ADpmtlbl = UILabel()

// Final Totals
let ADfutureValueAnswer = UILabel()
let ADpresentValueAnswer = UILabel()
let ADrateValue = UILabel()
let ADnumberValue = UILabel()
let ADpaymentValue = UILabel()

//calc buttons
let ADPVcalc = UIButton()
let ADFVcalc = UIButton()
let ADPMTFVcalc = UIButton()
let ADPMTPVcalc = UIButton()
let ADNumFVcalc = UIButton()
let ADNumPVcalc = UIButton()


class AnnuityDue: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var ContentView: UIView!
    
    var ADpickerView = UIPickerView()
    let ADchoices = ["","Future Value","Present Value","Periodic Payment, PV known","Periodic Payment, FV known","Number of Periods, PV known","Number of Periods, FV known"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingBackgroundShapes() // adding black background and top shape
        gestures() //Gestures
        header() // Time Value Money Header
        Labels() // adding labels
        fields() // what are you searching for?
        
        //UI-Fields Delegates
        ADnumbertxtbox.delegate = self
        ADratetxtbox.delegate = self
        ADPVtxtbox.delegate = self
        ADFVtxtbox.delegate = self
        
        //PickerView Delegates
        ADpickerView.delegate = self
        ADpickerView.dataSource = self
        
        ADlookingFor.delegate = self
        ADlookingFor.inputView = ADpickerView
        
    }
    
    
    func header(){
        //Creating Label
        let questionLbl = UILabel()
        questionLbl.frame = CGRect(x: 35, y: 70, width: 250, height: 40)
        questionLbl.text = "Annuity Due"
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
        
        // textbox for number of periADs
        ADlookingFor.frame = CGRect(x: 35, y: 200, width: 305, height: 40)
        ADlookingFor.borderStyle = UITextField.BorderStyle.bezel
        ADlookingFor.backgroundColor = UIColor.white
        ADlookingFor.textColor = UIColor.black
        ADlookingFor.inputAccessoryView = doneToolbar
        ADlookingFor.textAlignment = .center
        ADlookingFor.tintColor = UIColor.clear
        ADlookingFor.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADlookingFor)
    }
    
    
    @objc func firstRes(){
        ADlookingFor.resignFirstResponder()
        ADnumbertxtbox.resignFirstResponder()
        ADratetxtbox.resignFirstResponder()
        ADPVtxtbox.resignFirstResponder()
        ADFVtxtbox.resignFirstResponder()
        ADpmttxtbox.resignFirstResponder()
    }
    
    func removeEverything(){
        ADnumbertxtbox.removeFromSuperview()
        ADratetxtbox.removeFromSuperview()
        ADPVtxtbox.removeFromSuperview()
        ADFVtxtbox.removeFromSuperview()
        ADpmttxtbox.removeFromSuperview()
        
        ADrateLbl.removeFromSuperview()
        ADnumberLbl.removeFromSuperview()
        ADpresentValueLbl.removeFromSuperview()
        ADfutureValueLbl.removeFromSuperview()
        ADpmtlbl.removeFromSuperview()
        ADfutureValueAnswer.removeFromSuperview()
        ADpresentValueAnswer.removeFromSuperview()
        ADrateValue.removeFromSuperview()
        ADnumberValue.removeFromSuperview()
        ADpaymentValue.removeFromSuperview()
        
        ADPVcalc.removeFromSuperview()
        ADFVcalc.removeFromSuperview()
        ADPMTFVcalc.removeFromSuperview()
        ADPMTPVcalc.removeFromSuperview()
        ADNumFVcalc.removeFromSuperview()
        ADNumPVcalc.removeFromSuperview()
        print("Removing Everything...")
        
    }
    func FutureValue(){
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
        
        //Payment Label
        ADpmtlbl.frame = CGRect(x: 35, y: 240, width: 250, height: 40)
        ADpmtlbl.text = "Payment Value"
        ADpmtlbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADpmtlbl.textColor = UIColor.white
        ADpmtlbl.layer.zPosition = 2
        self.ContentView.addSubview(ADpmtlbl)
        //Payment Field
        ADpmttxtbox.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        ADpmttxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADpmttxtbox.backgroundColor = UIColor.white
        ADpmttxtbox.textColor = UIColor.black
        ADpmttxtbox.keyboardType = .decimalPad
        ADpmttxtbox.inputAccessoryView = doneToolbar
        ADpmttxtbox.textAlignment = .center
        ADpmttxtbox.tintColor = UIColor.clear
        ADpmttxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADpmttxtbox)
        
        //Number Label
        ADnumberLbl.frame = CGRect(x: 35, y: 320, width: 300, height: 40)
        ADnumberLbl.text = "Number of Payments"
        ADnumberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADnumberLbl.textColor = UIColor.white
        ADnumberLbl.layer.zPosition = 2
        self.ContentView.addSubview(ADnumberLbl)
        //Number of PeriADs Field
        ADnumbertxtbox.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        ADnumbertxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADnumbertxtbox.backgroundColor = UIColor.white
        ADnumbertxtbox.textColor = UIColor.black
        ADnumbertxtbox.keyboardType = .decimalPad
        ADnumbertxtbox.inputAccessoryView = doneToolbar
        ADnumbertxtbox.textAlignment = .center
        ADnumbertxtbox.tintColor = UIColor.clear
        ADnumbertxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADnumbertxtbox)
        
        //Rate Label
        ADrateLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        ADrateLbl.text = "Rate %"
        ADrateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADrateLbl.textColor = UIColor.white
        ADrateLbl.layer.zPosition = 2
        self.ContentView.addSubview(ADrateLbl)
        //Rate Value Field
        ADratetxtbox.frame = CGRect(x: 35, y: 440, width: 250, height: 40)
        ADratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADratetxtbox.backgroundColor = UIColor.white
        ADratetxtbox.textColor = UIColor.black
        ADratetxtbox.keyboardType = .decimalPad
        ADratetxtbox.inputAccessoryView = doneToolbar
        ADratetxtbox.textAlignment = .center
        ADratetxtbox.tintColor = UIColor.clear
        ADratetxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADratetxtbox)
        // PV Label
        
        // Calculation Button
        ADFVcalc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        ADFVcalc.setTitle("Calculate", for: .normal)
        ADFVcalc.backgroundColor = UIColor(named: "SpecialGreen")
        ADFVcalc.layer.borderColor = UIColor.darkGray.cgColor
        ADFVcalc.layer.borderWidth = 1
        ADFVcalc.layer.cornerRadius = 5.0
        ADFVcalc.layer.zPosition = 2
        ADFVcalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        ADFVcalc.addTarget(self, action: #selector(ADFVcalculation), for:  .touchUpInside)
        self.ContentView.addSubview(ADFVcalc)
    }
    @objc func ADFVcalculation(){
        //Calculating PV
        print("Calculating Ordinary Annuity Present Value...")
        //Resign first responder
        ADlookingFor.resignFirstResponder()
        ADnumbertxtbox.resignFirstResponder()
        ADratetxtbox.resignFirstResponder()
        ADpmttxtbox.resignFirstResponder()
        
        if ADnumbertxtbox.hasText == false || ADratetxtbox.hasText == false || ADpmttxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            // Calculation passes through validation
            let payments = Double(ADpmttxtbox.text!)!
            let rate = Double(ADratetxtbox.text!)! / 100
            let number = Double(ADnumbertxtbox.text!)!
            
            print("Payment Value: \(payments)")
            print("Rate: \(rate)")
            print("Number: \(number)")
            
            // Formula Annuity Due Pmt[(1+i)N−1i](1+i)
            
            
            let firstCalc = pow((1 + rate), number)
            print(firstCalc)
            let secondCalc = (firstCalc - 1)/rate
            print(secondCalc)
            let finalCalc = payments * secondCalc * (1+rate)
            print(finalCalc)
            
            //Add Future Value Label
            ADfutureValueLbl.frame = CGRect(x: 35, y: 530, width: 250, height: 40)
            ADfutureValueLbl.text = "Future Value"
            ADfutureValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ADfutureValueLbl.textColor = UIColor.white
            ADfutureValueLbl.layer.zPosition = 2
            self.ContentView.addSubview(ADfutureValueLbl)
            
            //Add Future Value Label Amount
            ADfutureValueAnswer.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            ADfutureValueAnswer.text = "\(currencyDefault)\(round(100.0 * finalCalc) / 100.0)"
            ADfutureValueAnswer.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ADfutureValueAnswer.textColor = UIColor.white
            ADfutureValueAnswer.layer.zPosition = 2
            self.ContentView.addSubview(ADfutureValueAnswer)
        }
    }
    
    
    func PresentValue(){
        removeEverything()
        // Looking for PV
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.black

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(firstRes))

        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)

        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        //Payment Label
        ADpmtlbl.frame = CGRect(x: 35, y: 240, width: 250, height: 40)
        ADpmtlbl.text = "Payment Value"
        ADpmtlbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADpmtlbl.textColor = UIColor.white
        ADpmtlbl.layer.zPosition = 2
        self.ContentView.addSubview(ADpmtlbl)
        //Payment Field
        ADpmttxtbox.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        ADpmttxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADpmttxtbox.backgroundColor = UIColor.white
        ADpmttxtbox.textColor = UIColor.black
        ADpmttxtbox.keyboardType = .decimalPad
        ADpmttxtbox.inputAccessoryView = doneToolbar
        ADpmttxtbox.textAlignment = .center
        ADpmttxtbox.tintColor = UIColor.clear
        ADpmttxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADpmttxtbox)
        
        //Number Label
        ADnumberLbl.frame = CGRect(x: 35, y: 320, width: 300, height: 40)
        ADnumberLbl.text = "Number of Payments"
        ADnumberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADnumberLbl.textColor = UIColor.white
        ADnumberLbl.layer.zPosition = 2
        self.ContentView.addSubview(ADnumberLbl)
        //Number of PeriADs Field
        ADnumbertxtbox.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        ADnumbertxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADnumbertxtbox.backgroundColor = UIColor.white
        ADnumbertxtbox.textColor = UIColor.black
        ADnumbertxtbox.keyboardType = .decimalPad
        ADnumbertxtbox.inputAccessoryView = doneToolbar
        ADnumbertxtbox.textAlignment = .center
        ADnumbertxtbox.tintColor = UIColor.clear
        ADnumbertxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADnumbertxtbox)
        
        //Rate Label
        ADrateLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        ADrateLbl.text = "Rate %"
        ADrateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADrateLbl.textColor = UIColor.white
        ADrateLbl.layer.zPosition = 2
        self.ContentView.addSubview(ADrateLbl)
        //Rate Value Field
        ADratetxtbox.frame = CGRect(x: 35, y: 440, width: 250, height: 40)
        ADratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADratetxtbox.backgroundColor = UIColor.white
        ADratetxtbox.textColor = UIColor.black
        ADratetxtbox.keyboardType = .decimalPad
        ADratetxtbox.inputAccessoryView = doneToolbar
        ADratetxtbox.textAlignment = .center
        ADratetxtbox.tintColor = UIColor.clear
        ADratetxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADratetxtbox)
        // PV Label
        
        // Calculation Button
        ADPVcalc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        ADPVcalc.setTitle("Calculate", for: .normal)
        ADPVcalc.backgroundColor = UIColor(named: "SpecialGreen")
        ADPVcalc.layer.borderColor = UIColor.darkGray.cgColor
        ADPVcalc.layer.borderWidth = 1
        ADPVcalc.layer.cornerRadius = 5.0
        ADPVcalc.layer.zPosition = 2
        ADPVcalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        ADPVcalc.addTarget(self, action: #selector(ADPVcalculation), for:  .touchUpInside)
        self.ContentView.addSubview(ADPVcalc)
    }
    @objc func ADPVcalculation(){
        //Calculating PV
        
        //Resign first responder
        ADlookingFor.resignFirstResponder()
        ADnumbertxtbox.resignFirstResponder()
        ADratetxtbox.resignFirstResponder()
        ADpmttxtbox.resignFirstResponder()
        
        //if statement to check through each field (ensuring they are not negative)
        if ADnumbertxtbox.hasText == false || ADratetxtbox.hasText == false || ADpmttxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            // Calculation passes through validation
            let payments = Double(ADpmttxtbox.text!)!
            let rate = Double(ADratetxtbox.text!)! / 100
            let number = Double(ADnumbertxtbox.text!)!
            
            print("Present Value: \(payments)")
            print("Rate: \(rate)")
            print("Number: \(number)")
            
            //Formula is PV = PMT (1- (1/(1+i)^n)/i) + pt
            
            let firstCalc = pow((1 + rate), number-1)
            print(firstCalc)
            let secondCalc = (1 - (1/firstCalc))/rate
            print(secondCalc)
            let finalCalc = (payments * secondCalc) + payments
            print(finalCalc)
            
            //Add present Value Label
            ADpresentValueLbl.frame = CGRect(x: 35, y: 530, width: 250, height: 40)
            ADpresentValueLbl.text = "Present Value"
            ADpresentValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ADpresentValueLbl.textColor = UIColor.white
            ADpresentValueLbl.layer.zPosition = 2
            self.ContentView.addSubview(ADpresentValueLbl)
            
            //Add Future Value Label Amount
            ADpresentValueAnswer.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            ADpresentValueAnswer.text = "\(currencyDefault)\(round(100.0 * finalCalc) / 100.0)"
            ADpresentValueAnswer.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ADpresentValueAnswer.textColor = UIColor.white
            ADpresentValueAnswer.layer.zPosition = 2
            self.ContentView.addSubview(ADpresentValueAnswer)
        }
    }
    
    func PeriADicPaymentFV(){
        removeEverything()
        // Know for FV
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.black

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(firstRes))

        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)

        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        //Payment Label
        ADfutureValueLbl.frame = CGRect(x: 35, y: 240, width: 250, height: 40)
        ADfutureValueLbl.text = "Future Value"
        ADfutureValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADfutureValueLbl.textColor = UIColor.white
        ADfutureValueLbl.layer.zPosition = 2
        self.ContentView.addSubview(ADfutureValueLbl)
        //Payment Field
        ADFVtxtbox.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        ADFVtxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADFVtxtbox.backgroundColor = UIColor.white
        ADFVtxtbox.textColor = UIColor.black
        ADFVtxtbox.keyboardType = .decimalPad
        ADFVtxtbox.inputAccessoryView = doneToolbar
        ADFVtxtbox.textAlignment = .center
        ADFVtxtbox.tintColor = UIColor.clear
        ADFVtxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADFVtxtbox)
        
        //Number Label
        ADnumberLbl.frame = CGRect(x: 35, y: 320, width: 300, height: 40)
        ADnumberLbl.text = "Number of Payments"
        ADnumberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADnumberLbl.textColor = UIColor.white
        ADnumberLbl.layer.zPosition = 2
        self.ContentView.addSubview(ADnumberLbl)
        //Number of PeriADs Field
        ADnumbertxtbox.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        ADnumbertxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADnumbertxtbox.backgroundColor = UIColor.white
        ADnumbertxtbox.textColor = UIColor.black
        ADnumbertxtbox.keyboardType = .decimalPad
        ADnumbertxtbox.inputAccessoryView = doneToolbar
        ADnumbertxtbox.textAlignment = .center
        ADnumbertxtbox.tintColor = UIColor.clear
        ADnumbertxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADnumbertxtbox)
        
        //Rate Label
        ADrateLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        ADrateLbl.text = "Rate %"
        ADrateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADrateLbl.textColor = UIColor.white
        ADrateLbl.layer.zPosition = 2
        self.ContentView.addSubview(ADrateLbl)
        //Rate Value Field
        ADratetxtbox.frame = CGRect(x: 35, y: 440, width: 250, height: 40)
        ADratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADratetxtbox.backgroundColor = UIColor.white
        ADratetxtbox.textColor = UIColor.black
        ADratetxtbox.keyboardType = .decimalPad
        ADratetxtbox.inputAccessoryView = doneToolbar
        ADratetxtbox.textAlignment = .center
        ADratetxtbox.tintColor = UIColor.clear
        ADratetxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADratetxtbox)
        // PV Label
        
        // Calculation Button
        ADPMTFVcalc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        ADPMTFVcalc.setTitle("Calculate", for: .normal)
        ADPMTFVcalc.backgroundColor = UIColor(named: "SpecialGreen")
        ADPMTFVcalc.layer.borderColor = UIColor.darkGray.cgColor
        ADPMTFVcalc.layer.borderWidth = 1
        ADPMTFVcalc.layer.cornerRadius = 5.0
        ADPMTFVcalc.layer.zPosition = 2
        ADPMTFVcalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        ADPMTFVcalc.addTarget(self, action: #selector(ADPeriADicFVcalculation), for:  .touchUpInside)
        self.ContentView.addSubview(ADPMTFVcalc)
    }
    @objc func ADPeriADicFVcalculation(){
        //Resign first responder
        ADlookingFor.resignFirstResponder()
        ADnumbertxtbox.resignFirstResponder()
        ADratetxtbox.resignFirstResponder()
        ADFVtxtbox.resignFirstResponder()
        
        //if statement to check through each field (ensuring they are not negative)
        if ADnumbertxtbox.hasText == false || ADratetxtbox.hasText == false || ADFVtxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            // Calculation passes through validation
            let PeriodFV = Double(ADFVtxtbox.text!)!
            let rate = Double(ADratetxtbox.text!)! / 100
            let number = Double(ADnumbertxtbox.text!)!
            
            print("Present Value: \(PeriodFV)")
            print("Rate: \(rate)")
            print("Number: \(number)")
            
            //Formula is PeriADs with FV --> Pmt=FVA/[((1+i)^N−1)/i]
            
            
            let firstCalc = pow((1 + rate), number)
            print(firstCalc)
            let secondCalc = ((firstCalc - 1) / rate) * (1 + rate)
            print(secondCalc)
            let finalCalc = PeriodFV/secondCalc
            print(finalCalc)
            
            //Add Payment Label
            
            
            
            ADpmtlbl.frame = CGRect(x: 35, y: 530, width: 250, height: 40)
            ADpmtlbl.text = "Payments:"
            ADpmtlbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ADpmtlbl.textColor = UIColor.white
            ADpmtlbl.layer.zPosition = 2
            self.ContentView.addSubview(ADpmtlbl)
            
            //Add Future Value Label Amount
            ADpaymentValue.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            ADpaymentValue.text = "\(currencyDefault)\(round(100.0 * finalCalc) / 100.0)"
            ADpaymentValue.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ADpaymentValue.textColor = UIColor.white
            ADpaymentValue.layer.zPosition = 2
            self.ContentView.addSubview(ADpaymentValue)
        }
    }
    
    func PeriADicPaymentPV(){
        removeEverything()
        // Know for FV
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.black

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(firstRes))

        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)

        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        //Payment Label
        ADpresentValueLbl.frame = CGRect(x: 35, y: 240, width: 250, height: 40)
        ADpresentValueLbl.text = "Present Value"
        ADpresentValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADpresentValueLbl.textColor = UIColor.white
        ADpresentValueLbl.layer.zPosition = 2
        self.ContentView.addSubview(ADpresentValueLbl)
        //Payment Field
        ADPVtxtbox.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        ADPVtxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADPVtxtbox.backgroundColor = UIColor.white
        ADPVtxtbox.textColor = UIColor.black
        ADPVtxtbox.keyboardType = .decimalPad
        ADPVtxtbox.inputAccessoryView = doneToolbar
        ADPVtxtbox.textAlignment = .center
        ADPVtxtbox.tintColor = UIColor.clear
        ADPVtxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADPVtxtbox)
        
        //Number Label
        ADnumberLbl.frame = CGRect(x: 35, y: 320, width: 300, height: 40)
        ADnumberLbl.text = "Number of Payments"
        ADnumberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADnumberLbl.textColor = UIColor.white
        ADnumberLbl.layer.zPosition = 2
        self.ContentView.addSubview(ADnumberLbl)
        //Number of PeriADs Field
        ADnumbertxtbox.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        ADnumbertxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADnumbertxtbox.backgroundColor = UIColor.white
        ADnumbertxtbox.textColor = UIColor.black
        ADnumbertxtbox.keyboardType = .decimalPad
        ADnumbertxtbox.inputAccessoryView = doneToolbar
        ADnumbertxtbox.textAlignment = .center
        ADnumbertxtbox.tintColor = UIColor.clear
        ADnumbertxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADnumbertxtbox)
        
        //Rate Label
        ADrateLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        ADrateLbl.text = "Rate %"
        ADrateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADrateLbl.textColor = UIColor.white
        ADrateLbl.layer.zPosition = 2
        self.ContentView.addSubview(ADrateLbl)
        //Rate Value Field
        ADratetxtbox.frame = CGRect(x: 35, y: 440, width: 250, height: 40)
        ADratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADratetxtbox.backgroundColor = UIColor.white
        ADratetxtbox.textColor = UIColor.black
        ADratetxtbox.keyboardType = .decimalPad
        ADratetxtbox.inputAccessoryView = doneToolbar
        ADratetxtbox.textAlignment = .center
        ADratetxtbox.tintColor = UIColor.clear
        ADratetxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADratetxtbox)
        // PV Label
        
        // Calculation Button
        ADPMTPVcalc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        ADPMTPVcalc.setTitle("Calculate", for: .normal)
        ADPMTPVcalc.backgroundColor = UIColor(named: "SpecialGreen")
        ADPMTPVcalc.layer.borderColor = UIColor.darkGray.cgColor
        ADPMTPVcalc.layer.borderWidth = 1
        ADPMTPVcalc.layer.cornerRadius = 5.0
        ADPMTPVcalc.layer.zPosition = 2
        ADPMTPVcalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        ADPMTPVcalc.addTarget(self, action: #selector(ADPeriADicPVcalculation), for:  .touchUpInside)
        self.ContentView.addSubview(ADPMTPVcalc)
    }
    @objc func ADPeriADicPVcalculation(){
        //Resign first responder
        ADlookingFor.resignFirstResponder()
        ADnumbertxtbox.resignFirstResponder()
        ADratetxtbox.resignFirstResponder()
        ADPVtxtbox.resignFirstResponder()
        
        //if statement to check through each field (ensuring they are not negative)
        if ADnumbertxtbox.hasText == false || ADratetxtbox.hasText == false || ADPVtxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            // Calculation passes through validation
            let PeriADFV = Double(ADPVtxtbox.text!)!
            let rate = Double(ADratetxtbox.text!)! / 100
            let number = Double(ADnumbertxtbox.text!)!
            
            print("Present Value: \(PeriADFV)")
            print("Rate: \(rate)")
            print("Number: \(number)")
            
            //Formula is PeriADs with PV --> Pmt= PV / [(1 − (1/(1+i)^N))/i]
            
            
            let firstCalc = 1 / (pow((1 + rate), number-1))
            print(firstCalc)
            let secondCalc = ((1 - firstCalc) / rate) + 1
            print(secondCalc)
            let finalCalc = PeriADFV/secondCalc
            print(finalCalc)
            
            //Add Payment Label
            ADpmtlbl.frame = CGRect(x: 35, y: 530, width: 250, height: 40)
            ADpmtlbl.text = "Payments:"
            ADpmtlbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ADpmtlbl.textColor = UIColor.white
            ADpmtlbl.layer.zPosition = 2
            self.ContentView.addSubview(ADpmtlbl)
            
            //Add Future Value Label Amount
            ADpaymentValue.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            ADpaymentValue.text = "\(currencyDefault)\(round(100.0 * finalCalc) / 100.0)"
            ADpaymentValue.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ADpaymentValue.textColor = UIColor.white
            ADpaymentValue.layer.zPosition = 2
            self.ContentView.addSubview(ADpaymentValue)
        }
    }
    func NumberwithPV(){
        removeEverything()
        // Know for FV
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.black

        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(firstRes))

        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)

        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        //Payment Label
        ADpmtlbl.frame = CGRect(x: 35, y: 240, width: 250, height: 40)
        ADpmtlbl.text = "Payments"
        ADpmtlbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADpmtlbl.textColor = UIColor.white
        ADpmtlbl.layer.zPosition = 2
        self.ContentView.addSubview(ADpmtlbl)
        //Payment Field
        ADpmttxtbox.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        ADpmttxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADpmttxtbox.backgroundColor = UIColor.white
        ADpmttxtbox.textColor = UIColor.black
        ADpmttxtbox.keyboardType = .decimalPad
        ADpmttxtbox.inputAccessoryView = doneToolbar
        ADpmttxtbox.textAlignment = .center
        ADpmttxtbox.tintColor = UIColor.clear
        ADpmttxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADpmttxtbox)
        
        //Present Value
        ADpresentValueLbl.frame = CGRect(x: 35, y: 320, width: 250, height: 40)
        ADpresentValueLbl.text = "Present Value"
        ADpresentValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADpresentValueLbl.textColor = UIColor.white
        ADpresentValueLbl.layer.zPosition = 2
        self.ContentView.addSubview(ADpresentValueLbl)
        //Present Value Field
        ADPVtxtbox.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        ADPVtxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADPVtxtbox.backgroundColor = UIColor.white
        ADPVtxtbox.textColor = UIColor.black
        ADPVtxtbox.keyboardType = .decimalPad
        ADPVtxtbox.inputAccessoryView = doneToolbar
        ADPVtxtbox.textAlignment = .center
        ADPVtxtbox.tintColor = UIColor.clear
        ADPVtxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADPVtxtbox)
        
        //Rate Label
        ADrateLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        ADrateLbl.text = "Rate %"
        ADrateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADrateLbl.textColor = UIColor.white
        ADrateLbl.layer.zPosition = 2
        self.ContentView.addSubview(ADrateLbl)
        //Rate Value Field
        ADratetxtbox.frame = CGRect(x: 35, y: 440, width: 250, height: 40)
        ADratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADratetxtbox.backgroundColor = UIColor.white
        ADratetxtbox.textColor = UIColor.black
        ADratetxtbox.keyboardType = .decimalPad
        ADratetxtbox.inputAccessoryView = doneToolbar
        ADratetxtbox.textAlignment = .center
        ADratetxtbox.tintColor = UIColor.clear
        ADratetxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADratetxtbox)
        // PV Label
        
        // Calculation Button
        ADNumPVcalc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        ADNumPVcalc.setTitle("Calculate", for: .normal)
        ADNumPVcalc.backgroundColor = UIColor(named: "SpecialGreen")
        ADNumPVcalc.layer.borderColor = UIColor.darkGray.cgColor
        ADNumPVcalc.layer.borderWidth = 1
        ADNumPVcalc.layer.cornerRadius = 5.0
        ADNumPVcalc.layer.zPosition = 2
        ADNumPVcalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        ADNumPVcalc.addTarget(self, action: #selector(ADNumPVcalculation), for:  .touchUpInside)
        self.ContentView.addSubview(ADNumPVcalc)
    }
    @objc func ADNumPVcalculation(){
        //Resign first responder
        ADlookingFor.resignFirstResponder()
        ADpmttxtbox.resignFirstResponder()
        ADratetxtbox.resignFirstResponder()
        ADPVtxtbox.resignFirstResponder()
        
        //if statement to check through each field (ensuring they are not negative)
        if ADpmttxtbox.hasText == false || ADratetxtbox.hasText == false || ADPVtxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            // Calculation passes through validation
            let PV = Double(ADPVtxtbox.text!)!
            let rate = Double(ADratetxtbox.text!)! / 100
            let payment = Double(ADpmttxtbox.text!)!
            
            
            //Formula is PeriADs with PV --> N= −ln(1−PVA/Pmti)ln(1+i)
            // 1 / (1 - (PV(r)/Pmt))      /  ln (1+r)
            
            let firstCalc = log(1+rate)
            print(firstCalc)
            let secondCalc = log(pow(1+rate*(1 - ((PV*rate)/payment)),-1))
            print(secondCalc)
            let finalCalc = (secondCalc/firstCalc) + 1
            print(finalCalc)
            
            //Add Payment Label
            ADnumberLbl.frame = CGRect(x: 35, y: 530, width: 300, height: 40)
            ADnumberLbl.text = "Number of Periods:"
            ADnumberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ADnumberLbl.textColor = UIColor.white
            ADnumberLbl.layer.zPosition = 2
            self.ContentView.addSubview(ADnumberLbl)
            
            //Add Future Value Label Amount
            ADnumberValue.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            ADnumberValue.text = "\(round(100.0 * finalCalc) / 100.0)"
            ADnumberValue.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ADnumberValue.textColor = UIColor.white
            ADnumberValue.layer.zPosition = 2
            self.ContentView.addSubview(ADnumberValue)
        }
    }
    func NumberwithFV(){
        removeEverything()
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.black
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(firstRes))
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        //Payment Label
        ADpmtlbl.frame = CGRect(x: 35, y: 240, width: 250, height: 40)
        ADpmtlbl.text = "Payments"
        ADpmtlbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADpmtlbl.textColor = UIColor.white
        ADpmtlbl.layer.zPosition = 2
        self.ContentView.addSubview(ADpmtlbl)
        //Payment Field
        ADpmttxtbox.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        ADpmttxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADpmttxtbox.backgroundColor = UIColor.white
        ADpmttxtbox.textColor = UIColor.black
        ADpmttxtbox.keyboardType = .decimalPad
        ADpmttxtbox.inputAccessoryView = doneToolbar
        ADpmttxtbox.textAlignment = .center
        ADpmttxtbox.tintColor = UIColor.clear
        ADpmttxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADpmttxtbox)
        
        //Future Value
        ADfutureValueLbl.frame = CGRect(x: 35, y: 320, width: 250, height: 40)
        ADfutureValueLbl.text = "Future Value"
        ADfutureValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADfutureValueLbl.textColor = UIColor.white
        ADfutureValueLbl.layer.zPosition = 2
        self.ContentView.addSubview(ADfutureValueLbl)
        //Present Value Field
        ADFVtxtbox.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        ADFVtxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADFVtxtbox.backgroundColor = UIColor.white
        ADFVtxtbox.textColor = UIColor.black
        ADFVtxtbox.keyboardType = .decimalPad
        ADFVtxtbox.inputAccessoryView = doneToolbar
        ADFVtxtbox.textAlignment = .center
        ADFVtxtbox.tintColor = UIColor.clear
        ADFVtxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADFVtxtbox)
        
        //Rate Label
        ADrateLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        ADrateLbl.text = "Rate %"
        ADrateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ADrateLbl.textColor = UIColor.white
        ADrateLbl.layer.zPosition = 2
        self.ContentView.addSubview(ADrateLbl)
        //Rate Value Field
        ADratetxtbox.frame = CGRect(x: 35, y: 440, width: 250, height: 40)
        ADratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        ADratetxtbox.backgroundColor = UIColor.white
        ADratetxtbox.textColor = UIColor.black
        ADratetxtbox.keyboardType = .decimalPad
        ADratetxtbox.inputAccessoryView = doneToolbar
        ADratetxtbox.textAlignment = .center
        ADratetxtbox.tintColor = UIColor.clear
        ADratetxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ADratetxtbox)
        // PV Label
        
        // Calculation Button
        ADNumFVcalc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        ADNumFVcalc.setTitle("Calculate", for: .normal)
        ADNumFVcalc.backgroundColor = UIColor(named: "SpecialGreen")
        ADNumFVcalc.layer.borderColor = UIColor.darkGray.cgColor
        ADNumFVcalc.layer.borderWidth = 1
        ADNumFVcalc.layer.cornerRadius = 5.0
        ADNumFVcalc.layer.zPosition = 2
        ADNumFVcalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        ADNumFVcalc.addTarget(self, action: #selector(ADNumFVcalculation), for:  .touchUpInside)
        self.ContentView.addSubview(ADNumFVcalc)
    }
    @objc func ADNumFVcalculation(){
        //Resign first responder
        ADlookingFor.resignFirstResponder()
        ADpmttxtbox.resignFirstResponder()
        ADratetxtbox.resignFirstResponder()
        ADFVtxtbox.resignFirstResponder()
        
        //if statement to check through each field (ensuring they are not negative)
        if ADpmttxtbox.hasText == false || ADratetxtbox.hasText == false || ADFVtxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            // Calculation passes through validation
            let FV = Double(ADFVtxtbox.text!)!
            let rate = Double(ADratetxtbox.text!)! / 100
            let payment = Double(ADpmttxtbox.text!)!
            
            
            //Formula is Number PV
            // log(1 + (FV(r)/PMT)) / log(1+r)
            
            
            let firstCalc = log(1+rate)
            print(firstCalc)
            let secondCalc = log(1 + (FV*rate/payment*(1+rate)))
            print(secondCalc)
            let finalCalc = secondCalc/firstCalc
            print(finalCalc)
            
            //Add Payment Label
            ADnumberLbl.frame = CGRect(x: 35, y: 530, width: 300, height: 40)
            ADnumberLbl.text = "Number of Periods:"
            ADnumberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ADnumberLbl.textColor = UIColor.white
            ADnumberLbl.layer.zPosition = 2
            self.ContentView.addSubview(ADnumberLbl)
            
            //Add Future Value Label Amount
            ADnumberValue.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            ADnumberValue.text = "\(round(100.0 * finalCalc) / 100.0)"
            ADnumberValue.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ADnumberValue.textColor = UIColor.white
            ADnumberValue.layer.zPosition = 2
            self.ContentView.addSubview(ADnumberValue)
        }
    }
}

extension AnnuityDue: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        ADchoices.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ADchoices[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ADlookingFor.text = ADchoices[row]
        let selectedValue = ADchoices[pickerView.selectedRow(inComponent: 0)]
        if selectedValue == "Future Value" {
            print("Future Value Selected")
            // Future Value Stuff
            FutureValue()
        } else if selectedValue == "Present Value" {
            print("Present Value Selected")
            // Presnt Value Stuff
            PresentValue()
        } else if selectedValue == "Periodic Payment, FV known" {
            print("Periodic Payment, FV known")
            // # of periAD stuff FV KNOWN
            PeriADicPaymentFV()
        } else if selectedValue == "Periodic Payment, PV known" {
            print("Periodic Payment, PV known")
            // # of periAD stuff PV KNOWN
            PeriADicPaymentPV()
        } else if selectedValue == "Number of Periods, FV known" {
            print("Number of Periods, FV known")
            NumberwithFV()
        } else if selectedValue == "Number of Periods, PV known" {
            print("Number of Periods, PV known")
            NumberwithPV()
        } else {
            print("Remove Everything")
            removeEverything()
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
} // of Annuity Class
