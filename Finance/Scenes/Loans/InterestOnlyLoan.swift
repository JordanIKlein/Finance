//
//  InterestOnlyLoan.swift
//  Finance
//
//  Created by Jordan Klein on 11/30/20.
//
import Foundation
import UIKit
import GoogleMobileAds
//Labels
let IOloanTotalInt = UILabel()
let IOloanTotalAmt = UILabel()

// loan text boxes
let IOLpritxtbox = UITextField()
let IOLratetxtbox = UITextField()
let IOLtimetxtbox = UITextField()
// calculation
let IOcalc = UIButton()


class InterestOnlyLoan: UIViewController, UITextFieldDelegate, GADRewardedAdDelegate {
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        print("Reward :)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        gadRewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-4042774315695176/1995708416")
        gadRewardedAd?.load(GADRequest()) { error in
            if let error = error {
              // Handle ad failed to load case.
                print("error, failed to load ad")
            } else {
              // Ad successfully loaded.
                print("Ad loaded")
            }
          }
        runningNotifications()
        addingBackgroundShapes() // adding black background and top shape
        gestures()
        createLabel() // Header and Back Button
        labels() //Labels
        textBoxes() // Creating the textboxes
        calculateButton() // Creating the calculate button
        
        IOLpritxtbox.delegate = self
        IOLratetxtbox.delegate = self
        IOLtimetxtbox.delegate = self
    }
    
    
    @IBOutlet weak var ContentView: UIView!
    
    func createLabel(){
        //Creating Label
        let questionLbl = UILabel()
        questionLbl.frame = CGRect(x: 35, y: 70, width: 250, height: 40)
        questionLbl.text = "Interest-Only Loan."
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
    
    
    //Function for adding Labels
    func labels(){
        //Principal Label
        let principalLbl = UILabel()
        principalLbl.frame = CGRect(x: 35, y: 200, width: 300, height: 40)
        principalLbl.text = "Loan Amount"
        principalLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        principalLbl.textColor = UIColor.white
        principalLbl.layer.zPosition = 2
        self.ContentView.addSubview(principalLbl)
        //Rate Label
        let rateLbl = UILabel()
        rateLbl.frame = CGRect(x: 35, y: 280, width: 300, height: 40)
        rateLbl.text = "Rate %"
        rateLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        rateLbl.textColor = UIColor.white
        rateLbl.layer.zPosition = 2
        self.ContentView.addSubview(rateLbl)
        //Time Label
        let timeLbl = UILabel()
        timeLbl.frame = CGRect(x: 35, y: 360, width: 300, height: 40)
        timeLbl.text = "Time (T)"
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
        
        IOLpritxtbox.frame = CGRect(x: 35, y: 240, width: 200, height: 40)
        IOLpritxtbox.borderStyle = UITextField.BorderStyle.bezel
        IOLpritxtbox.backgroundColor = UIColor.white
        IOLpritxtbox.textColor = UIColor.black
        IOLpritxtbox.keyboardType = .decimalPad
        IOLpritxtbox.inputAccessoryView = doneToolbar
        self.ContentView.addSubview(IOLpritxtbox)
        //Rate Amount
        
        IOLratetxtbox.frame = CGRect(x: 35, y: 320, width: 100, height: 40)
        IOLratetxtbox.borderStyle = UITextField.BorderStyle.bezel
        IOLratetxtbox.backgroundColor = UIColor.white
        IOLratetxtbox.textColor = UIColor.black
        IOLratetxtbox.keyboardType = .decimalPad
        IOLratetxtbox.inputAccessoryView = doneToolbar
        self.ContentView.addSubview(IOLratetxtbox)
        // time amount
        
        IOLtimetxtbox.frame = CGRect(x: 35, y: 400, width: 100, height: 40)
        IOLtimetxtbox.borderStyle = UITextField.BorderStyle.bezel
        IOLtimetxtbox.backgroundColor = UIColor.white
        IOLtimetxtbox.textColor = UIColor.black
        IOLtimetxtbox.keyboardType = .decimalPad
        IOLtimetxtbox.inputAccessoryView = doneToolbar
        self.ContentView.addSubview(IOLtimetxtbox)
    }
    
    @objc func firstRes(){
        Lpritxtbox.resignFirstResponder()
        Lratetxtbox.resignFirstResponder()
        Ltimetxtbox.resignFirstResponder()
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
    func calculateButton() {
        IOcalc.frame = CGRect(x: 150, y: 400, width: 175, height: 40)
        IOcalc.setTitle("Calculate", for: .normal)
        IOcalc.backgroundColor = UIColor(named: "SpecialGreen")
        IOcalc.layer.borderColor = UIColor.darkGray.cgColor
        IOcalc.layer.borderWidth = 1
        IOcalc.layer.cornerRadius = 5.0
        IOcalc.layer.zPosition = 2
        IOcalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        IOcalc.addTarget(self, action: #selector(calculation), for: .touchUpInside)
        self.ContentView.addSubview(IOcalc)
    }
    
    //Calculation objc
    
    @objc func calculation(){
        IOLpritxtbox.resignFirstResponder()
        IOLratetxtbox.resignFirstResponder()
        IOLtimetxtbox.resignFirstResponder()
        if IOLpritxtbox.hasText == false || IOLratetxtbox.hasText == false || IOLtimetxtbox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            NotificationCenter.default.post(name: .showVideoRewardAd, object: nil)
            reload()
            let a = Double(IOLpritxtbox.text!)!
            let r = (Double(IOLratetxtbox.text!)! / 100) //amortized so rate monthly
            let n = Double(IOLtimetxtbox.text!)! // in months
            
            let formula = a * r * n
            // Monthly Payment
            
            // Create Monthly Payment Label
            let totalmonthlyAMTLbl = UILabel()
            totalmonthlyAMTLbl.frame = CGRect(x: 35, y: 440, width: 300, height: 40)
            totalmonthlyAMTLbl.text = "Interest:"
            totalmonthlyAMTLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            totalmonthlyAMTLbl.textColor = UIColor.white
            totalmonthlyAMTLbl.layer.zPosition = 2
            self.ContentView.addSubview(totalmonthlyAMTLbl)

            // Returns Monthly Payment with Interest
            calcLbl.frame = CGRect(x: 35, y: 480, width: 300, height: 40)
            calcLbl.text = "\(currencyDefault)\(round(100.0 * (formula)) / 100.0)"
            calcLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            calcLbl.textColor = UIColor.white
            calcLbl.layer.zPosition = 2
            self.ContentView.addSubview(calcLbl)

            // Create Monthly Interest Amount Label
            let monthlyIntAMTLbl = UILabel()
            monthlyIntAMTLbl.frame = CGRect(x: 35, y: 520, width: 300, height: 40)
            monthlyIntAMTLbl.text = "Total Loan:"
            monthlyIntAMTLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            monthlyIntAMTLbl.textColor = UIColor.white
            monthlyIntAMTLbl.layer.zPosition = 2
            self.ContentView.addSubview(monthlyIntAMTLbl)

            // Returns Monthly Interest
            intlbl.frame = CGRect(x: 35, y: 560, width: 300, height: 40)
            intlbl.text = "\(currencyDefault)\(round(100.0 * (formula + a)) / 100.0)"
            intlbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
            intlbl.textColor = UIColor.white
            intlbl.layer.zPosition = 2
            self.ContentView.addSubview(intlbl)

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
