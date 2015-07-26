//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Surasak Adulprasertsuk on 7/25/15.
//  Copyright (c) 2015 Surasak Adulprasertsuk. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme?
    var memes: [Meme]?
    var memeSelectedIndex: Int?
    let applicationDelegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
    
    @IBOutlet weak var memedImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editMeme:")
        let deleteButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "deleteMeme:")
        
        navigationItem.rightBarButtonItems = [deleteButton, editButton]
    }
    
    override func viewWillAppear(animated: Bool) {
        meme = applicationDelegate.memes[memeSelectedIndex!]
        if let memeSelectedIndex = self.memeSelectedIndex {
            meme = applicationDelegate.memes[memeSelectedIndex]
            memedImage.image = meme?.memedImage
        }
    }
    
    final func editMeme(sender: AnyObject) {
        let editMemeVC = storyboard?.instantiateViewControllerWithIdentifier("EditMeme") as! ViewController
        
        editMemeVC.meme = meme

        presentViewController(editMemeVC, animated: true, completion: {
            //dismiss detail view
            self.navigationController?.popViewControllerAnimated(false)
        })
    }
    
    final func deleteMeme(sender: AnyObject){
        if let memeSelectedIndex = self.memeSelectedIndex {
            applicationDelegate.memes.removeAtIndex(memeSelectedIndex)
            navigationController?.popViewControllerAnimated(true)
        }
    }
}
