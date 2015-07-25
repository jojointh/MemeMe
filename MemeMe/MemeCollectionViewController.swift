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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let applicationDelegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
        memes = applicationDelegate.memes
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 0
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
    
        // Configure the cell
    
        return cell
    }
    
    //create new meme
    @IBAction func newMeme(sender: AnyObject) {
        let editVC = storyboard?.instantiateViewControllerWithIdentifier("EditMeme") as! UIViewController
        presentViewController(editVC, animated: true, completion: nil)
    }
}
