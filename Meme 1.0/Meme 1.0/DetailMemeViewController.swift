//
//  DetailMemeViewController.swift
//  Meme 1.0
//
//  Created by fabriceberetta on 2/2/17.
//  Copyright © 2017 fabriceberetta. All rights reserved.
//

import Foundation
import UIKit

class DetailMemeViewController: UIViewController {
    
    var detailMeme:memeObject!
    
    @IBOutlet weak var detailMemeView: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.detailMemeView.image = detailMeme.memedImage
        print(detailMeme.topText)
    }
    
}
