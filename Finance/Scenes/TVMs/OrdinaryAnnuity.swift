//
//  Ordinary Annuity.swift
//  Finance
//
//  Created by Jordan Klein on 11/30/20.
//

import Foundation
import UIKit
// UI Fields for TVM
let ODlookingFor = UITextField()

// UI Text Fields
let ODnumbertxtbox = UITextField() // Number of periods
let ODratetxtbox = UITextField() // interest rates
let ODPVtxtbox = UITextField() // Present Value
let ODFVtxtbox = UITextField() // Future Value
let ODpmttxtbox = UITextField() // Payment
//UI Labels
let ODrateLbl = UILabel()
let ODnumberLbl = UILabel()
let ODpresentValueLbl = UILabel()
let ODfutureValueLbl = UILabel()
let ODpmtlbl = UILabel()

// Final Totals
let ODfutureValueAnswer = UILabel()
let ODpresentValueAnswer = UILabel()
let ODrateValue = UILabel()
let ODnumberValue = UILabel()
let ODpaymentValue = UILabel()

//calc buttons
let ODPVcalc = UIButton()
let ODFVcalc = UIButton()
let ODPMTFVcalc = UIButton()
let ODPMTPVcalc = UIButton()
let ODNumFVcalc = UIButton()
let ODNumPVcalc = UIButton()


