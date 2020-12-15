//
//  Simple Interest.swift
//  Finance
//
//  Created by Jordan Klein on 11/21/20.
//

import Foundation
import UIKit
import GoogleMobileAds

// UIButton
let Simplecalc = UIButton() // for simple
// UITextfieldsSimple
let pritxtBox = UITextField()
let ratetxtBox = UITextField()
let timetxtBox = UITextField()
// Final result label Simple
let calcLbl = UILabel()
let intlbl = UILabel()

class SimpleInt: UIViewController, UITextFieldDelegate, GADRewardedAdDelegate {
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
        
        pritxtBox.delegate = self
        ratetxtBox.delegate = self
        timetxtBox.delegate = self
    }
    
    @IBOutlet weak var ContentView: UIView!
    
    func createLabel(){
        //Creating Label
        let questionLbl = UILabel()
        questionLbl.frame = CGRect(x: 35, y: 70, width: 250, height: 40)
        questionLbl.text = "Simple Interest."
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
        
        pritxtBox.frame = CGRect(x: 35, y: 240, width: 200, height: 40)
        pritxtBox.borderStyle = UITextField.BorderStyle.bezel
        pritxtBox.backgroundColor = UIColor.white
        pritxtBox.textColor = UIColor.black
        pritxtBox.keyboardType = .decimalPad
        pritxtBox.inputAccessoryView = doneToolbar
        self.ContentView.addSubview(pritxtBox)
        //Rate Amount
        
        ratetxtBox.frame = CGRect(x: 35, y: 320, width: 100, height: 40)
        ratetxtBox.borderStyle = UITextField.BorderStyle.bezel
        ratetxtBox.backgroundColor = UIColor.white
        ratetxtBox.textColor = UIColor.black
        ratetxtBox.keyboardType = .decimalPad
        ratetxtBox.inputAccessoryView = doneToolbar
        self.ContentView.addSubview(ratetxtBox)
        // time amount
        
        timetxtBox.frame = CGRect(x: 35, y: 400, width: 100, height: 40)
        timetxtBox.borderStyle = UITextField.BorderStyle.bezel
        timetxtBox.backgroundColor = UIColor.white
        timetxtBox.textColor = UIColor.black
        timetxtBox.keyboardType = .decimalPad
        timetxtBox.inputAccessoryView = doneToolbar
        self.ContentView.addSubview(timetxtBox)
    }
    
    @objc func firstRes(){
        pritxtBox.resignFirstResponder()
        ratetxtBox.resignFirstResponder()
        timetxtBox.resignFirstResponder()
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
        
        Simplecalc.frame = CGRect(x: 150, y: 400, width: 175, height: 40)
        Simplecalc.setTitle("Calculate", for: .normal)
        Simplecalc.backgroundColor = UIColor(named: "SpecialGreen")
        Simplecalc.layer.borderColor = UIColor.darkGray.cgColor
        Simplecalc.layer.borderWidth = 1
        Simplecalc.layer.cornerRadius = 5.0
        Simplecalc.layer.zPosition = 2
        Simplecalc.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 20)
        Simplecalc.addTarget(self, action: #selector(calculation), for: .touchUpInside)
        self.ContentView.addSubview(Simplecalc)
    }
    
    //Calculation objc
    @objc func calculation(){
        calcLbl.text = ""
        pritxtBox.resignFirstResponder()
        ratetxtBox.resignFirstResponder()
        timetxtBox.resignFirstResponder()
        print(pritxtBox)
        print(ratetxtBox)
        print(timetxtBox)
        if pritxtBox.hasText == false || ratetxtBox.hasText == false || timetxtBox.hasText == false {
            // Alert. you need to input all fields
            let alert = UIAlertController(title: "Missing Fields", message: "Remember to fill in all the fields!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
                NotificationCenter.default.post(name: .showVideoRewardAd, object: nil)
                reload()
                let principal = Double(pritxtBox.text!)!
                let rate = Double(ratetxtBox.text!)! / 100
                let time = Double(timetxtBox.text!)!
                let endCalc = principal * rate * time

                // Create Total Amount Label
                let totalAMTLbl = UILabel()
                totalAMTLbl.frame = CGRect(x: 35, y: 440, width: 300, height: 40)
                totalAMTLbl.text = "Interest:"
                totalAMTLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
                totalAMTLbl.textColor = UIColor.white
                totalAMTLbl.layer.zPosition = 2
                self.ContentView.addSubview(totalAMTLbl)

                // Returns Total Principal with Interest
                calcLbl.frame = CGRect(x: 35, y: 480, width: 300, height: 40)
                calcLbl.text = "\(currencyDefault)\(round(100.0 * (endCalc)) / 100.0)"
                calcLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
                calcLbl.textColor = UIColor.white
                calcLbl.layer.zPosition = 2
                self.ContentView.addSubview(calcLbl)

                // Create Total Interest Amount Label
                let totalIntAMTLbl = UILabel()
                totalIntAMTLbl.frame = CGRect(x: 35, y: 520, width: 300, height: 40)
                totalIntAMTLbl.text = "Total Amount:"
                totalIntAMTLbl.font = UIFont(name: "PingFangSC-Semibold", size: 25)
                totalIntAMTLbl.textColor = UIColor.white
                totalIntAMTLbl.layer.zPosition = 2
                self.ContentView.addSubview(totalIntAMTLbl)

                // Returns Total Interest
                intlbl.frame = CGRect(x: 35, y: 560, width: 300, height: 40)
                intlbl.text = "\(currencyDefault)\(round(100.0 * (endCalc+principal)) / 100.0)"
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
            
            
