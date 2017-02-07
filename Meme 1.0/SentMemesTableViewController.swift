//
//  SentMemesTableViewController.swift
//  Meme 1.0
//
//  Created by fabriceberetta on 2/2/17.
//  Copyright © 2017 fabriceberetta. All rights reserved.
//

import Foundation
import UIKit
import NotificationCenter

class SentMemesTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var memeTableView: UITableView!

    var sentMemes:[memeObject]! {
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController!.tabBar.isHidden=false
    
        self.memeTableView.reloadData()

    }
    
    //set up navigation button and call the shared model from App delegate
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "start new meme", style: .plain, target: self, action: #selector(addNewMeme))
        
    }
    
    //Navigate to meme editor view controller
    func addNewMeme(){
        if let navigationController=navigationController {
            let memeEditViewController=self.storyboard!.instantiateViewController(withIdentifier: "MemeEditViewController")
            navigationController.pushViewController(memeEditViewController, animated: true)
        }
    }

    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sentMemes.count
    }
    
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let tableMeme=self.sentMemes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell")!
        cell.imageView?.image=tableMeme.memedImage
        cell.textLabel?.text=tableMeme.topText
        return cell
    }
    

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(indexPath.row)

        let DetailMemeController=self.storyboard!.instantiateViewController(withIdentifier: "DetailMemeViewController") as! DetailMemeViewController
        DetailMemeController.detailMemes=sentMemes[indexPath.row]
        print(sentMemes[indexPath.row])
       
 
        self.navigationController!.pushViewController(DetailMemeController, animated: true)
    }
    
}
