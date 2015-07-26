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
    let applicationDelegate = (UIApplication.sharedApplication().delegate) as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        //fetch latest data
        memes = applicationDelegate.memes
        
        //update cells
        tableView.reloadData()
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let memeDetailVC = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeDetailVC.memeSelectedIndex = indexPath.row
        navigationController?.pushViewController(memeDetailVC, animated: true)
    }
    
    //create new meme
    @IBAction func newMeme(sender: AnyObject) {
        let editVC = storyboard?.instantiateViewControllerWithIdentifier("EditMeme") as! UIViewController
        presentViewController(editVC, animated: true, completion: nil)
    }
}
