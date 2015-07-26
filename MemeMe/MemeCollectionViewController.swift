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
        
        cell.memedImage?.image = meme.memedImage
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let memeDetailVC = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeDetailVC.meme = memes[indexPath.row]
        navigationController?.pushViewController(memeDetailVC, animated: true)
    }
    
    //create new meme
    @IBAction func newMeme(sender: AnyObject) {
        let editVC = storyboard?.instantiateViewControllerWithIdentifier("EditMeme") as! UIViewController
        presentViewController(editVC, animated: true, completion: nil)
    }
}
