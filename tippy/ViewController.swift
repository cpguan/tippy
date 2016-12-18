//
//  ViewController.swift
//  tippy
//
//  Created by Pan Guan on 12/12/16.
//  Copyright (c) 2016 Pan Guan. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var shareLable: UILabel!
    @IBOutlet weak var sharePeople: UISlider!
    @IBOutlet weak var shareNumber: UILabel!
    @IBOutlet weak var ViewTip: UIView!
    @IBOutlet weak var viewAmount: UIView!
    @IBOutlet var viewMain: UIView!
    @IBOutlet weak var plugSign: UILabel!
    @IBOutlet weak var equalSign: UILabel!
    
    
    let defaults = UserDefaults.standard
    let Nfmt = NumberFormatter()
    var Symbol = " "
    var tip : Double = 0
    var total : Double = 0
    var shareAmount : Double = 0
    
    let lightTextColor = UIColor(red: 0/255, green: 0/255, blue: 225/255, alpha: 1.0)
    let lightHeaderColor = UIColor(red: 237/255, green: 243/255, blue: 250/255, alpha: 1.0)
    let lightFooterColor = UIColor(red: 60/255, green: 190/255, blue: 255/255, alpha: 1.0)
    
    let darkTextColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    let darkHeaderColor = UIColor(red: 84/255, green: 84/255, blue: 139/255, alpha: 1.0)
    let darkFooterColor = UIColor(red: 0/255, green: 0/255, blue: 75/255, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billField.keyboardType = UIKeyboardType.decimalPad
        
        Nfmt.numberStyle = .currency
        Nfmt.groupingSeparator = ","
        
        Symbol = Nfmt.currencySymbol
        billField.text = Symbol
        
        ViewTip.alpha = 0
        tipControl.alpha = 0
        
        self.view.isUserInteractionEnabled = true
        
        let tipVal = defaults.integer(forKey: "tips")
        
        tipControl.setTitle("15%", forSegmentAt: 0)
        tipControl.setTitle("20%", forSegmentAt: 1)
        tipControl.setTitle("25%", forSegmentAt: 2)
        tipControl.setTitle( String(tipVal)+"%", forSegmentAt: 3)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("view will appear")
        setTheme()
        let tipVal = defaults.integer(forKey: "tips")
        tipControl.setTitle( String(tipVal)+"%", forSegmentAt: 3)
        calTip()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Symbol = Nfmt.currencySymbol
        if billField.text == Symbol {
            billField.becomeFirstResponder()
        }
        //print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //print("view did disappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
        
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        
        if (Symbol.range(of: billField.text!) != nil ) || billField.text == "" {
                billField.text = Symbol
                self.ViewTip.alpha = 0
                self.tipControl.alpha = 0
            } else {
                let billAmount : String? = billField.text
                if billAmount!.range(of: Symbol) != nil{
                    billField.text = billAmount?.replacingOccurrences(of: Symbol, with: "")
                    
                    UIView.animate(withDuration:0.5, animations: {
                        
                        //ViewTip.isHidden = false
                        //tipControl.isHidden = false
                        self.ViewTip.alpha = 1
                        self.tipControl.alpha = 1
                    })
                }
            }
        
        calTip()
    }
    
    func calTip(){
        
        let tipint = defaults.integer(forKey: "tips")
        let tipchange = Double(tipint) * 0.01
        
        let tipPercentage = [0.15, 0.2, 0.25, tipchange]
        
        let bill = NumberFormatter().number(from: billField.text!)?.doubleValue ?? 0
        
        let tip = bill * tipPercentage[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
    
        let numpeople = Int(sharePeople.value)
        let shareAmount = total/Double(numpeople)
        
        shareNumber.text = String(numpeople)
        
        // tipLabel.text = String(format: "$%.2f", tip)
        let tipVal = tip as NSNumber
        tipLabel.text = Nfmt.string(from: tipVal)
        
        //totalLabel.text = String(format: "$%.2f", total)
        let totalVal = total as NSNumber
        totalLabel.text = Nfmt.string(from: totalVal)
        
        //shareLable.text = String(format: "$%.2f", shareAmount)
        let shareAmountVal = shareAmount as NSNumber
        shareLable.text = Nfmt.string(from: shareAmountVal)
    }
    
    func setTheme(){
        var theme = defaults.object(forKey: "theme") as! String!
        if theme == nil {
            theme = "light"
        }
        if theme == "light"
        {
            ViewTip.backgroundColor = lightFooterColor
            viewAmount.backgroundColor = lightHeaderColor
            viewMain.backgroundColor = lightHeaderColor
            totalLabel.textColor = lightTextColor
            tipLabel.textColor = lightTextColor
            shareNumber.textColor = lightTextColor
            plugSign.textColor = lightTextColor
            equalSign.textColor = lightTextColor
            shareLable.textColor = lightTextColor
            tipControl.tintColor = lightTextColor
            billField.textColor = lightTextColor
        } else {
            ViewTip.backgroundColor = darkFooterColor
            viewAmount.backgroundColor = darkHeaderColor
            viewMain.backgroundColor = darkHeaderColor
            totalLabel.textColor = darkTextColor
            tipLabel.textColor = darkTextColor
            shareNumber.textColor = darkTextColor
            plugSign.textColor = darkTextColor
            equalSign.textColor = darkTextColor
            shareLable.textColor = darkTextColor
            tipControl.tintColor = darkTextColor
            billField.textColor = darkTextColor
        }
    }
    
}

