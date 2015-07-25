//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Surasak Adulprasertsuk on 7/25/15.
//  Copyright (c) 2015 Surasak Adulprasertsuk. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]!
    let reuseIdentifier = "MemeCollectionItem"
    let applicationDelegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        //fetch latest data
        memes = applicationDelegate.memes
        
        //update cells
        collectionView?.reloadData()
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        if let memedImage = meme.memedImage {
            cell.memedImage.image = memedImage
        }
    
        return cell
    }
    
    //create new meme
    @IBAction func newMeme(sender: AnyObject) {
        let editVC = storyboard?.instantiateViewControllerWithIdentifier("EditMeme") as! UIViewController
        presentViewController(editVC, animated: true, completion: nil)
    }
}
