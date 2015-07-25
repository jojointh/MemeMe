//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Surasak Adulprasertsuk on 7/25/15.
//  Copyright (c) 2015 Surasak Adulprasertsuk. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes: [Meme]!
    let reuseIdentifier = "MemeTableCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        let applicationDelegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
        memes = applicationDelegate.memes
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! UITableViewCell
        let meme = memes[indexPath.row]
        
        cell.textLabel?.text = meme.textTop! + "..." + meme.textBottom!
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    //create new meme
    @IBAction func newMeme(sender: AnyObject) {
        let editVC = storyboard?.instantiateViewControllerWithIdentifier("EditMeme") as! UIViewController
        presentViewController(editVC, animated: true, completion: nil)
    }
}
