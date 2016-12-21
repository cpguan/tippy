//
//  SettingsViewController.swift
//  tippy
//
//  Created by Pan Guan on 12/13/16.
//  Copyright © 2016 Pan Guan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var otherTipValSlide: UISlider!
    
    @IBOutlet weak var otherTipValLable: UILabel!
    
    @IBOutlet weak var changeTheme: UISwitch!
    
    @IBOutlet weak var setDefaultSeg: UISegmentedControl!
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        var theme = defaults.object(forKey:"theme") as! String!
        if theme == nil {
            theme = "light"
        }
        if theme == "light" {
            changeTheme.setOn(false, animated: true)
        } else {
            changeTheme.setOn(true, animated: true)
        }
        setDefaultSeg.selectedSegmentIndex = defaults.integer(forKey: "SegIndex")
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SetSeg(_ sender: UISegmentedControl) {
        let setSegIndex = setDefaultSeg.selectedSegmentIndex
        defaults.set(setSegIndex, forKey: "SegIndex")
        //defaults.synchronize()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        let defaults = UserDefaults.standard
        let tipVal = defaults.float(forKey: "tips")
        otherTipValSlide.value = tipVal*0.01
        otherTipValLable.text = String(format: "%.0f", tipVal)
        setDefaultSeg.selectedSegmentIndex = defaults.integer(forKey: "SegIndex")    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    
    @IBAction func settingTip(_ sender: Any) {
        
        let setTip = Int(otherTipValSlide.value * 100)
        
        otherTipValLable.text = String(setTip)
        
        
        defaults.set(setTip, forKey: "tips")
        defaults.synchronize()
    
    }
    
    @IBAction func DarkTheme(_ sender: UISwitch) {
        
        if changeTheme.isOn {
            defaults.set("dark", forKey: "theme")
        } else {
            defaults.set("light", forKey: "theme")
        }
            defaults.synchronize()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
