//
//  ViewController.swift
//  c1
//
//  Created by adminaccount on 8/21/15.
//  Copyright (c) 2015 pelekh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTypingNumber: Bool = false
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber{
            display.text = display.text! + digit
        } else{
            display.text=digit
            userIsInTheMiddleOfTypingNumber=true
        }
        
    }


    @IBAction func operate(sender: UIButton) {
//        let operation = sender.currentTitle!
//        if userIsInTheMiddleOfTypingNumber{
//            enter()
//        }
//        switch operation{
//        case "×": performOperation {$0 * $1}
//        case "+": performOperation {$0 + $1}
//        case "÷": performOperation {$1 / $0}
//        case "−": performOperation {$1 - $0}
//        case "√": performOperation {sqrt($0)}
//        default: break
//        }
        if userIsInTheMiddleOfTypingNumber{
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func cleaner(sender: UIButton) {
        displayValue = 0
        brain.cleanL()
    }
    
    @IBAction func deleteDigit(sender: UIButton) {
        if userIsInTheMiddleOfTypingNumber{
            var string1 = display.text!
            var index1 = advance(string1.endIndex, -1)
            var indDigit = distance(string1.startIndex, string1.endIndex)
            if indDigit>1{
                var substring1 = string1.substringToIndex(index1)
                display.text = substring1
            }
            if indDigit==1{
                displayValue = 0
                userIsInTheMiddleOfTypingNumber=false
            }
            
        }

    }
    
    
    func performOperation (operation: (Double, Double) ->Double){
        if operandStack.count>=2{
            displayValue=operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation (operation: Double ->Double){
        if operandStack.count>=2{
            displayValue=operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack: Array <Double> = Array <Double>()
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber=false
        
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        } else{
            displayValue = 0
        }
//        operandStack.append(displayValue)
//        println("operandStack=\(operandStack)")
    }
    var displayValue :Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text="\(newValue)"
            userIsInTheMiddleOfTypingNumber=false
        }
    }
    


}

/*override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}*/