//
//  Compound Interest.swift
//  Finance
//
//  Created by Jordan Klein on 11/21/20.
//

import Foundation
import UIKit

// Arrows
let backConfiguration = UIImage.SymbolConfiguration(pointSize: 55, weight: .black)
let backImage = UIImage(systemName: "arrow.left", withConfiguration: backConfiguration)
let nextConfiguration = UIImage.SymbolConfiguration(pointSize: 55, weight: .black)
let nextImage = UIImage(systemName: "arrow.right", withConfiguration: nextConfiguration)

// UITextfieldsCompound
let COMpritxtBox = UITextField()
let COMratetxtBox = UITextField()
let COMtimetxtBox = UITextField()
let COMperiodtxtBox = UITextField()
// Final result label Compound
let COMtotalcalcLbl = UILabel()
let COMintcalcLbl = UILabel()

class CompoundInt: UIViewController, UITextFieldDelegate{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingBackgroundShapes() // adding black background and top shape
        gestures()
        createLabel() // Header and Back Button
        labels() //Labels
        textBoxes() // Creating the textboxes
        calculateButton() // Creating the calculate button
        
        COMpritxtBox.delegate = self
        COMratetxtBox.delegate = self
        COMtimetxtBox.delegate = self
        COMperiodtxtBox.delegate = self
    }
    
    @IBOutlet weak var ContentView: UIView!
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
        view.backgroundColor = UIColor(named: "SpecialGreen")
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
        self.ContentView.addSubview(principalLbl)
        //Rate Label
        let rateLbl = UILabel()
        rateLbl.frame = CGRect(x: 35, y: 280, width: 250, height: 40)
        rateLbl.text = "Rate %"
        rateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        rateLbl.textColor = UIColor.white
        rateLbl.layer.zPosition = 2
        self.ContentView.addSubview(rateLbl)
        //Time Label
        let timeLbl = UILabel()
        timeLbl.frame = CGRect(x: 35, y: 360, width: 250, height: 40)
        timeLbl.text = "Time (T)"
        timeLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        timeLbl.textColor = UIColor.white
        timeLbl.layer.zPosition = 2
        self.ContentView.addSubview(timeLbl)
        // Period Label
        let periodLbl = UILabel()
        periodLbl.frame = CGRect(x: 150, y: 280, width: 200, height: 40)
        periodLbl.text = "# of Periods (N)"
        periodLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        periodLbl.textColor = UIColor.white
        periodLbl.layer.zPosition = 2
        self.ContentView.addSubview(periodLbl)
    }
    //Function for adding text boxes
    func textBoxes(){
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
        // Principal Amount
        
        COMpritxtBox.frame = CGRect(x: 35, y: 240, width: 200, height: 40)
        COMpritxtBox.borderStyle = UITextField.BorderStyle.bezel
        COMpritxtBox.backgroundColor = UIColor.white
        COMpritxtBox.textColor = UIColor.black
        COMpritxtBox.keyboardType = .decimalPad
        COMpritxtBox.inputAccessoryView = doneToolbar
        self.ContentView.addSubview(COMpritxtBox)
        //Rate Amount
        
        COMratetxtBox.frame = CGRect(x: 35, y: 320, width: 100, height: 40)
        COMratetxtBox.borderStyle = UITextField.BorderStyle.bezel
        COMratetxtBox.backgroundColor = UIColor.white
        COMratetxtBox.textColor = UIColor.black
        COMratetxtBox.keyboardType = .decimalPad
        COMratetxtBox.inputAccessoryView = doneToolbar
        self.ContentView.addSubview(COMratetxtBox)
        // time amount
        
        COMtimetxtBox.frame = CGRect(x: 35, y: 400, width: 100, height: 40)
        COMtimetxtBox.borderStyle = UITextField.BorderStyle.bezel
        COMtimetxtBox.backgroundColor = UIColor.white
        COMtimetxtBox.textColor = UIColor.black
        COMtimetxtBox.keyboardType = .decimalPad
        COMtimetxtBox.inputAccessoryView = doneToolbar
        self.ContentView.addSubview(COMtimetxtBox)
        
        // Period Text Box View
        COMperiodtxtBox.frame = CGRect(x: 150, y: 320, width: 175, height: 40)
        COMperiodtxtBox.backgroundColor = UIColor.white
        COMperiodtxtBox.textColor = UIColor.black
        COMperiodtxtBox.keyboardType = .decimalPad
        COMperiodtxtBox.inputAccessoryView = doneToolbar
        self.ContentView.addSubview(COMperiodtxtBox)
    }
    @objc func firstRes(){
        COMpritxtBox.resignFirstResponder()
        COMratetxtBox.resignFirstResponder()
        COMtimetxtBox.resignFirstResponder()
        COMperiodtxtBox.resignFirstResponder()
    }
    
    func calculateButton() {
        
        calc.frame = CGRect(x: 150, y: 400, width: 175, height: 40)
        calc.setTitle("Calculate", for: .normal)
        calc.backgroundColor = UIColor(named: "SpecialGreen")
        calc.layer.borderColor = UIColor.darkGray.cgColor
        calc.layer.borderWidth = 1
        calc.layer.cornerRadius = 5.0
        calc.layer.zPosition = 2
        calc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        calc.addTarget(self, action: #selector(calculation), for: .touchUpInside)
        self.ContentView.addSubview(calc)
    }
    func dropdown(){
        // add dropdown
        
    }
    //Calculation objc
    @objc func calculation(){
        view.endEditing(true)
        calcLbl.text = ""
        // if month/year is not selected bring error message!
        
        // Validation Here
        if COMpritxtBox.hasText == false || COMratetxtBox.hasText == false || COMtimetxtBox.hasText == false || COMperiodtxtBox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            //Continue through
            let principal = Double(COMpritxtBox.text!)!
            let rate = Double(COMratetxtBox.text!)!
            let time = Double(COMtimetxtBox.text!)!
            let number = Double(COMperiodtxtBox.text!)!
            
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
            self.ContentView.addSubview(totalAMTLbl)
            
            // Returns Total Principal with Interest
            COMtotalcalcLbl.frame = CGRect(x: 35, y: 480, width: 300, height: 40)
            COMtotalcalcLbl.text = "\(currencyDefault)\(round(100.0 * endCalc) / 100.0)"
            COMtotalcalcLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            COMtotalcalcLbl.textColor = UIColor.white
            COMtotalcalcLbl.layer.zPosition = 2
            self.ContentView.addSubview(COMtotalcalcLbl)
            
            // Create Total Interest Amount Label
            let totalIntAMTLbl = UILabel()
            totalIntAMTLbl.frame = CGRect(x: 35, y: 520, width: 300, height: 40)
            totalIntAMTLbl.text = "Total Interest:"
            totalIntAMTLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            totalIntAMTLbl.textColor = UIColor.white
            totalIntAMTLbl.layer.zPosition = 2
            self.ContentView.addSubview(totalIntAMTLbl)
            
            // Returns Total Interest
            COMintcalcLbl.frame = CGRect(x: 35, y: 560, width: 300, height: 40)
            COMintcalcLbl.text = "\(currencyDefault)\(round(100.0 * (endCalc-principal)) / 100.0)"
            COMintcalcLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            COMintcalcLbl.textColor = UIColor.white
            COMintcalcLbl.layer.zPosition = 2
            self.ContentView.addSubview(COMintcalcLbl)
            
        }// End of If
        
    }// End of Calculate button
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let arrayOfString = newString.components(separatedBy: ".")

        if arrayOfString.count > 2 { // limiting how many decimals can exist
            return false
        }
        return true
    }
    
} // End of class
