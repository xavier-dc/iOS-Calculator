//
//  ViewController.swift
//  Calculator
//
//  Created by Xavier on 2/15/23.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var CalculatorResults: UILabel!
    @IBOutlet weak var CalculatorWorkings: UILabel!
    
    var workings:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
    }
    
    func clearAll()
    {
        workings = ""
        CalculatorWorkings.text = ""
        CalculatorResults.text = ""
    }
    
    @IBAction func BackTap(_ sender: Any) {
        if (!workings.isEmpty){
            workings.removeLast()
            CalculatorWorkings.text = workings
        }
    }
    @IBAction func allClearTap(_ sender: Any) {
        clearAll()
    }
    
    func addToWorkings(value: String)
    {
        workings = workings + value
        CalculatorWorkings.text = workings
    }
    
    @IBAction func DecimalTap(_ sender: Any) {
        addToWorkings(value: ".")
    }
    
    @IBAction func nineTap(_ sender: Any) {
        addToWorkings(value: "9")
    }
    @IBAction func eightTap(_ sender: Any) {
        addToWorkings(value: "8")
    }
    @IBAction func sevenTap(_ sender: Any) {
        addToWorkings(value: "7")
    }
    @IBAction func sixTap(_ sender: Any) {
        addToWorkings(value: "6")
    }
    @IBAction func fiveTap(_ sender: Any) {
        addToWorkings(value: "5")
    }
    @IBAction func fourTap(_ sender: Any) {
        addToWorkings(value: "4")
    }
    @IBAction func threeTap(_ sender: Any) {
        addToWorkings(value: "3")
    }
    @IBAction func twoTap(_ sender: Any) {
        addToWorkings(value: "2")
    }
    @IBAction func AddTap(_ sender: Any) {
        addToWorkings(value: "+")
    }
    @IBAction func MinusTap(_ sender: Any) {
        addToWorkings(value: "-")
    }
    @IBAction func MultiplyTap(_ sender: Any) {
        addToWorkings(value: "*")
    }
    @IBAction func DivideTap(_ sender: Any) {
        addToWorkings(value: "/")
    }
    @IBAction func ZeroTap(_ sender: Any) {
        addToWorkings(value: "0")
    }
    @IBAction func oneTap(_ sender: Any) {
        addToWorkings(value: "1")
    }
    @IBAction func PercentageTap(_ sender: Any) {
        addToWorkings(value: "%")
    }
    @IBAction func EqualsTap(_ sender: Any) {
        //edge casing for percentages
        if (validInput())
        {
            let checkedWorkingsForPercent = workings.replacingOccurrences(of: "%", with: "*0.01")
            
            let expression = NSExpression(format: checkedWorkingsForPercent)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            CalculatorResults.text = resultString
        }
        else
        {
            let alert = UIAlertController(title: "Invalid Input", message: "Unable to complete math based on input", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func validInput() -> Bool
    {
        var count = 0
        var funcCharIndexes = [Int]()
        
        for char in workings
        {
            if (specialCharater(char: char)) {
                funcCharIndexes.append(count)
            }
            count += 1
        }
        
        var previous: Int = -1
        
        for index in funcCharIndexes{
            if(index == 0) {
                return false
            }
            
            if(index == workings.count - 1) {
                return false
            }
            
            if(previous != -1)
            {
                if((index - previous) == 1)
                {
                    return false
                }
            }
            previous = index
        }
            
            return true
        }
        
        func specialCharater(char: Character) -> Bool
        {
            switch(char)
            {
            case "*":
                return true
            case "/":
                return true
            case "+":
                return true
            default:
                return false
            }
        }
        
        func formatResult(result: Double) -> String
        {
            if(result.truncatingRemainder(dividingBy: 1) == 0)
            {
                return String(format: "%.0f", result)
            }
            else
            {
                return String(format: "%.2f", result)
            }
        }
    }
