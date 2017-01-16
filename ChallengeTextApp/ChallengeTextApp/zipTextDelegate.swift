//
//  zipDelegate.swift
//  ChallengeTextApp
//
//  Created by fabriceberetta on 12/28/16.
//  Copyright © 2016 fabriceberetta. All rights reserved.
//

import Foundation
import UIKit

class zipTextDelegate: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        
        return newText.length<=5
    }
}
