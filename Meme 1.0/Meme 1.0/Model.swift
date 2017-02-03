//
//  Model.swift
//  Meme 1.0
//
//  Created by fabriceberetta on 1/12/17.
//  Copyright © 2017 fabriceberetta. All rights reserved.
//

import Foundation
import UIKit

// meme Struc object definition

struct memeObject {
    var topText:String
    var bottomText:String
    var selectedImage: UIImage
    var memedImage: UIImage
    
    //Initialization
    init(topText: String, bottomText:String, selectedImage: UIImage, memedImage:UIImage) {
        self.topText=topText
        self.bottomText=bottomText
        self.selectedImage=selectedImage
        self.memedImage=memedImage
    }
    
}

