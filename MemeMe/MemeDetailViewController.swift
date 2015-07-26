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
    @IBOutlet weak var memedImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        memedImage.image = meme?.memedImage
    }
}
