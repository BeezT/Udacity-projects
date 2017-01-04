//
//  cashDelegate.swift
//  ChallengeTextApp
//
//  Created by fabriceberetta on 12/28/16.
//  Copyright © 2016 fabriceberetta. All rights reserved.
//

import Foundation
import UIKit

class cashTextDelegate: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var money=""
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        var stringNewText=String(newText)
        
        let digits = CharacterSet.decimalDigits
        var totalNumber = ""
        for c in stringNewText.unicodeScalars{
            if digits.contains(UnicodeScalar(c.value)!) {
            totalNumber.append("\(c)")
            }
        }
        
        print(Int(totalNumber) as Any)
       
        if let numberOfpennies = Int(totalNumber) {
            money = "$"+"\(numberOfpennies)"
            print(money)
            
        }
        
        textField.text = totalNumber

        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            textField.text = "$0.00"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }


    
}