class OrdinaryAnnuity: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var ContentView: UIView!
    
    var ODpickerView = UIPickerView()
    let ODchoices = ["","Future Value","Present Value","Periodic Payment, PV known","Periodic Payment, FV known","Number of Periods, PV known","Number of Periods, FV known"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingBackgroundShapes() // adding black background and top shape
        gestures() //Gestures
        header() // Time Value Money Header
        Labels() // adding labels
        fields() // what are you searching for?
        
        
        //UI-Fields Delegates
        ODnumbertxtbox.delegate = self
        ODratetxtbox.delegate = self
        ODPVtxtbox.delegate = self
        ODFVtxtbox.delegate = self
        
        //PickerView Delegates
        ODpickerView.delegate = self
        ODpickerView.dataSource = self
        
        ODlookingFor.delegate = self
        ODlookingFor.inputView = ODpickerView
        
    }
    
    
    func header(){
        //Creating Label
        let questionLbl = UILabel()
        questionLbl.frame = CGRect(x: 35, y: 70, width: 250, height: 40)
        questionLbl.text = "Ordinary Annuity"
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
        ODlookingFor.frame = CGRect(x: 35, y: 200, width: 325, height: 40)
        ODlookingFor.borderStyle = UITextField.BorderStyle.bezel
        ODlookingFor.backgroundColor = UIColor.white
        ODlookingFor.textColor = UIColor.black
        ODlookingFor.inputAccessoryView = doneToolbar
        ODlookingFor.textAlignment = .center
        ODlookingFor.tintColor = UIColor.clear
        ODlookingFor.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODlookingFor)
    }
    
    
    @objc func firstRes(){
        ODlookingFor.resignFirstResponder()
        ODnumbertxtbox.resignFirstResponder()
        ODratetxtbox.resignFirstResponder()
        ODPVtxtbox.resignFirstResponder()
        ODFVtxtbox.resignFirstResponder()
        ODpmttxtbox.resignFirstResponder()
    }
    
    func removeEverything(){
        ODnumbertxtbox.removeFromSuperview()
        ODratetxtbox.removeFromSuperview()
        ODPVtxtbox.removeFromSuperview()
        ODFVtxtbox.removeFromSuperview()
        ODpmttxtbox.removeFromSuperview()
        
        ODrateLbl.removeFromSuperview()
        ODnumberLbl.removeFromSuperview()
        ODpresentValueLbl.removeFromSuperview()
        ODfutureValueLbl.removeFromSuperview()
        ODpmtlbl.removeFromSuperview()
        
        ODfutureValueAnswer.removeFromSuperview()
        ODpresentValueAnswer.removeFromSuperview()
        ODrateValue.removeFromSuperview()
        ODnumberValue.removeFromSuperview()
        ODpaymentValue.removeFromSuperview()
        
        ODPVcalc.removeFromSuperview()
        ODFVcalc.removeFromSuperview()
        ODPMTFVcalc.removeFromSuperview()
        ODPMTPVcalc.removeFromSuperview()
        ODNumFVcalc.removeFromSuperview()
        ODNumPVcalc.removeFromSuperview()
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
        ODpmtlbl.frame = CGRect(x: 35, y: 240, width: 250, height: 40)
        ODpmtlbl.text = "Payment Value"
        ODpmtlbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODpmtlbl.textColor = UIColor.white
        ODpmtlbl.layer.zPosition = 2
        self.ContentView.addSubview(ODpmtlbl)
        //Payment Field
        ODpmttxtbox.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        ODpmttxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODpmttxtbox.backgroundColor = UIColor.white
        ODpmttxtbox.textColor = UIColor.black
        ODpmttxtbox.keyboardType = .decimalPad
        ODpmttxtbox.inputAccessoryView = doneToolbar
        ODpmttxtbox.textAlignment = .center
        ODpmttxtbox.tintColor = UIColor.clear
        ODpmttxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODpmttxtbox)
        
        //Number Label
        ODnumberLbl.frame = CGRect(x: 35, y: 320, width: 300, height: 40)
        ODnumberLbl.text = "Number of Payments"
        ODnumberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODnumberLbl.textColor = UIColor.white
        ODnumberLbl.layer.zPosition = 2
        self.ContentView.addSubview(ODnumberLbl)
        //Number of Periods Field
        ODnumbertxtbox.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        ODnumbertxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODnumbertxtbox.backgroundColor = UIColor.white
        ODnumbertxtbox.textColor = UIColor.black
        ODnumbertxtbox.keyboardType = .decimalPad
        ODnumbertxtbox.inputAccessoryView = doneToolbar
        ODnumbertxtbox.textAlignment = .center
        ODnumbertxtbox.tintColor = UIColor.clear
        ODnumbertxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODnumbertxtbox)
        
        //Rate Label
        ODrateLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        ODrateLbl.text = "Rate %"
        ODrateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODrateLbl.textColor = UIColor.white
        ODrateLbl.layer.zPosition = 2
        self.ContentView.addSubview(ODrateLbl)
        //Rate Value Field
        ODratetxtbox.frame = CGRect(x: 35, y: 440, width: 250, height: 40)
        ODratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODratetxtbox.backgroundColor = UIColor.white
        ODratetxtbox.textColor = UIColor.black
        ODratetxtbox.keyboardType = .decimalPad
        ODratetxtbox.inputAccessoryView = doneToolbar
        ODratetxtbox.textAlignment = .center
        ODratetxtbox.tintColor = UIColor.clear
        ODratetxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODratetxtbox)
        // PV Label
        
        // Calculation Button
        ODFVcalc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        ODFVcalc.setTitle("Calculate", for: .normal)
        ODFVcalc.backgroundColor = UIColor(named: "SpecialGreen")
        ODFVcalc.layer.borderColor = UIColor.darkGray.cgColor
        ODFVcalc.layer.borderWidth = 1
        ODFVcalc.layer.cornerRadius = 5.0
        ODFVcalc.layer.zPosition = 2
        ODFVcalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        ODFVcalc.addTarget(self, action: #selector(ODFVcalculation), for:  .touchUpInside)
        self.ContentView.addSubview(ODFVcalc)
    }
    @objc func ODFVcalculation(){
        //Calculating PV
        print("Calculating Ordinary Annuity Present Value...")
        //Resign first responder
        ODlookingFor.resignFirstResponder()
        ODnumbertxtbox.resignFirstResponder()
        ODratetxtbox.resignFirstResponder()
        ODpmttxtbox.resignFirstResponder()
        
        if ODnumbertxtbox.hasText == false || ODratetxtbox.hasText == false || ODpmttxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            // Calculation passes through validation
            let payments = Double(ODpmttxtbox.text!)!
            let rate = Double(ODratetxtbox.text!)! / 100
            let number = Double(ODnumbertxtbox.text!)!
            
            print("Payment Value: \(payments)")
            print("Rate: \(rate)")
            print("Number: \(number)")
            
            // Lump sum formula is FV = PMT * (((1+r)^n) - 1/ r)
            let firstCalc = pow((1 + rate), number)
            print(firstCalc)
            let secondCalc = (firstCalc - 1)/rate
            print(secondCalc)
            let finalCalc = payments * secondCalc
            print(finalCalc)
            
            //Add Future Value Label
            ODfutureValueLbl.frame = CGRect(x: 35, y: 530, width: 250, height: 40)
            ODfutureValueLbl.text = "Future Value"
            ODfutureValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ODfutureValueLbl.textColor = UIColor.white
            ODfutureValueLbl.layer.zPosition = 2
            self.ContentView.addSubview(ODfutureValueLbl)
            
            //Add Future Value Label Amount
            ODfutureValueAnswer.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            ODfutureValueAnswer.text = "\(currencyDefault)\(round(100.0 * finalCalc) / 100.0)"
            ODfutureValueAnswer.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ODfutureValueAnswer.textColor = UIColor.white
            ODfutureValueAnswer.layer.zPosition = 2
            self.ContentView.addSubview(ODfutureValueAnswer)
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
        ODpmtlbl.frame = CGRect(x: 35, y: 240, width: 250, height: 40)
        ODpmtlbl.text = "Payment Value"
        ODpmtlbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODpmtlbl.textColor = UIColor.white
        ODpmtlbl.layer.zPosition = 2
        self.ContentView.addSubview(ODpmtlbl)
        //Payment Field
        ODpmttxtbox.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        ODpmttxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODpmttxtbox.backgroundColor = UIColor.white
        ODpmttxtbox.textColor = UIColor.black
        ODpmttxtbox.keyboardType = .decimalPad
        ODpmttxtbox.inputAccessoryView = doneToolbar
        ODpmttxtbox.textAlignment = .center
        ODpmttxtbox.tintColor = UIColor.clear
        ODpmttxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODpmttxtbox)
        
        //Number Label
        ODnumberLbl.frame = CGRect(x: 35, y: 320, width: 300, height: 40)
        ODnumberLbl.text = "Number of Payments"
        ODnumberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODnumberLbl.textColor = UIColor.white
        ODnumberLbl.layer.zPosition = 2
        self.ContentView.addSubview(ODnumberLbl)
        //Number of Periods Field
        ODnumbertxtbox.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        ODnumbertxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODnumbertxtbox.backgroundColor = UIColor.white
        ODnumbertxtbox.textColor = UIColor.black
        ODnumbertxtbox.keyboardType = .decimalPad
        ODnumbertxtbox.inputAccessoryView = doneToolbar
        ODnumbertxtbox.textAlignment = .center
        ODnumbertxtbox.tintColor = UIColor.clear
        ODnumbertxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODnumbertxtbox)
        
        //Rate Label
        ODrateLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        ODrateLbl.text = "Rate %"
        ODrateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODrateLbl.textColor = UIColor.white
        ODrateLbl.layer.zPosition = 2
        self.ContentView.addSubview(ODrateLbl)
        //Rate Value Field
        ODratetxtbox.frame = CGRect(x: 35, y: 440, width: 250, height: 40)
        ODratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODratetxtbox.backgroundColor = UIColor.white
        ODratetxtbox.textColor = UIColor.black
        ODratetxtbox.keyboardType = .decimalPad
        ODratetxtbox.inputAccessoryView = doneToolbar
        ODratetxtbox.textAlignment = .center
        ODratetxtbox.tintColor = UIColor.clear
        ODratetxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODratetxtbox)
        // PV Label
        
        // Calculation Button
        ODPVcalc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        ODPVcalc.setTitle("Calculate", for: .normal)
        ODPVcalc.backgroundColor = UIColor(named: "SpecialGreen")
        ODPVcalc.layer.borderColor = UIColor.darkGray.cgColor
        ODPVcalc.layer.borderWidth = 1
        ODPVcalc.layer.cornerRadius = 5.0
        ODPVcalc.layer.zPosition = 2
        ODPVcalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        ODPVcalc.addTarget(self, action: #selector(ODPVcalculation), for:  .touchUpInside)
        self.ContentView.addSubview(ODPVcalc)
    }
    @objc func ODPVcalculation(){
        //Calculating PV
        
        //Resign first responder
        ODlookingFor.resignFirstResponder()
        ODnumbertxtbox.resignFirstResponder()
        ODratetxtbox.resignFirstResponder()
        ODpmttxtbox.resignFirstResponder()
        
        //if statement to check through each field (ensuring they are not negative)
        if ODnumbertxtbox.hasText == false || ODratetxtbox.hasText == false || ODpmttxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            // Calculation passes through validation
            let payments = Double(ODpmttxtbox.text!)!
            let rate = Double(ODratetxtbox.text!)! / 100
            let number = Double(ODnumbertxtbox.text!)!
            
            print("Present Value: \(payments)")
            print("Rate: \(rate)")
            print("Number: \(number)")
            
            //Formula is PV = PMT (1- (1/(1+i)^n)/i)
            
            let firstCalc = pow((1 + rate), number)
            print(firstCalc)
            let secondCalc = (1 - (1/firstCalc))/rate
            print(secondCalc)
            let finalCalc = payments * secondCalc
            print(finalCalc)
            
            //Add present Value Label
            ODpresentValueLbl.frame = CGRect(x: 35, y: 530, width: 250, height: 40)
            ODpresentValueLbl.text = "Present Value"
            ODpresentValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ODpresentValueLbl.textColor = UIColor.white
            ODpresentValueLbl.layer.zPosition = 2
            self.ContentView.addSubview(ODpresentValueLbl)
            
            //Add Future Value Label Amount
            ODpresentValueAnswer.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            ODpresentValueAnswer.text = "\(currencyDefault)\(round(100.0 * finalCalc) / 100.0)"
            ODpresentValueAnswer.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ODpresentValueAnswer.textColor = UIColor.white
            ODpresentValueAnswer.layer.zPosition = 2
            self.ContentView.addSubview(ODpresentValueAnswer)
        }
    }
    
    func PeriodicPaymentFV(){
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
        ODfutureValueLbl.frame = CGRect(x: 35, y: 240, width: 250, height: 40)
        ODfutureValueLbl.text = "Future Value"
        ODfutureValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODfutureValueLbl.textColor = UIColor.white
        ODfutureValueLbl.layer.zPosition = 2
        self.ContentView.addSubview(ODfutureValueLbl)
        //Payment Field
        ODFVtxtbox.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        ODFVtxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODFVtxtbox.backgroundColor = UIColor.white
        ODFVtxtbox.textColor = UIColor.black
        ODFVtxtbox.keyboardType = .decimalPad
        ODFVtxtbox.inputAccessoryView = doneToolbar
        ODFVtxtbox.textAlignment = .center
        ODFVtxtbox.tintColor = UIColor.clear
        ODFVtxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODFVtxtbox)
        
        //Number Label
        ODnumberLbl.frame = CGRect(x: 35, y: 320, width: 300, height: 40)
        ODnumberLbl.text = "Number of Payments"
        ODnumberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODnumberLbl.textColor = UIColor.white
        ODnumberLbl.layer.zPosition = 2
        self.ContentView.addSubview(ODnumberLbl)
        //Number of Periods Field
        ODnumbertxtbox.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        ODnumbertxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODnumbertxtbox.backgroundColor = UIColor.white
        ODnumbertxtbox.textColor = UIColor.black
        ODnumbertxtbox.keyboardType = .decimalPad
        ODnumbertxtbox.inputAccessoryView = doneToolbar
        ODnumbertxtbox.textAlignment = .center
        ODnumbertxtbox.tintColor = UIColor.clear
        ODnumbertxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODnumbertxtbox)
        
        //Rate Label
        ODrateLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        ODrateLbl.text = "Rate %"
        ODrateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODrateLbl.textColor = UIColor.white
        ODrateLbl.layer.zPosition = 2
        self.ContentView.addSubview(ODrateLbl)
        //Rate Value Field
        ODratetxtbox.frame = CGRect(x: 35, y: 440, width: 250, height: 40)
        ODratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODratetxtbox.backgroundColor = UIColor.white
        ODratetxtbox.textColor = UIColor.black
        ODratetxtbox.keyboardType = .decimalPad
        ODratetxtbox.inputAccessoryView = doneToolbar
        ODratetxtbox.textAlignment = .center
        ODratetxtbox.tintColor = UIColor.clear
        ODratetxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODratetxtbox)
        // PV Label
        
        // Calculation Button
        ODPMTFVcalc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        ODPMTFVcalc.setTitle("Calculate", for: .normal)
        ODPMTFVcalc.backgroundColor = UIColor(named: "SpecialGreen")
        ODPMTFVcalc.layer.borderColor = UIColor.darkGray.cgColor
        ODPMTFVcalc.layer.borderWidth = 1
        ODPMTFVcalc.layer.cornerRadius = 5.0
        ODPMTFVcalc.layer.zPosition = 2
        ODPMTFVcalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        ODPMTFVcalc.addTarget(self, action: #selector(ODPeriodicFVcalculation), for:  .touchUpInside)
        self.ContentView.addSubview(ODPMTFVcalc)
    }
    @objc func ODPeriodicFVcalculation(){
        //Resign first responder
        ODlookingFor.resignFirstResponder()
        ODnumbertxtbox.resignFirstResponder()
        ODratetxtbox.resignFirstResponder()
        ODFVtxtbox.resignFirstResponder()
        
        //if statement to check through each field (ensuring they are not negative)
        if ODnumbertxtbox.hasText == false || ODratetxtbox.hasText == false || ODFVtxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            // Calculation passes through validation
            let PeriodFV = Double(ODFVtxtbox.text!)!
            let rate = Double(ODratetxtbox.text!)! / 100
            let number = Double(ODnumbertxtbox.text!)!
            
            print("Present Value: \(PeriodFV)")
            print("Rate: \(rate)")
            print("Number: \(number)")
            
            //Formula is Periods with FV --> Pmt=FVA/[((1+i)^N−1)/i]
            
            
            let firstCalc = pow((1 + rate), number)
            print(firstCalc)
            let secondCalc = (firstCalc - 1) / rate
            print(secondCalc)
            let finalCalc = PeriodFV/secondCalc
            print(finalCalc)
            
            //Add Payment Label
            
            
            
            ODpmtlbl.frame = CGRect(x: 35, y: 530, width: 250, height: 40)
            ODpmtlbl.text = "Payments:"
            ODpmtlbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ODpmtlbl.textColor = UIColor.white
            ODpmtlbl.layer.zPosition = 2
            self.ContentView.addSubview(ODpmtlbl)
            
            //Add Future Value Label Amount
            ODpaymentValue.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            ODpaymentValue.text = "\(currencyDefault)\(round(100.0 * finalCalc) / 100.0)"
            ODpaymentValue.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ODpaymentValue.textColor = UIColor.white
            ODpaymentValue.layer.zPosition = 2
            self.ContentView.addSubview(ODpaymentValue)
        }
    }
    
    func PeriodicPaymentPV(){
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
        ODpresentValueLbl.frame = CGRect(x: 35, y: 240, width: 250, height: 40)
        ODpresentValueLbl.text = "Present Value"
        ODpresentValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODpresentValueLbl.textColor = UIColor.white
        ODpresentValueLbl.layer.zPosition = 2
        self.ContentView.addSubview(ODpresentValueLbl)
        //Payment Field
        ODPVtxtbox.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        ODPVtxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODPVtxtbox.backgroundColor = UIColor.white
        ODPVtxtbox.textColor = UIColor.black
        ODPVtxtbox.keyboardType = .decimalPad
        ODPVtxtbox.inputAccessoryView = doneToolbar
        ODPVtxtbox.textAlignment = .center
        ODPVtxtbox.tintColor = UIColor.clear
        ODPVtxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODPVtxtbox)
        
        //Number Label
        ODnumberLbl.frame = CGRect(x: 35, y: 320, width: 300, height: 40)
        ODnumberLbl.text = "Number of Payments"
        ODnumberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODnumberLbl.textColor = UIColor.white
        ODnumberLbl.layer.zPosition = 2
        self.ContentView.addSubview(ODnumberLbl)
        //Number of Periods Field
        ODnumbertxtbox.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        ODnumbertxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODnumbertxtbox.backgroundColor = UIColor.white
        ODnumbertxtbox.textColor = UIColor.black
        ODnumbertxtbox.keyboardType = .decimalPad
        ODnumbertxtbox.inputAccessoryView = doneToolbar
        ODnumbertxtbox.textAlignment = .center
        ODnumbertxtbox.tintColor = UIColor.clear
        ODnumbertxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODnumbertxtbox)
        
        //Rate Label
        ODrateLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        ODrateLbl.text = "Rate %"
        ODrateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODrateLbl.textColor = UIColor.white
        ODrateLbl.layer.zPosition = 2
        self.ContentView.addSubview(ODrateLbl)
        //Rate Value Field
        ODratetxtbox.frame = CGRect(x: 35, y: 440, width: 250, height: 40)
        ODratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODratetxtbox.backgroundColor = UIColor.white
        ODratetxtbox.textColor = UIColor.black
        ODratetxtbox.keyboardType = .decimalPad
        ODratetxtbox.inputAccessoryView = doneToolbar
        ODratetxtbox.textAlignment = .center
        ODratetxtbox.tintColor = UIColor.clear
        ODratetxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODratetxtbox)
        // PV Label
        
        // Calculation Button
        ODPMTPVcalc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        ODPMTPVcalc.setTitle("Calculate", for: .normal)
        ODPMTPVcalc.backgroundColor = UIColor(named: "SpecialGreen")
        ODPMTPVcalc.layer.borderColor = UIColor.darkGray.cgColor
        ODPMTPVcalc.layer.borderWidth = 1
        ODPMTPVcalc.layer.cornerRadius = 5.0
        ODPMTPVcalc.layer.zPosition = 2
        ODPMTPVcalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        ODPMTPVcalc.addTarget(self, action: #selector(ODPeriodicPVcalculation), for:  .touchUpInside)
        self.ContentView.addSubview(ODPMTPVcalc)
    }
    @objc func ODPeriodicPVcalculation(){
        //Resign first responder
        ODlookingFor.resignFirstResponder()
        ODnumbertxtbox.resignFirstResponder()
        ODratetxtbox.resignFirstResponder()
        ODPVtxtbox.resignFirstResponder()
        
        //if statement to check through each field (ensuring they are not negative)
        if ODnumbertxtbox.hasText == false || ODratetxtbox.hasText == false || ODPVtxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            // Calculation passes through validation
            let PeriodFV = Double(ODPVtxtbox.text!)!
            let rate = Double(ODratetxtbox.text!)! / 100
            let number = Double(ODnumbertxtbox.text!)!
            
            print("Present Value: \(PeriodFV)")
            print("Rate: \(rate)")
            print("Number: \(number)")
            
            //Formula is Periods with PV --> Pmt= PV / [(1 − (1/(1+i)^N))/i]
            
            
            let firstCalc = 1 / (pow((1 + rate), number))
            print(firstCalc)
            let secondCalc = (1 - firstCalc) / rate
            print(secondCalc)
            let finalCalc = PeriodFV/secondCalc
            print(finalCalc)
            
            //Add Payment Label
            ODpmtlbl.frame = CGRect(x: 35, y: 530, width: 250, height: 40)
            ODpmtlbl.text = "Payments:"
            ODpmtlbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ODpmtlbl.textColor = UIColor.white
            ODpmtlbl.layer.zPosition = 2
            self.ContentView.addSubview(ODpmtlbl)
            
            //Add Future Value Label Amount
            ODpaymentValue.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            ODpaymentValue.text = "\(currencyDefault)\(round(100.0 * finalCalc) / 100.0)"
            ODpaymentValue.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ODpaymentValue.textColor = UIColor.white
            ODpaymentValue.layer.zPosition = 2
            self.ContentView.addSubview(ODpaymentValue)
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
        ODpmtlbl.frame = CGRect(x: 35, y: 240, width: 250, height: 40)
        ODpmtlbl.text = "Payments"
        ODpmtlbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODpmtlbl.textColor = UIColor.white
        ODpmtlbl.layer.zPosition = 2
        self.ContentView.addSubview(ODpmtlbl)
        //Payment Field
        ODpmttxtbox.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        ODpmttxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODpmttxtbox.backgroundColor = UIColor.white
        ODpmttxtbox.textColor = UIColor.black
        ODpmttxtbox.keyboardType = .decimalPad
        ODpmttxtbox.inputAccessoryView = doneToolbar
        ODpmttxtbox.textAlignment = .center
        ODpmttxtbox.tintColor = UIColor.clear
        ODpmttxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODpmttxtbox)
        
        //Present Value
        ODpresentValueLbl.frame = CGRect(x: 35, y: 320, width: 250, height: 40)
        ODpresentValueLbl.text = "Present Value"
        ODpresentValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODpresentValueLbl.textColor = UIColor.white
        ODpresentValueLbl.layer.zPosition = 2
        self.ContentView.addSubview(ODpresentValueLbl)
        //Present Value Field
        ODPVtxtbox.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        ODPVtxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODPVtxtbox.backgroundColor = UIColor.white
        ODPVtxtbox.textColor = UIColor.black
        ODPVtxtbox.keyboardType = .decimalPad
        ODPVtxtbox.inputAccessoryView = doneToolbar
        ODPVtxtbox.textAlignment = .center
        ODPVtxtbox.tintColor = UIColor.clear
        ODPVtxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODPVtxtbox)
        
        //Rate Label
        ODrateLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        ODrateLbl.text = "Rate %"
        ODrateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODrateLbl.textColor = UIColor.white
        ODrateLbl.layer.zPosition = 2
        self.ContentView.addSubview(ODrateLbl)
        //Rate Value Field
        ODratetxtbox.frame = CGRect(x: 35, y: 440, width: 250, height: 40)
        ODratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODratetxtbox.backgroundColor = UIColor.white
        ODratetxtbox.textColor = UIColor.black
        ODratetxtbox.keyboardType = .decimalPad
        ODratetxtbox.inputAccessoryView = doneToolbar
        ODratetxtbox.textAlignment = .center
        ODratetxtbox.tintColor = UIColor.clear
        ODratetxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODratetxtbox)
        // PV Label
        
        // Calculation Button
        ODNumPVcalc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        ODNumPVcalc.setTitle("Calculate", for: .normal)
        ODNumPVcalc.backgroundColor = UIColor(named: "SpecialGreen")
        ODNumPVcalc.layer.borderColor = UIColor.darkGray.cgColor
        ODNumPVcalc.layer.borderWidth = 1
        ODNumPVcalc.layer.cornerRadius = 5.0
        ODNumPVcalc.layer.zPosition = 2
        ODNumPVcalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        ODNumPVcalc.addTarget(self, action: #selector(ODNumPVcalculation), for:  .touchUpInside)
        self.ContentView.addSubview(ODNumPVcalc)
    }
    @objc func ODNumPVcalculation(){
        //Resign first responder
        ODlookingFor.resignFirstResponder()
        ODpmttxtbox.resignFirstResponder()
        ODratetxtbox.resignFirstResponder()
        ODPVtxtbox.resignFirstResponder()
        
        //if statement to check through each field (ensuring they are not negative)
        if ODpmttxtbox.hasText == false || ODratetxtbox.hasText == false || ODPVtxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            // Calculation passes through validation
            let PV = Double(ODPVtxtbox.text!)!
            let rate = Double(ODratetxtbox.text!)! / 100
            let payment = Double(ODpmttxtbox.text!)!
            
            
            //Formula is Periods with PV --> N= −ln(1−PVA/Pmti)ln(1+i)
            // 1 / (1 - (PV(r)/Pmt))      /  ln (1+r)
            let firstCalc = log(1+rate)
            print(firstCalc)
            let secondCalc = log(pow((1 - ((PV*rate)/payment)),-1))
            print(secondCalc)
            let finalCalc = secondCalc/firstCalc
            print(finalCalc)
            
            //Add Payment Label
            ODnumberLbl.frame = CGRect(x: 35, y: 530, width: 300, height: 40)
            ODnumberLbl.text = "Number of Periods"
            ODnumberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ODnumberLbl.textColor = UIColor.white
            ODnumberLbl.layer.zPosition = 2
            self.ContentView.addSubview(ODnumberLbl)
            
            //Add Future Value Label Amount
            ODnumberValue.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            ODnumberValue.text = "\(round(100.0 * finalCalc) / 100.0)"
            ODnumberValue.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ODnumberValue.textColor = UIColor.white
            ODnumberValue.layer.zPosition = 2
            self.ContentView.addSubview(ODnumberValue)
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
        ODpmtlbl.frame = CGRect(x: 35, y: 240, width: 250, height: 40)
        ODpmtlbl.text = "Payments"
        ODpmtlbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODpmtlbl.textColor = UIColor.white
        ODpmtlbl.layer.zPosition = 2
        self.ContentView.addSubview(ODpmtlbl)
        //Payment Field
        ODpmttxtbox.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        ODpmttxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODpmttxtbox.backgroundColor = UIColor.white
        ODpmttxtbox.textColor = UIColor.black
        ODpmttxtbox.keyboardType = .decimalPad
        ODpmttxtbox.inputAccessoryView = doneToolbar
        ODpmttxtbox.textAlignment = .center
        ODpmttxtbox.tintColor = UIColor.clear
        ODpmttxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODpmttxtbox)
        
        //Future Value
        ODfutureValueLbl.frame = CGRect(x: 35, y: 320, width: 250, height: 40)
        ODfutureValueLbl.text = "Future Value"
        ODfutureValueLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODfutureValueLbl.textColor = UIColor.white
        ODfutureValueLbl.layer.zPosition = 2
        self.ContentView.addSubview(ODfutureValueLbl)
        //Present Value Field
        ODFVtxtbox.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        ODFVtxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODFVtxtbox.backgroundColor = UIColor.white
        ODFVtxtbox.textColor = UIColor.black
        ODFVtxtbox.keyboardType = .decimalPad
        ODFVtxtbox.inputAccessoryView = doneToolbar
        ODFVtxtbox.textAlignment = .center
        ODFVtxtbox.tintColor = UIColor.clear
        ODFVtxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODFVtxtbox)
        
        //Rate Label
        ODrateLbl.frame = CGRect(x: 35, y: 400, width: 250, height: 40)
        ODrateLbl.text = "Rate %"
        ODrateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        ODrateLbl.textColor = UIColor.white
        ODrateLbl.layer.zPosition = 2
        self.ContentView.addSubview(ODrateLbl)
        //Rate Value Field
        ODratetxtbox.frame = CGRect(x: 35, y: 440, width: 250, height: 40)
        ODratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        ODratetxtbox.backgroundColor = UIColor.white
        ODratetxtbox.textColor = UIColor.black
        ODratetxtbox.keyboardType = .decimalPad
        ODratetxtbox.inputAccessoryView = doneToolbar
        ODratetxtbox.textAlignment = .center
        ODratetxtbox.tintColor = UIColor.clear
        ODratetxtbox.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(ODratetxtbox)
        // PV Label
        
        // Calculation Button
        ODNumFVcalc.frame = CGRect(x: 35, y: 490, width: 250, height: 40)
        ODNumFVcalc.setTitle("Calculate", for: .normal)
        ODNumFVcalc.backgroundColor = UIColor(named: "SpecialGreen")
        ODNumFVcalc.layer.borderColor = UIColor.darkGray.cgColor
        ODNumFVcalc.layer.borderWidth = 1
        ODNumFVcalc.layer.cornerRadius = 5.0
        ODNumFVcalc.layer.zPosition = 2
        ODNumFVcalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        ODNumFVcalc.addTarget(self, action: #selector(ODNumFVcalculation), for:  .touchUpInside)
        self.ContentView.addSubview(ODNumFVcalc)
    }
    @objc func ODNumFVcalculation(){
        //Resign first responder
        ODlookingFor.resignFirstResponder()
        ODpmttxtbox.resignFirstResponder()
        ODratetxtbox.resignFirstResponder()
        ODFVtxtbox.resignFirstResponder()
        
        //if statement to check through each field (ensuring they are not negative)
        if ODpmttxtbox.hasText == false || ODratetxtbox.hasText == false || ODFVtxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            // Calculation passes through validation
            let FV = Double(ODFVtxtbox.text!)!
            let rate = Double(ODratetxtbox.text!)! / 100
            let payment = Double(ODpmttxtbox.text!)!
            
            
            //Formula is Number PV
            // log(1 + (FV(r)/PMT)) / log(1+r)
            
            
            let firstCalc = log(1+rate)
            print(firstCalc)
            let secondCalc = log(1 + (FV*rate/payment))
            print(secondCalc)
            let finalCalc = secondCalc/firstCalc
            print(finalCalc)
            
            //Add Payment Label
            ODnumberLbl.frame = CGRect(x: 35, y: 530, width: 300, height: 40)
            ODnumberLbl.text = "Number of Periods"
            ODnumberLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ODnumberLbl.textColor = UIColor.white
            ODnumberLbl.layer.zPosition = 2
            self.ContentView.addSubview(ODnumberLbl)
            
            //Add Future Value Label Amount
            ODnumberValue.frame = CGRect(x: 35, y: 570, width: 250, height: 40)
            ODnumberValue.text = "\(round(100.0 * finalCalc) / 100.0)"
            ODnumberValue.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            ODnumberValue.textColor = UIColor.white
            ODnumberValue.layer.zPosition = 2
            self.ContentView.addSubview(ODnumberValue)
        }
    }
}

