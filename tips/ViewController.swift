//
//  ViewController.swift
//  tips
//
//  Created by Olga Azarova on 1/8/15.
//  Copyright (c) 2015 Olga Azarova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var splitSlider: UISlider!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var splitTotalLable: UILabel!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBAction func updateValues() {
        
        let tipPercentages = [10.0, 15.0, 20.0]
        let tipPercentage : Double = (tipControl.selectedSegmentIndex != UISegmentedControlNoSegment) ? tipPercentages[tipControl.selectedSegmentIndex] : NSUserDefaults.standardUserDefaults().doubleForKey("default_tip_pct")
        let billAmountStr:NSString = billField.text
        let billAmount = billAmountStr.doubleValue
        let tip = tipPercentage * billAmount / 100
        let total = billAmount + tip
        let splitTotal = total / Double(Int(splitSlider.value))

        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale() // This is the default

        tipLabel.text = formatter.stringFromNumber(tip)
        totalLabel.text = formatter.stringFromNumber(total)
        tipPercentLabel.text = "Tip (\(Int(tipPercentage))%)"
        splitTotalLable.text = formatter.stringFromNumber(splitTotal)
        splitNumberLabel.text = "\(Int(splitSlider.value))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text =  "0.00"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"doYourStuff", name:
            UIApplicationWillEnterForegroundNotification, object: nil)
        
        var defaults = NSUserDefaults.standardUserDefaults()
        if defaults.boolForKey("reset_necessary") {
            println("reset necessary inside viewDidLoad")
            billField.text = ""
            self.reloadInputViews()
            defaults.setBool(false, forKey: "reset_necessary")
            defaults.synchronize()
        }

    }
    
    func doYourStuff(){
        billField.text = ""
        updateValues()
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "reset_necessary")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tipControl.selectedSegmentIndex = UISegmentedControlNoSegment
        let stringValue = NSUserDefaults.standardUserDefaults().stringForKey("default_color_scheme")
        if (stringValue != nil) {
            if stringValue == "Light" {
                self.view.tintColor = UIColor.blueColor()
                self.view.backgroundColor = UIColor.yellowColor()
            }
            else if stringValue == "Dark" {
                self.view.tintColor = UIColor.blackColor()
                self.view.backgroundColor = UIColor.redColor()
            }
        }
        
        updateValues()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
       updateValues()
        
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func splitChanged(sender : AnyObject) {
        updateValues()
    }
}

