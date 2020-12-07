//
//  Amortization.swift
//  Finance
//
//  Created by Jordan Klein on 11/21/20.
//

import Foundation
import UIKit
// Amortization Calc
let AmortCalc = UIButton()
//Labels
let loanTotalInt = UILabel()
let loanTotalAmt = UILabel()

// loan text boxes
let Lpritxtbox = UITextField()
let Lratetxtbox = UITextField()
let Ltimetxtbox = UITextField()



class Amortization: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        addingBackgroundShapes() // adding black background and top shape
        gestures()
        createLabel() // Header and Back Button
        labels() //Labels
        textBoxes() // Creating the textboxes
        calculateButton() // Creating the calculate button
        
        Lpritxtbox.delegate = self
        Lratetxtbox.delegate = self
        Ltimetxtbox.delegate = self
    }
    @IBOutlet weak var ContentView: UIView!
    func createLabel(){
        //Creating Label
        let questionLbl = UILabel()
        questionLbl.frame = CGRect(x: 35, y: 70, width: 250, height: 40)
        questionLbl.text = "Amortized Loan."
        questionLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        questionLbl.textColor = UIColor.black
        questionLbl.layer.zPosition = 2
        self.view.addSubview(questionLbl)
        
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
        self.view.layer.addSublayer(topTri)
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
        timeLbl.text = "Time (Years)"
        timeLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        timeLbl.textColor = UIColor.white
        timeLbl.layer.zPosition = 2
        self.ContentView.addSubview(timeLbl)
        
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
        
        Lpritxtbox.frame = CGRect(x: 35, y: 240, width: 200, height: 40)
        Lpritxtbox.borderStyle = UITextField.BorderStyle.bezel
        Lpritxtbox.backgroundColor = UIColor.white
        Lpritxtbox.textColor = UIColor.black
        Lpritxtbox.keyboardType = .decimalPad
        Lpritxtbox.inputAccessoryView = doneToolbar
        self.ContentView.addSubview(Lpritxtbox)
        //Rate Amount
        
        Lratetxtbox.frame = CGRect(x: 35, y: 320, width: 100, height: 40)
        Lratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        Lratetxtbox.backgroundColor = UIColor.white
        Lratetxtbox.textColor = UIColor.black
        Lratetxtbox.keyboardType = .decimalPad
        Lratetxtbox.inputAccessoryView = doneToolbar
        self.ContentView.addSubview(Lratetxtbox)
        // time amount
        
        Ltimetxtbox.frame = CGRect(x: 35, y: 400, width: 100, height: 40)
        Ltimetxtbox.borderStyle = UITextField.BorderStyle.bezel
        Ltimetxtbox.backgroundColor = UIColor.white
        Ltimetxtbox.textColor = UIColor.black
        Ltimetxtbox.keyboardType = .decimalPad
        Ltimetxtbox.inputAccessoryView = doneToolbar
        self.ContentView.addSubview(Ltimetxtbox)
    }
    
    @objc func firstRes(){
        Lpritxtbox.resignFirstResponder()
        Lratetxtbox.resignFirstResponder()
        Ltimetxtbox.resignFirstResponder()
    }
    
    func calculateButton() {
        AmortCalc.frame = CGRect(x: 150, y: 400, width: 175, height: 40)
        AmortCalc.setTitle("Calculate", for: .normal)
        AmortCalc.backgroundColor = UIColor(named: "SpecialGreen")
        AmortCalc.layer.borderColor = UIColor.darkGray.cgColor
        AmortCalc.layer.borderWidth = 1
        AmortCalc.layer.cornerRadius = 5.0
        AmortCalc.layer.zPosition = 2
        AmortCalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        AmortCalc.addTarget(self, action: #selector(calculation), for: .touchUpInside)
        self.ContentView.addSubview(AmortCalc)
    }
    
    //Calculation objc
    
    @objc func calculation(){
        calcLbl.text = ""
        Lpritxtbox.resignFirstResponder()
        Lratetxtbox.resignFirstResponder()
        Ltimetxtbox.resignFirstResponder()
        if Lpritxtbox.hasText == false || Lratetxtbox.hasText == false || Ltimetxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let principal = Double(Lpritxtbox.text!)!
            let rate = (Double(Lratetxtbox.text!)! / 100) / 12 //amortized so rate monthly
            let time = Double(Ltimetxtbox.text!)! * 12 // in months
            
            // Amortizing loans
            // Find the right formula
            // n = years
            // Discount formula D = {[(1+r)^n] - 1} / [r(1+r)^n]
            // Interest-only loans are Loan Payment = Loan Balance * (annual interest/12)
            
            
            let discountFactor = (pow((1+rate), time) - 1) / (rate * pow((1+rate), time)) // for calculating Monthly payment
            // Monthly Payment
            let endCalc = principal/discountFactor
            
            
            // Calculating total interest to be paid
            let withInt = time * endCalc
            let totalLoanInterest = withInt - principal
            
            
            // Create Monthly Payment Label
            let totalmonthlyAMTLbl = UILabel()
            totalmonthlyAMTLbl.frame = CGRect(x: 35, y: 440, width: 300, height: 40)
            totalmonthlyAMTLbl.text = "Monthly Payment:"
            totalmonthlyAMTLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            totalmonthlyAMTLbl.textColor = UIColor.white
            totalmonthlyAMTLbl.layer.zPosition = 2
            self.ContentView.addSubview(totalmonthlyAMTLbl)

            // Returns Monthly Payment with Interest
            calcLbl.frame = CGRect(x: 35, y: 480, width: 300, height: 40)
            calcLbl.text = "\(currencyDefault)\(round(100.0 * (endCalc)) / 100.0)"
            calcLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            calcLbl.textColor = UIColor.white
            calcLbl.layer.zPosition = 2
            self.ContentView.addSubview(calcLbl)

            // Create Monthly Interest Amount Label
            let monthlyIntAMTLbl = UILabel()
            monthlyIntAMTLbl.frame = CGRect(x: 35, y: 520, width: 300, height: 40)
            monthlyIntAMTLbl.text = "Monthly Interest:"
            monthlyIntAMTLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            monthlyIntAMTLbl.textColor = UIColor.white
            monthlyIntAMTLbl.layer.zPosition = 2
            self.ContentView.addSubview(monthlyIntAMTLbl)

            // Returns Monthly Interest
            intlbl.frame = CGRect(x: 35, y: 560, width: 300, height: 40)
            intlbl.text = "\(currencyDefault)\(round(100.0 * (totalLoanInterest/time)) / 100.0)"
            intlbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            intlbl.textColor = UIColor.white
            intlbl.layer.zPosition = 2
            self.ContentView.addSubview(intlbl)
            
            // Total Interest
            let totalIntAMTLbl = UILabel()
            totalIntAMTLbl.frame = CGRect(x: 35, y: 600, width: 300, height: 40)
            totalIntAMTLbl.text = "Total Interest:"
            totalIntAMTLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            totalIntAMTLbl.textColor = UIColor.white
            totalIntAMTLbl.layer.zPosition = 2
            self.ContentView.addSubview(totalIntAMTLbl)
            
            //Total Interest
            loanTotalInt.frame = CGRect(x: 35, y: 640, width: 300, height: 40)
            loanTotalInt.text = "\(currencyDefault)\(round(100.0 * (totalLoanInterest)) / 100.0)"
            loanTotalInt.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            loanTotalInt.textColor = UIColor.white
            loanTotalInt.layer.zPosition = 2
            self.ContentView.addSubview(loanTotalInt)
                
            // Total Amount of Loan
            let totalAMTLbl = UILabel()
            totalAMTLbl.frame = CGRect(x: 35, y: 680, width: 300, height: 40)
            totalAMTLbl.text = "Total Amount:"
            totalAMTLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            totalAMTLbl.textColor = UIColor.white
            totalAMTLbl.layer.zPosition = 2
            self.ContentView.addSubview(totalAMTLbl)
            
            //Total Amount
            loanTotalAmt.frame = CGRect(x: 35, y: 720, width: 300, height: 40)
            loanTotalAmt.text = "\(currencyDefault)\(round(100.0 * (withInt)) / 100.0)"
            loanTotalAmt.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            loanTotalAmt.textColor = UIColor.white
            loanTotalAmt.layer.zPosition = 2
            self.ContentView.addSubview(loanTotalAmt)
            
            
        }

    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let arrayOfString = newString.components(separatedBy: ".")

        if arrayOfString.count > 2 { // limiting how many decimals can exist
            return false
        }
        return true
    }
} // End of Class
