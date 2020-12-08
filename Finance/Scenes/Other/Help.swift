//
//  Help.swift
//  Finance
//
//  Created by Jordan Klein on 12/4/20.
//

import Foundation
import UIKit


class Help: UIViewController, UITextFieldDelegate {
    var helppickerView = UIPickerView()
    let helpchoices = ["","Simple Interest","Compound Interest","Interest-Only Loan","Amortized Loan","Lump Sum Annuity","Ordinary Annuity","Annuity Due"]
    let helpLookingFor = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Things to load in once
        header() //header
        gestures() // Swiping back on edge
        addingBackgroundShapes() // adding the top shape
        Labels()// search thing
        
        
        
        //PickerView Delegates
        helppickerView.delegate = self
        helppickerView.dataSource = self
        
        helpLookingFor.delegate = self
        helpLookingFor.inputView = helppickerView
    }
    
    @IBOutlet weak var ContentView: UIView!
    
    func header(){
        //Creating Label
        let questionLbl = UILabel()
        questionLbl.frame = CGRect(x: 35, y: 70, width: 250, height: 40)
        questionLbl.text = "Help."
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
    func gestures(){
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
            edgePan.edges = .left

            view.addGestureRecognizer(edgePan)
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
    func Labels(){
        // Creating "What are you looking for?
        let questionLbl = UILabel()
        questionLbl.frame = CGRect(x: 35, y: 160, width: 350, height: 40)
        questionLbl.text = "Need some information?"
        questionLbl.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        questionLbl.textColor = UIColor.white
        questionLbl.layer.zPosition = 2
        self.ContentView.addSubview(questionLbl)

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
        helpLookingFor.frame = CGRect(x: 35, y: 200, width: 305, height: 40)
        helpLookingFor.borderStyle = UITextField.BorderStyle.bezel
        helpLookingFor.backgroundColor = UIColor.white
        helpLookingFor.textColor = UIColor.black
        helpLookingFor.inputAccessoryView = doneToolbar
        helpLookingFor.textAlignment = .center
        helpLookingFor.tintColor = UIColor.clear
        helpLookingFor.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        self.ContentView.addSubview(helpLookingFor)
    }
    @objc func firstRes(){
        helpLookingFor.resignFirstResponder()
    }
//    func labels(){
//        let textfield = UITextView()
//        textfield.frame = CGRect(x: 35, y: 150, width: 305, height: ContentView.frame.size.height)
//        textfield.text = """
//        "Derivitives are financial weapons of mass destruction" - Warren Buffet
//
//        Calculations Available:
//
//        Simple Interest - Loans, Savings Accounts, Certifcates of Deposit (CD), and many more
//
//        Compound Interest - Retirement Accounts, Loans, Certifcates of Deposit (CD), Investment Accounts, Saving Accounts, and many more
//
//        Interest-Only Loan - Option ARM loans, Balloon loans, No-Money-Down loans, and Home loans
//
//        Amortized Loan - Mortgage, Hard-Money, Vehicle, Equipment, Intangible Assets, and many more
//
//        Lump Sum Annuity - single amount paid in one transaction rather than over a certain amount of installments
//
//        Ordinary Annuity - Home Mortgages, Income Annuities, Dividend Annuities, and many more.
//
//        Annuity Due - Similar to Ordinary Annuities but whose payment is due at the beginning of each period.
//
//        © Jordan Klein 2020
//        """
//        textfield.isUserInteractionEnabled = false
//        textfield.font = UIFont(name: "PingFangSC-Semibold", size: 20)
//        textfield.isEditable = true
//        textfield.backgroundColor = .clear
//        textfield.textColor = UIColor.white
//        self.ContentView.addSubview(textfield)
//
//    }
}
extension Help: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        helpchoices.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return helpchoices[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        helpLookingFor.text = helpchoices[row]
        let selectedValue = helpchoices[pickerView.selectedRow(inComponent: 0)]
        if selectedValue == "Simple Interest" {
            print("Simple Interest Selected")
           
            
        } else if selectedValue == "Compound Interest" {
            print("Compound Interest Selected")
         
            
        } else if selectedValue == "Interest-Only Loan" {
            print("Interest-Only Selected")
         
            
        } else if selectedValue == "Amortized Loan" {
            print("Amortized Loan Selected")
       
            
        } else if selectedValue == "Lump Sum Annuity" {
            print("Lump Sum Annuity Selected")
         
            
        } else if selectedValue == "Ordinary Annuity" {
            print("Ordinary Annuity Selected")
           
            
        } else if selectedValue == "Annuity Due" {
            print("Annuity Due Selected")
          
            
        } else {
            print("Remove Everything")
            // removeEverything() function can be called to remove all of the labels i will be adding
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
