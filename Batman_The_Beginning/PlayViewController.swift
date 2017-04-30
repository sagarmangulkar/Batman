//
//  PlayViewController.swift
//  Batman_The_Beginning
//
//  Created by Mac on 4/27/17.
//  Copyright © 2017 Sagar. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {

    @IBOutlet var imageBatman: UIImageView!
    @IBOutlet var buttonJump: UIButton!
    @IBOutlet var imageBackground: UIImageView!
    @IBOutlet var imageRunningPlatform: UIImageView!
    @IBOutlet var imageWhiteStrip: UIImageView!
    @IBOutlet var imageJocker: UIImageView!
    
    var imageBatmanString = "batman_run"
    var batmanRunString = "batman_run"
    var batmanJumpString = "jump.gif"
    private var timerRun: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeroGif(tempImage: "batman_run")
        imageJocker.loadGif(name: "joker_running")
        timerRun = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(run), userInfo: nil, repeats: false)
        
        var timerPlatform = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(movePlatform), userInfo: nil, repeats: true)
        
        imageWhiteStrip.frame.origin.x = 700
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushButtonJump(_ sender: Any) {
        print("Jump...!")
        jump()
    }
    
    func startTimerRun() {
        guard timerRun == nil else { return }
        timerRun = Timer.scheduledTimer(timeInterval: 1.3, target: self, selector: #selector(run), userInfo: nil, repeats: false)

    }
    
    func stopTimerRun() {
        guard timerRun != nil else { return }
        timerRun?.invalidate()
        timerRun = nil
    }

    func setHeroGif(tempImage: String) -> Void{
        imageBatman.loadGif(name: tempImage)
        imageBatmanString = tempImage
    }
    
    func setHeroImage(tempImage: String) -> Void{
        imageBatman.image = UIImage(named:tempImage)
        imageBatmanString = tempImage
    }

    func movePlatform(){
        UIView.animate(withDuration: 5, animations: {
            var frameTemp = self.imageWhiteStrip.frame
            frameTemp.origin.x = -500
            self.imageWhiteStrip.frame = frameTemp
        },completion:{
            (finished: Bool) in
          //  if(self.imageWhiteStrip.frame.origin.x < -200){
                UIView.animate(withDuration: 0, animations: {
                    var frameTemp = self.imageWhiteStrip.frame
                    frameTemp.origin.x = 700
                    self.imageWhiteStrip.frame = frameTemp
                })
            //}
        })
        moveJoker()
    }
    
    func moveJoker(){
        UIView.animate(withDuration: 3, animations: {
            var frameTemp = self.imageJocker.frame
            frameTemp.origin.x = -100
            self.imageJocker.frame = frameTemp
        },completion:{
            (finished: Bool) in
            //  if(self.imageWhiteStrip.frame.origin.x < -200){
            UIView.animate(withDuration: 0, animations: {
                var frameTemp = self.imageJocker.frame
                frameTemp.origin.x = 700
                self.imageJocker.frame = frameTemp
            })
            //}
        })
    }
    
    func run(){
        setHeroGif(tempImage: "batman_run")
    }
    
    func jump(){
        stopTimerRun()
        setHeroGif(tempImage: "batman_jump")

        UIView.animate(withDuration: 0.65, animations: {
            var frameTemp = self.imageBatman.frame
            frameTemp.origin.y = frameTemp.origin.y - 100
            self.imageBatman.frame = frameTemp
        },completion:{
            (finished: Bool) in
                UIView.animate(withDuration: 0.65, animations: {
                    var frameTemp = self.imageBatman.frame
                    frameTemp.origin.y = frameTemp.origin.y + 100
                    self.imageBatman.frame = frameTemp
                })
        })
        
        startTimerRun()
    }
}
