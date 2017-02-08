//
//  SentMemesCollectionViewController.swift
//  Meme 1.0
//
//  Created by fabriceberetta on 2/7/17.
//  Copyright © 2017 fabriceberetta. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    var sentMemes:[memeObject]! {
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView!.reloadData()
        print(sentMemes)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sentMemes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! SentMemesCollectionViewCell
        let collectionMeme=sentMemes[indexPath.row]
        cell.memeCollectionImageView?.image=collectionMeme.memedImage
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let detailMemeController=self.storyboard?.instantiateViewController(withIdentifier: "DetailMemeViewController") as! DetailMemeViewController
        
        detailMemeController.detailMeme=sentMemes[indexPath.row]

        self.navigationController!.pushViewController(detailMemeController, animated: true)
    }
}
