//
//  Help.swift
//  Finance
//
//  Created by Jordan Klein on 12/4/20.
//
//
// Sources used: 
// https://www.bankrate.com/glossary/s/simple-interest/
// https://www.investopedia.com
//

import Foundation
import UIKit
import GoogleMobileAds


class Help: UIViewController, UITextFieldDelegate, GADRewardedAdDelegate {
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        print("Reward")
    }
    
    //PickerViewStuff
    var helppickerView = UIPickerView()
    let helpchoices = ["","Simple Interest","Compound Interest","Interest-Only Loan","Amortized Loan","Lump Sum Annuity","Ordinary Annuity","Annuity Due"]
    let helpLookingFor = UITextField()
    
    //UILabels
    let definition = UILabel()
    let formula = UILabel()
    //UIDefinitionLabels
    // Simple int
    let definitionSimpInt = UITextView()
    let formulaSimpInt = UITextView()
    //Compound int
    let definitionCompInt = UITextView()
    let formulaCompInt = UITextView()
    // Simple-Int Loan
    let definitionintOnly = UITextView()
    let formulaIntOnly = UITextView()
    // Amortized Loan
    let definitionAmortLoan = UITextView()
    let formulaAmortLoan = UITextView()
    // Lump Sum
    let definitionLumpSum = UITextView()
    let formulaLumpSum = UITextView()
    // Ordinary Annuity
    let definitionOrdinary = UITextView()
    let formulaOrdinary = UITextView()
    // Annuity Due
    let definitionDue = UITextView()
    let formulaDue = UITextView()
    
    //Maybe add examples in the future?
    override func viewDidLoad() {
        super.viewDidLoad()
        //Things to load in once
        header() //header
        gestures() // Swiping back on edge
        addingBackgroundShapes() // adding the top shape
        Labels()// search thing
        generalLabels()//Definition,Examples,and Formula
        
        
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
        questionLbl.font = UIFont(name: "PingFangSC-Semibold", size: 23)
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
    func generalLabels(){
        definition.text = "Definition:"
        definition.frame = CGRect(x: 35, y: 260, width: 350, height: 40)
        definition.font = UIFont(name: "PingFangSC-Semibold", size: 22)
        definition.textColor = UIColor.white
        definition.layer.zPosition = 2
        
        formula.text = "Formula:"
        formula.frame = CGRect(x: 35, y: 620, width: 350, height: 40)
        formula.font = UIFont(name: "PingFangSC-Semibold", size: 22)
        formula.textColor = UIColor.white
        formula.layer.zPosition = 2
    }
    func runningNotifications(){
       //Ad Notificaiton
        NotificationCenter.default.addObserver(self, selector: #selector(loadInterstitial), name: .showInterstitialAd, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadVideo), name: .showVideoRewardAd, object: nil)
    }
    @objc func loadInterstitial() {
        print("Setting up")
        if gadRewardedAd?.isReady == true {
            gadRewardedAd?.present(fromRootViewController: self, delegate:self)
            print("Presented")
        }
    }
    @objc func loadVideo(){
        print("Setting up")
        if gadRewardedAd?.isReady == true {
            gadRewardedAd?.present(fromRootViewController: self, delegate:self)
            print("Presented")
        }
    }
    func SimpleInterest(){
        RemoveEverything()
        self.ContentView.addSubview(definition)
        //Adding Simp Int Definition
        definitionSimpInt.frame = CGRect(x: 35, y: 290, width: 325, height: 320)
        definitionSimpInt.text = """
        Simple interest is interest calculated on the principal portion of a loan or the original contribution to a savings account. Simple interest does not compound, meaning that an account holder will only gain interest on the principal, and a borrower will never have to pay interest on interest already accrued.
        """
        definitionSimpInt.isUserInteractionEnabled = false
        definitionSimpInt.font = UIFont(name: "PingFangSC-Semibold",size: 20)
        definitionSimpInt.isEditable = true
        definitionSimpInt.backgroundColor = .clear
        definitionSimpInt.textColor = UIColor.white
        self.ContentView.addSubview(definitionSimpInt)
        //Adding Simp Int Formula
        self.ContentView.addSubview(formula)
        formulaSimpInt.frame = CGRect(x: 35, y: 650, width: 325, height: 200)
        formulaSimpInt.text = """
        Simple Interest = P × I × T
        P = initial amount of money
        I = interest rate
        T =number of years or periods the money is invested or borrowed
        """
        formulaSimpInt.isUserInteractionEnabled = false
        formulaSimpInt.font = UIFont(name: "PingFangSC-Semibold",size: 20)
        formulaSimpInt.isEditable = true
        formulaSimpInt.backgroundColor = .clear
        formulaSimpInt.textColor = UIColor.white
        self.ContentView.addSubview(formulaSimpInt)
    }
    func CompoundInterest(){
        RemoveEverything()
        self.ContentView.addSubview(definition)
        //Adding Simp Int Definition
        definitionCompInt.frame = CGRect(x: 35, y: 290, width: 325, height: 320)
        definitionCompInt.text = """
        Compound interest is the interest on a loan or deposit calculated based on both the initial principal and the accumulated interest from previous periods. Thought to have originated in 17th century Italy, compound interest can be thought of as "interest on interest".
        """
        definitionCompInt.isUserInteractionEnabled = false
        definitionCompInt.font = UIFont(name: "PingFangSC-Semibold",size: 20)
        definitionCompInt.isEditable = true
        definitionCompInt.backgroundColor = .clear
        definitionCompInt.textColor = UIColor.white
        self.ContentView.addSubview(definitionCompInt)
        //Adding Simp Int Formula
        self.ContentView.addSubview(formula)
        formulaCompInt.frame = CGRect(x: 35, y: 650, width: 325, height: 200)
        formulaCompInt.text = """
        P(1 + (r/n))^(n*t)
        P = initial principal balance
        r = interest rate
        n = number of times interest applied per time period
        t = number of time periods elapsed
        """
        formulaCompInt.isUserInteractionEnabled = false
        formulaCompInt.font = UIFont(name: "PingFangSC-Semibold",size: 20)
        formulaCompInt.isEditable = true
        formulaCompInt.backgroundColor = .clear
        formulaCompInt.textColor = UIColor.white
        self.ContentView.addSubview(formulaCompInt)
    }
    func InterestOnlyLoan(){
        RemoveEverything()
        self.ContentView.addSubview(definition)
        //Adding Simp Int Definition
        definitionintOnly.frame = CGRect(x: 35, y: 290, width: 325, height: 320)
        definitionintOnly.text = """
        Simple interest loans are a quick and easy method of calculating the interest charge on a loan. Simple interest is determined by multiplying the daily interest rate by the principal by the number of days that elapse between payments.
        """
        definitionintOnly.isUserInteractionEnabled = false
        definitionintOnly.font = UIFont(name: "PingFangSC-Semibold",size: 20)
        definitionintOnly.isEditable = true
        definitionintOnly.backgroundColor = .clear
        definitionintOnly.textColor = UIColor.white
        self.ContentView.addSubview(definitionintOnly)
        //Adding Simp Int Formula
        self.ContentView.addSubview(formula)
        formulaIntOnly.frame = CGRect(x: 35, y: 650, width: 325, height: 200)
        formulaIntOnly.text = """
        Simple Interest Loan = P x I x T
        P = the loan amound
        I = interest rate
        T = is the duration of the loan, using number of periods
        """
        formulaIntOnly.isUserInteractionEnabled = false
        formulaIntOnly.font = UIFont(name: "PingFangSC-Semibold",size: 20)
        formulaIntOnly.isEditable = true
        formulaIntOnly.backgroundColor = .clear
        formulaIntOnly.textColor = UIColor.white
        self.ContentView.addSubview(formulaIntOnly)
    }
    func AmortizedLoan(){
        RemoveEverything()
        self.ContentView.addSubview(definition)
        //Adding Simp Int Definition
        definitionAmortLoan.frame = CGRect(x: 35, y: 290, width: 325, height: 330)
        definitionAmortLoan.text = """
        An amortized loan is a type of loan with scheduled, periodic payments that are applied to both the loan's principal amount and the interest accrued. An amortized loan payment first pays off the relevant interest expense for the period, after which the remainder of the payment is put toward reducing the principal amount. Common amortized loans include auto loans, home loans, and personal loans from a bank for small projects or debt consolidation.
        """
        definitionAmortLoan.isUserInteractionEnabled = false
        definitionAmortLoan.font = UIFont(name: "PingFangSC-Semibold",size: 17.5)
        definitionAmortLoan.isEditable = true
        definitionAmortLoan.backgroundColor = .clear
        definitionAmortLoan.textColor = UIColor.white
        self.ContentView.addSubview(definitionAmortLoan)
        //Adding Simp Int Formula
        self.ContentView.addSubview(formula)
        formulaAmortLoan.frame = CGRect(x: 35, y: 650, width: 325, height: 200)
        formulaAmortLoan.text = """
        A = P * ((r(1+r)^n)/(((1+r)^n) - 1))
        A = Payment Amount per period
        P = initial principal (loan amount)
        r = interest rate per period
        n = total number of payments or periods
        """
        formulaAmortLoan.isUserInteractionEnabled = false
        formulaAmortLoan.font = UIFont(name: "PingFangSC-Semibold",size: 20)
        formulaAmortLoan.isEditable = true
        formulaAmortLoan.backgroundColor = .clear
        formulaAmortLoan.textColor = UIColor.white
        self.ContentView.addSubview(formulaAmortLoan)
    }
    func LumpSumAnnuity(){
        RemoveEverything()
        self.ContentView.addSubview(definition)
        //Adding Simp Int Definition
        definitionLumpSum.frame = CGRect(x: 35, y: 290, width: 325, height: 330)
        definitionLumpSum.text = """
        A lump-sum payment is an often large sum that is paid in one single payment instead of broken up into installments. It is also known as a bullet repayment when dealing with a loan. They are sometimes associated with pension plans and other retirement vehicles, such as 401k accounts, where retirees accept a smaller upfront lump-sum payment rather than a larger sum paid out over time. These are often paid out in the event of debentures.
        """
        definitionLumpSum.isUserInteractionEnabled = false
        definitionLumpSum.font = UIFont(name: "PingFangSC-Semibold",size: 17.5)
        definitionLumpSum.isEditable = true
        definitionLumpSum.backgroundColor = .clear
        definitionLumpSum.textColor = UIColor.white
        self.ContentView.addSubview(definitionLumpSum)
        //Adding Simp Int Formula
        self.ContentView.addSubview(formula)
        formulaLumpSum.frame = CGRect(x: 35, y: 650, width: 325, height: 500)
        formulaLumpSum.text = """
        Future Value:
        FV  =  PV x (1 + i)^n
        
        Present Value:
        PV  =  FV / (1 + i)^n
        
        Compounding Discount Rate:
        i  =  n√(FV / PV) – 1

        Number of Periods:
        N  =  LN(FV / PV) / LN(1 + i)
        """
        formulaLumpSum.isUserInteractionEnabled = false
        formulaLumpSum.font = UIFont(name: "PingFangSC-Semibold",size: 20)
        formulaLumpSum.isEditable = true
        formulaLumpSum.backgroundColor = .clear
        formulaLumpSum.textColor = UIColor.white
        self.ContentView.addSubview(formulaLumpSum)
    }
    func OrdinaryAnnuity(){
        RemoveEverything()
        self.ContentView.addSubview(definition)
        //Adding Simp Int Definition
        definitionOrdinary.frame = CGRect(x: 35, y: 290, width: 325, height: 330)
        definitionOrdinary.text = """
        An ordinary annuity is a series of equal payments made at the end of consecutive periods over a fixed length of time. While the payments in an ordinary annuity can be made as frequently as every week, in practice they are generally made monthly, quarterly, semi-annually, or annually.
        """
        definitionOrdinary.isUserInteractionEnabled = false
        definitionOrdinary.font = UIFont(name: "PingFangSC-Semibold",size: 17.5)
        definitionOrdinary.isEditable = true
        definitionOrdinary.backgroundColor = .clear
        definitionOrdinary.textColor = UIColor.white
        self.ContentView.addSubview(definitionOrdinary)
        //Adding Simp Int Formula
        self.ContentView.addSubview(formula)
        formulaOrdinary.frame = CGRect(x: 35, y: 650, width: 325, height: 700)
        formulaOrdinary.text = """
        Future Value:
        FV = Pmt * [((1+i)^N − 1) / i ]
        
        Present Value:
        PV = Pmt * [1 − (1/(1+i)^N) / i ]
        
        Periodic Payment when FV is known:
        Pmt = FV / [((1+i)^N − 1) / i]

        Periodic Payment when PV is known:
        Pmt = PV / [1 − (1/(1+i)^N) / i]

        Number of Periods when FV is known:
        N = (ln(1 + FV*i/Pmt)) / (ln(1+i))

        Number of Periods when PV is known:
        N = (−ln(1 − PV*i/Pmt)) / (ln(1+i))
        """
        formulaOrdinary.isUserInteractionEnabled = false
        formulaOrdinary.font = UIFont(name: "PingFangSC-Semibold",size: 20)
        formulaOrdinary.isEditable = true
        formulaOrdinary.backgroundColor = .clear
        formulaOrdinary.textColor = UIColor.white
        self.ContentView.addSubview(formulaOrdinary)
    }
    func AnnuityDue(){
        RemoveEverything()
        self.ContentView.addSubview(definition)
        //Adding Simp Int Definition
        definitionDue.frame = CGRect(x: 35, y: 290, width: 325, height: 330)
        definitionDue.text = """
        Annuity due is an annuity whose payment is due immediately at the beginning of each period. Annuity due can be contrasted with an ordinary annuity where payments are made at the end of each period. A common example of an annuity due payment is rent paid at the beginning of each month.
        """
        definitionDue.isUserInteractionEnabled = false
        definitionDue.font = UIFont(name: "PingFangSC-Semibold",size: 17.5)
        definitionDue.isEditable = true
        definitionDue.backgroundColor = .clear
        definitionDue.textColor = UIColor.white
        self.ContentView.addSubview(definitionDue)
        //Adding Simp Int Formula
        self.ContentView.addSubview(formula)
        formulaDue.frame = CGRect(x: 35, y: 650, width: 325, height: 700)
        formulaDue.text = """
        Future Value:
        FV = Pmt * [((1+i)^N − 1) / i ] * (1+i)
        Present Value:
        PV = Pmt * [1 − (1/(1+i)^(N-1)) / i ] + Pmt
        Periodic Payment when FV is known:
        Pmt = FV / ( [((1+i)^N − 1) / i] * (1+i) )
        Periodic Payment when PV is known:
        Pmt = PV / [(1 − (1/(1+i)^(N-1)) / i) + 1]
        Number of Periods when FV is known:
        N = ln(1 + FV*i/Pmt(1+i)) / ln(1+i)
        Number of Periods when PV is known:
        N = (−ln(1+i(1−(PV/Pmt)))/ln(1+i)) + 1
        """
        formulaDue.isUserInteractionEnabled = false
        formulaDue.font = UIFont(name: "PingFangSC-Semibold",size: 20)
        formulaDue.isEditable = true
        formulaDue.backgroundColor = .clear
        formulaDue.textColor = UIColor.white
        self.ContentView.addSubview(formulaDue)
    }
    func RemoveEverything() {
        definition.removeFromSuperview()
        formula.removeFromSuperview()
        //Labels to be removed
        definitionSimpInt.removeFromSuperview()
        formulaSimpInt.removeFromSuperview()
        
        definitionCompInt.removeFromSuperview()
        formulaCompInt.removeFromSuperview()
        
        definitionintOnly.removeFromSuperview()
        formulaIntOnly.removeFromSuperview()
        
        definitionAmortLoan.removeFromSuperview()
        formulaAmortLoan.removeFromSuperview()
        
        definitionLumpSum.removeFromSuperview()
        formulaLumpSum.removeFromSuperview()
        
        definitionOrdinary.removeFromSuperview()
        formulaOrdinary.removeFromSuperview()
        
        definitionDue.removeFromSuperview()
        formulaDue.removeFromSuperview()
    }

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
            SimpleInterest()
            
        } else if selectedValue == "Compound Interest" {
            print("Compound Interest Selected")
            CompoundInterest()
            
        } else if selectedValue == "Interest-Only Loan" {
            print("Interest-Only Selected")
            InterestOnlyLoan()
            
        } else if selectedValue == "Amortized Loan" {
            print("Amortized Loan Selected")
            AmortizedLoan()
            
        } else if selectedValue == "Lump Sum Annuity" {
            print("Lump Sum Annuity Selected")
            LumpSumAnnuity()
            
        } else if selectedValue == "Ordinary Annuity" {
            print("Ordinary Annuity Selected")
            OrdinaryAnnuity()
            
        } else if selectedValue == "Annuity Due" {
            print("Annuity Due Selected")
            AnnuityDue()
            
        } else {
            print("Remove Everything")
            RemoveEverything()
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
