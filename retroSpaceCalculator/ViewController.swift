//
//  ViewController.swift
//  retroSpaceCalculator
//
//  Created by Reiss Zurbyk on 2016-08-11.
//  Copyright © 2016 Reiss Zurbyk. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }

    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        do {
        try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
                print(err.debugDescription)
            }
}

    @IBAction func numberPressed(_ btn: UIButton!) {
        btnSound.play()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(_ sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(_ sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(_ sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(_ sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(_ sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(_ op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //run some math
            //A user selected an operator, but then selected another operator without first entering a number
            if runningNumber != "" {
                
                rightValString = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                
                leftValString = result
                outputLbl.text = result
                }
            
            currentOperation = op
            
        } else {
            //first time an operator has been pressed.
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
    }
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
}