extension OrdinaryAnnuity: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        ODchoices.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ODchoices[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ODlookingFor.text = ODchoices[row]
        let selectedValue = ODchoices[pickerView.selectedRow(inComponent: 0)]
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
            // # of period stuff FV KNOWN
            PeriodicPaymentFV()
        } else if selectedValue == "Periodic Payment, PV known" {
            print("Periodic Payment, PV known")
            // # of period stuff PV KNOWN
            PeriodicPaymentPV()
        } else if selectedValue == "Number of Periods, FV known" {
            print("Number of Periods, FV known")
            NumberwithFV()
        } else if selectedValue == "Number of Periods, PV known" {
            print("Number of Periods, PV known")
            NumberwithPV()
        } else {
            print("Remove Everything")
            // Nothing selected so remove views
            ODPVcalc.removeFromSuperview()
            ODFVcalc.removeFromSuperview()
            ODPMTFVcalc.removeFromSuperview()
            ODPMTPVcalc.removeFromSuperview()
            ODNumFVcalc.removeFromSuperview()
            ODNumPVcalc.removeFromSuperview()
            
            ODnumbertxtbox.removeFromSuperview()
            ODratetxtbox.removeFromSuperview()
            ODFVtxtbox.removeFromSuperview()
            ODPVtxtbox.removeFromSuperview()
            
            ODrateLbl.removeFromSuperview()
            ODnumberLbl.removeFromSuperview()
            ODpresentValueLbl.removeFromSuperview()
            ODfutureValueLbl.removeFromSuperview()
            
            ODfutureValueAnswer.removeFromSuperview()
            ODpresentValueAnswer.removeFromSuperview()
            ODrateValue.removeFromSuperview()
            ODnumberValue.removeFromSuperview()
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
