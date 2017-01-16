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
        
        
        var newText = textField.text! as NSString
       
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        
        var stringNewText=newText as String
        
        /*

    
        let cash=Float(stringNewText)!
        let decimalCash=cash/100
        let myNumber = NSNumber(value: decimalCash)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        var cashFinal = formatter.string(from: myNumber)
        textField.text=cashFinal!
        */

        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }


}
