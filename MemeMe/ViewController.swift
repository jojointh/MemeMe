//
//  ViewController.swift
//  MemeMe
//
//  Created by Surasak Adulprasertsuk on 7/17/15.
//  Copyright (c) 2015 Surasak Adulprasertsuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextfield: UITextField!
    @IBOutlet weak var bottomTextfield: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var meme: Meme?
    var memedImage: UIImage?
    let applicationDelegate = (UIApplication.sharedApplication().delegate) as! AppDelegate
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : 3.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextfield.text = "TOP"
        bottomTextfield.text = "BOTTOM"
        topTextfield.defaultTextAttributes = memeTextAttributes
        bottomTextfield.defaultTextAttributes = memeTextAttributes
        topTextfield.textAlignment = NSTextAlignment.Center
        bottomTextfield.textAlignment = NSTextAlignment.Center
        topTextfield.delegate = self
        bottomTextfield.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        cancelButton.enabled = applicationDelegate.memes.count > 0
        
        //init edit meme
        if let meme = self.meme {
            println("meme data exist")
            topTextfield.text = meme.textTop
            bottomTextfield.text = meme.textBottom
            imagePickerView.image = meme.image
            shareButton.enabled = true
        }
        
        self.subscribeToKeyboardNotifications()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }

    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
        shareButton.enabled = true
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
        shareButton.enabled = true
    }
    
    @IBAction func shareMeme(sender: AnyObject) {
        memedImage = generateMemedImage()
        if let memedImage = self.memedImage {
            let activity = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
            activity.completionWithItemsHandler = save
            self.presentViewController(activity, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imagePickerView.image = image
            
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func save(activityType:String!, completed: Bool, returnedItems: [AnyObject]!, error: NSError!) {
        if completed {
            var meme = Meme(textTop: topTextfield.text!, textBottom: bottomTextfield.text!, image:imagePickerView.image, memedImage: memedImage)
            
            // Add meme to memes array in Application Deleate
            let object = UIApplication.sharedApplication().delegate
            applicationDelegate.memes.append(meme)
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func generateMemedImage() -> UIImage {
        toolbar.hidden = true
        navigationBar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolbar.hidden = false
        navigationBar.hidden = false
        
        return memedImage
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    //dismiss current view and return to previous view (if any)
    @IBAction func cancelEdit(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

