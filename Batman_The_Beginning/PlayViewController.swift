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
    override func viewDidLoad() {
        super.viewDidLoad()
        imageGifBatmanRunning.loadGif(name: "batman_run")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
