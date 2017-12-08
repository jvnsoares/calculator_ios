//
//  ViewController.swift
//  calculator
//
//  Created by Vitor Nunes on 08/12/17.
//  Copyright © 2017 Jose Soares. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var allButtons: Array<UIButton>!
    @IBOutlet weak var display: UILabel!
    
    var value1 : Double = 0
    var value2 : Double = 0
    var dot :Bool = false
    var show1:Bool = true
    var power : Int = 0
    var operatorButtonValue : Int = 0;
    var AC : Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBorders()
        display.text = String(value1)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dotFunct(_ sender: Any) {
        dot = true
        power = 1
    }
    
    @IBAction func numberButton(_ sender: AnyObject) {
        switch (dot,show1) {
        case (true,true) :
            var val : Double = Double(sender.tag)
            for _ in 1...power{
                val /= 10
            }
            value1 = value1 + val
            power += 1
            display.text = String(value1)
        case (true,false) :
            var val : Double = Double(sender.tag)
            for _ in 1...power{
                val /= 10
            }
            value2 = value2 + val
            power += 1
            display.text = String(value2)
        case (false,true) :
            value1 = value1 * 10 + Double(sender.tag)
            display.text = String(value1)
        case (false,false) :
            value2 = value2 * 10 + Double(sender.tag)
            display.text = String(value2)
        default:
            ()
        }
    }
    
    @IBAction func operatorButton(_ sender: AnyObject) {
        if AC {
            operatorButtonValue = sender.tag;
            show1 = false
            AC = false
        }else{
            equals()
            display.text = String(value1)
            operatorButtonValue = sender.tag;
            value2 = 0
            show1 = false
        }
    }
    
    
    @IBAction func equalsButton(_ sender: Any) {
        equals()
        show1 = true
        dot = false
        display.text = String(value1)
        
    }
    
    func equals() {
        print("value1:\(value1) \n value2: \(value2) \n operator: \(operatorButtonValue)")
        
        switch operatorButtonValue {
        case 1:
            value1 = value1 + value2
        case 2:
            value1 = value1 - value2
        case 3:
            value1 = value1 * value2
        case 4:
            value1 = value1 / value2
        default:
            ()
        }
        
        
    }
    
    @IBAction func aCButton(_ sender: Any) {
        value1 = 0
        value2  = 0
        dot = false
        show1 = true
        power = 0
        operatorButtonValue = 0;
        display.text = String(value1)
        AC = true
    }
    
    
    @IBAction func minusPlusButton(_ sender: Any) {
        if show1{
            value1 *= -1
            display.text = String(value1)
        }else{
            value2 *= -1
            display.text = String(value2)
        }
    }
    
    
    @IBAction func cButton(_ sender: Any) {
        
        switch (dot,show1) {
        case  (true,true):
            var temp =  String(value1)
            temp.remove(at: temp.index(before: temp.endIndex))
            if let unwrappedNum = Double(temp) {
                value1 = unwrappedNum
            } else {
                value1 = 0
            }
            display.text = String(value1)
            power -= 1
        case (true,false):
            var temp =  String(value2)
            temp.remove(at: temp.index(before: temp.endIndex))
            if let unwrappedNum = Double(temp) {
                value2 = unwrappedNum
            } else {
                value2 = 0
            }
            display.text = String(value2)
            power -= 1
        case (false,true):
            var temp =  String(Int(value1))
            temp.remove(at: temp.index(before: temp.endIndex))
            if let unwrappedNum = Double(temp) {
                value1 = unwrappedNum
            } else {
                value1 = 0
            }
            display.text = String(value1)
        case(false,false):
            var temp =  String(Int(value2))
            temp.remove(at: temp.index(before: temp.endIndex))
            if let unwrappedNum = Double(temp) {
                value2 = unwrappedNum
            } else {
                value2 = 0
            }
            display.text = String(value2)
        default:
            ()
        }
        if power == 1 {
            dot = false
        }
    }

    func createBorders(){
        for b in allButtons{
            b.layer.borderWidth = 1
            b.layer.borderColor = UIColor.darkGray.cgColor;
        }
        
    }
    
}

