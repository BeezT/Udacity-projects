//
//  ViewController.swift
//  ChallengeTextApp
//
//  Created by fabriceberetta on 12/28/16.
//  Copyright © 2016 fabriceberetta. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var zip:UITextField!
    @IBOutlet weak var cash:UITextField!
    @IBOutlet weak var lock:UITextField!
    @IBOutlet weak var lockSwitch: UISwitch!
    
    @IBAction func unLockText(){
        
    }
    //create instances of delegates
    let zipDelegate = zipTextDelegate()
    let cashDelegate = cashTextDelegate()
    let unlockDelegate = unlockTextDelegate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.zip.delegate=zipDelegate
        self.cash.delegate=cashDelegate
        self.lock.delegate=unlockDelegate
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.lockSwitch.isOn
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    
        return true
    }
}

