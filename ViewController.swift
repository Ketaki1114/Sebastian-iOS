//
//  ViewController.swift
//  Calculator
//
//  Created by Madison Heck on 3/9/17.
//  Copyright © 2017 SebastianScales. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    //keeps track of whether or not the user is typing
    var userTyping = false
    
    //display basic digits
    @IBAction func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userTyping{
            
            let displayText = display.text!
            
            display.text = displayText + digit
        }
        else {
            display.text = digit
            userTyping = true
        }
        
    }
    //clear button
    @IBAction func clearAll(sender: UIButton) {
        display.text = String(0)
        computationDisplay.text = String(0)
        if brain.resultIsPending == true {
            brain.resultIsPending = false
        }
        
    }
    
    //operations displayer
    @IBOutlet weak var computationDisplay: UILabel!
    
    //calculates operations display
    @IBAction func compute(sender: UIButton){
        if sender.currentTitle! == "=" {
             computationDisplay.text = computationDisplay.text! + " " + sender.currentTitle!
        }
        else if brain.resultIsPending == true {
            computationDisplay.text = brain.descript + " " + sender.currentTitle!
        }
        else {
                computationDisplay.text = brain.descript + " " + sender.currentTitle! + " " + "..."
        }
            
        
    }


    @IBAction func description(sender: UIButton) {
        var descript = ""
        if sender.currentTitle! != "=" {
                descript = descript + sender.currentTitle!
        }
        
    }
    
    //value displayed in top UI Label
    var displayValue: Double{
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    //reference to the model struct
    private var brain = CalculatorBrain()
    
    //accounts for all mathematical symbol calls
    @IBAction func piButton(sender: UIButton) {
            if userTyping{
                brain.setOperand(displayValue)
                userTyping = false
            }
            if let mathematicalSymbol = sender.currentTitle{
                brain.performOperation(mathematicalSymbol)
            }
            if let result = brain.result{
                displayValue = result
            }
    }
}



