//
//  Settings.swift
//  Finance
//
//  Created by Jordan Klein on 11/24/20.
//

import Foundation
import UIKit

var currencyDefault = UserDefaults.standard.string(forKey: "currency") ?? "$"

class Settings: UIViewController{
    let reviewService = ReviewService.shared
    
    let dollar = UIButton()
    let euro = UIButton()
    let yen = UIButton()
    let pound = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingBackgroundShapes() // adding black background and top shape
        gestures() // Recognizing Swipes
        createLabel() //Header
        labels() // Adding Labels
        buttons() // Adding buttons
        preferences() // User Default selected for currency
        review()
    }
    
    @IBOutlet weak var ContentView: UIView!
    
    func createLabel(){
        //Creating Label
        let questionLbl = UILabel()
        questionLbl.frame = CGRect(x: 35, y: 70, width: 200, height: 40)
        questionLbl.text = "Settings."
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
    func preferences(){
        if currencyDefault == "$" {
            //Let button be Green?
            dollar.backgroundColor = UIColor(named: "SpecialGreen")
            euro.backgroundColor = UIColor.red
            yen.backgroundColor = UIColor.red
            pound.backgroundColor = UIColor.red
        } else if currencyDefault == "€" {
            dollar.backgroundColor = UIColor.red
            euro.backgroundColor = UIColor(named: "SpecialGreen")
            yen.backgroundColor = UIColor.red
            pound.backgroundColor = UIColor.red
        } else if currencyDefault == "¥" {
            dollar.backgroundColor = UIColor.red
            euro.backgroundColor = UIColor.red
            yen.backgroundColor = UIColor(named: "SpecialGreen")
            pound.backgroundColor = UIColor.red
        } else if currencyDefault == "£" {
            dollar.backgroundColor = UIColor.red
            euro.backgroundColor = UIColor.red
            yen.backgroundColor = UIColor.red
            pound.backgroundColor = UIColor(named: "SpecialGreen")
        } else {
            // Dollar is highlighted
            dollar.backgroundColor = UIColor(named: "SpecialGreen")
            euro.backgroundColor = UIColor.red
            yen.backgroundColor = UIColor.red
            pound.backgroundColor = UIColor.red
        }
    }
    func review(){
        let deadline = DispatchTime.now() + .seconds(5)
        DispatchQueue.main.asyncAfter(deadline: deadline) {[weak self] in self?.reviewService.requestReview()
        }
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
    
    func labels(){
        let Currency = UILabel()
        Currency.frame = CGRect(x: view.frame.size.width/2 - 75, y: 160, width: 150, height: 40)
        Currency.text = "Currency:"
        Currency.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        Currency.textColor = UIColor.white
        Currency.layer.zPosition = 2
        Currency.textAlignment = .center
        self.ContentView.addSubview(Currency)
        
        let legal = UIButton()
        legal.frame = CGRect(x: view.frame.size.width/2 - 75, y: 475, width: 155, height: 40)
        legal.setTitle("Legal", for: .normal)
        legal.backgroundColor = UIColor(named: "SpecialGreen")
        legal.layer.borderColor = UIColor.darkGray.cgColor
        legal.layer.borderWidth = 1
        legal.layer.cornerRadius = 5.0
        legal.layer.zPosition = 2
        legal.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 25)
        legal.addTarget(self, action: #selector(legalPush), for: .touchUpInside)
        self.ContentView.addSubview(legal)
    }
    @objc func legalPush(){
        // Sends user out of app to my legal information
        if let url = URL(string: "http://jordaniklein.com/index.php/privacy-policy/") {
            UIApplication.shared.open(url)
        }
    }
    @objc func dollarSet(_ sender: UIButton){
        sender.shake()
        //Change Default here
        currencyDefault = "$"
        UserDefaults.standard.setValue("$", forKey: "currency")
        preferences()
    }
    @objc func euroSet(_ sender: UIButton){
        //Change Default here
        sender.shake()
        currencyDefault = "€"
        UserDefaults.standard.setValue("€", forKey: "currency")
        preferences()
    }
    @objc func yenSet(_ sender: UIButton){
        sender.shake()
        //Change Default here
        currencyDefault = "¥"
        UserDefaults.standard.setValue("¥", forKey: "currency")
        preferences()
    }
    @objc func poundSet(_ sender: UIButton){
        sender.shake()
        //Change Default here
        currencyDefault = "£"
        UserDefaults.standard.setValue("£", forKey: "currency")
        preferences()
    }
    func buttons(){ // adding buttons for currency
        
        dollar.frame = CGRect(x: view.frame.size.width/3 - 50, y: 210, width: 100, height: 100)
        dollar.setTitle("$", for: .normal)
        dollar.layer.cornerRadius = 0.5 * dollar.bounds.size.width
        dollar.layer.borderWidth = 1
        dollar.layer.zPosition = 2
        dollar.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 30)
        dollar.addTarget(self, action: #selector(dollarSet), for: .touchUpInside)
        self.ContentView.addSubview(dollar)

        euro.frame = CGRect(x: (view.frame.size.width * 0.66) - 50, y: 210, width: 100, height: 100)
        euro.setTitle("€", for: .normal)
        euro.layer.borderColor = UIColor.darkGray.cgColor
        euro.layer.borderWidth = 1
        euro.layer.cornerRadius = 0.5 * euro.bounds.size.width
        euro.layer.zPosition = 2
        euro.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 30)
        euro.addTarget(self, action: #selector(euroSet), for: .touchUpInside)
        self.ContentView.addSubview(euro)
        
        yen.frame = CGRect(x: view.frame.size.width/3 - 50, y: 330, width: 100, height: 100)
        yen.setTitle("¥", for: .normal)
        yen.layer.borderColor = UIColor.darkGray.cgColor
        yen.layer.borderWidth = 1
        yen.layer.cornerRadius = 0.5 * yen.bounds.size.width
        yen.layer.zPosition = 2
        yen.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 30)
        yen.addTarget(self, action: #selector(yenSet), for: .touchUpInside)
        self.ContentView.addSubview(yen)
        
        pound.frame = CGRect(x: (view.frame.size.width * 0.66) - 50, y: 330, width: 100, height: 100)
        pound.setTitle("£", for: .normal)
        pound.layer.borderColor = UIColor.darkGray.cgColor
        pound.layer.borderWidth = 1
        pound.layer.cornerRadius = 0.5 * pound.bounds.size.width
        pound.layer.zPosition = 2
        pound.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 30)
        pound.addTarget(self, action: #selector(poundSet), for: .touchUpInside)
        self.ContentView.addSubview(pound)
        
        // Line to seperate Currency and Other
        let lineView = UIView(frame: CGRect(x: 0, y: 450, width: view.frame.size.width, height: 2.0))
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = UIColor(named: "SpecialGreen")?.cgColor
        self.ContentView.addSubview(lineView)
    }
}

