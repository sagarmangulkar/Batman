//
//  PlayViewController.swift
//  Batman_The_Beginning
//
//  Created by Mac on 4/27/17.
//  Copyright © 2017 Sagar. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {

    @IBOutlet var imageGifBatmanRunning: UIImageView!
    @IBOutlet var buttonJump: UIButton!
    @IBOutlet var imageBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageGifBatmanRunning.loadGif(name: "batman_run")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushButtonJump(_ sender: Any) {
        imageGifBatmanRunning.loadGif(name: "batman_jump")
    }

}
