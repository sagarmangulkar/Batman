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
    var isBatmanJumped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeroGif(tempImage: "batman_run")
        imageJocker.loadGif(name: "joker_running")
        imageWhiteStrip.frame.origin.x = 700
        initializeTimers()
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushButtonJump(_ sender: Any) {
        print("Jump...!")
        jump()
    }
    
    func initializeTimers(){
        timerRun = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(run), userInfo: nil, repeats: false)
        
        var timerPlatform = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(movePlatform), userInfo: nil, repeats: true)
        
        var timerCheckCollisionWithJoker = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkCollisionWithJoker), userInfo: nil, repeats: true)
        
        var timerMoveJoker = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(moveJoker), userInfo: nil, repeats: true)
    }
    
    func startTimerRun(timeTemp: Double)-> Void {
        guard timerRun == nil else { return }
        timerRun = Timer.scheduledTimer(timeInterval: timeTemp, target: self, selector: #selector(run), userInfo: nil, repeats: false)
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
    }
    
    func moveJoker(){
        UIView.animate(withDuration: 0.2, animations: {
            var frameTemp = self.imageJocker.frame
            frameTemp.origin.x = frameTemp.origin.x - 30
            self.imageJocker.frame = frameTemp
        },completion:{
            (finished: Bool) in
              if(self.imageJocker.frame.origin.x < -100){
            UIView.animate(withDuration: 0, animations: {
                var frameTemp = self.imageJocker.frame
                frameTemp.origin.x = 1300
                self.imageJocker.frame = frameTemp
            })
            }
        })
    }
    
    func run(){
        setHeroGif(tempImage: "batman_run")
        self.isBatmanJumped = false
    }
    
    func jump(){
        stopTimerRun()
        setHeroGif(tempImage: "batman_jump")
        self.isBatmanJumped = false
        UIView.animate(withDuration: 1, animations: {
            var frameTemp = self.imageBatman.frame
            frameTemp.origin.y = frameTemp.origin.y - 200
            self.imageBatman.frame = frameTemp
        },completion:{
            (finished: Bool) in
            self.isBatmanJumped = true
                UIView.animate(withDuration: 1, animations: {
                    var frameTemp = self.imageBatman.frame
                    frameTemp.origin.y = frameTemp.origin.y + 200
                    self.imageBatman.frame = frameTemp
                })
        })
        startTimerRun(timeTemp: 2)
    }
    
    func checkCollisionWithJoker(){
        print("-----------------")
        print(imageBatman.layer.frame.intersects(imageJocker.layer.frame))
        print(!isBatmanJumped)
        if(imageBatman.layer.frame.intersects(imageJocker.layer.frame) && !isBatmanJumped){
            lowerHealth()
            print("Collission with Joker")
        }
    }
    
    func lowerHealth(){
        stopTimerRun()
        imageBatman.loadGif(name: "batman_stand")
        startTimerRun(timeTemp: 0.1)
    }
}
