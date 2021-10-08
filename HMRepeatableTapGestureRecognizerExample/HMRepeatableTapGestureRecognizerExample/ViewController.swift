//
//  ViewController.swift
//  HMRepeatableTapGestureRecognizerExample
//
//  Created by Hiroaki Muronaka on 2021/10/08.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var minimumDurationTextField: UITextField!
    
    private var minimumDuration: TimeInterval {
        return TimeInterval(Double(minimumDurationTextField.text!)!)
    }
    
    @IBOutlet weak var repeatTextField: UITextField!
    
    private var repeatInterval: TimeInterval {
        return TimeInterval(Double(repeatTextField.text!)!)
    }
    
    private var gesture: HMRepeatableTapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGesture()
    }
    
    @IBAction func tappedConfirm(_ sender: Any) {
        self.setupGesture()
    }
    
    private func setupGesture() {
        if let gesture = gesture {
            self.plusButton.removeGestureRecognizer(gesture)
        }
        
        
        gesture = HMRepeatableTapGestureRecognizer(minimumPressDuration: minimumDuration, repeatInterval: repeatInterval, numberOfTouchRequired: 1, action: { gesture in
            NSLog("@@@ state: \(gesture.state.rawValue)")
            self.count()
        })
        self.plusButton.addGestureRecognizer(gesture!)
    }
    
    private func count() {
        guard let text = counterLabel.text, let num = Int(text) else {
            return
        }
        self.counterLabel.text = "\(num + 1)"
    }
    
}

