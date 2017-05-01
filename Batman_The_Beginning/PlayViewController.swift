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
    @IBOutlet var imageBlood: UIImageView!
    @IBOutlet var imageHealthBarBatman: UIImageView!
    @IBOutlet var imageGameOver: UIImageView!
    @IBOutlet var imageEndingScene: UIImageView!
    @IBOutlet var buttonPlayAgain: UIButton!
    @IBOutlet var imageWeaponBatman: UIImageView!
    @IBOutlet var buttonAttack: UIButton!
    
    var imageBatmanString = "batman_run"
    var batmanRunString = "batman_run"
    var batmanJumpString = "jump.gif"
    private var timerRun: Timer?
    private var timerGameOver: Timer?
    private var timerAttack: Timer?
    var isBatmanJumped = false
    var isBatmanHidden = false
    var healthBatman = 100
    var isAttacked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTimers()
        startingState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func startingState(){
        imageGameOver.isHidden = true
        setHeroGif(tempImage: "batman_run")
        imageJocker.loadGif(name: "joker_running")
        imageWhiteStrip.frame.origin.x = 0
        imageJocker.frame.origin.x = 1500
        imageBackground.loadGif(name: "moving_background2")
        imageBlood.isHidden = true
        buttonPlayAgain.isHidden = true
        imageWeaponBatman.isHidden = true
        buttonAttack.isHidden = false
    }
    
    @IBAction func pushButtonJump(_ sender: Any) {
        print("Jump...!")
        jump()
    }
    
    @IBAction func pushButtonAttack(_ sender: Any) {
        print("Batman attacked Joker...!")
        startTimerAttack(timeTemp: 0.1)
        imageWeaponBatman.isHidden = false
    }
    
    func initializeTimers(){
        timerRun = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(run), userInfo: nil, repeats: false)
        
        var timerPlatform = Timer.scheduledTimer(timeInterval: 9, target: self, selector: #selector(movePlatform), userInfo: nil, repeats: true)
        
        var timerCheckCollisionWithJoker = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkCollisionWithJoker), userInfo: nil, repeats: true)
       
        var timerCheckCollisionForAttackOnJoker = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkCollisionForAttackOnJoker), userInfo: nil, repeats: true)
        
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
    
    func startTimerGameOver(timeTemp: Double)-> Void {
        guard timerGameOver == nil else { return }
        timerGameOver = Timer.scheduledTimer(timeInterval: timeTemp, target: self, selector: #selector(gameOver), userInfo: nil, repeats: false)
    }
    
    func startTimerAttack(timeTemp: Double)-> Void {
        guard timerAttack == nil else { return }
        timerAttack = Timer.scheduledTimer(timeInterval: timeTemp, target: self, selector: #selector(attack), userInfo: nil, repeats: true)
        //imageWeaponBatman.isHidden = false
    }
    
    func stopTimerAttack() {
        guard timerAttack != nil else { return }
        timerAttack?.invalidate()
        timerAttack = nil
        imageWeaponBatman.isHidden = true
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
        UIView.animate(withDuration: 9, animations: {
            var frameTemp = self.imageWhiteStrip.frame
            frameTemp.origin.x = -100
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
                    self.isAttacked = false
                    self.imageJocker.isHidden = false
                })
            }
        })
    }
    
    func run(){
        setHeroGif(tempImage: "batman_run")
        self.isBatmanJumped = false
        imageBlood.isHidden = true
    }
    
    func jump(){
        if(imageBlood.isHidden){
            stopTimerRun()
            setHeroGif(tempImage: "batman_jump")
            self.isBatmanJumped = false
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
                var frameTemp = self.imageBatman.frame
                frameTemp.origin.y = frameTemp.origin.y - 185
                self.imageBatman.frame = frameTemp
            },completion:{
                (finished: Bool) in
                self.isBatmanJumped = true
                UIView.animate(withDuration: 1, animations: {
                    var frameTemp = self.imageBatman.frame
                    frameTemp.origin.y = frameTemp.origin.y + 185
                    self.imageBatman.frame = frameTemp
                })
            })
            startTimerRun(timeTemp: 2)
        }
    }
    
    func attack(){
        UIView.animate(withDuration: 0.1, animations: {
            var frameTemp = self.imageWeaponBatman.frame
            frameTemp.origin.x = frameTemp.origin.x + 20
            self.imageWeaponBatman.frame = frameTemp
        },completion:{
            (finished: Bool) in
            if(self.imageWeaponBatman.frame.origin.x > 700){
                UIView.animate(withDuration: 0, animations: {
                    var frameTemp = self.imageWeaponBatman.frame
                    frameTemp.origin.x = 130
                    self.imageWeaponBatman.frame = frameTemp
                    self.stopTimerAttack()
                })
            }
        })
    }
    
    func checkCollisionWithJoker(){
        if(imageBatman.layer.frame.intersects(imageJocker.layer.frame) && !isBatmanJumped){
            if(!imageJocker.isHidden){
                lowerHealth()
            }
        }
    }
    
    func checkCollisionForAttackOnJoker(){
        if(imageWeaponBatman.layer.frame.intersects(imageJocker.layer.frame) && !imageWeaponBatman.isHidden){
            //killJoker()
            print("Joker Killed...!")
            imageJocker.isHidden = true
            imageWeaponBatman.isHidden = true
        }
    }
    
    func lowerHealth(){
        if(!isAttacked){
            print("Joker Attacked Batman...!")
            healthBatman -= 25
            if(healthBatman == 100){
                imageHealthBarBatman.image = UIImage(named: "healthbar_100.png")
            }
            else if(healthBatman == 75){
                imageHealthBarBatman.image = UIImage(named: "healthbar_75.png")
            }
            else if(healthBatman == 50){
                imageHealthBarBatman.image = UIImage(named: "healthbar_50.png")
            }
            else if(healthBatman == 25){
                imageHealthBarBatman.image = UIImage(named: "healthbar_25.png")
            }
            else if(healthBatman == 0){
                imageEndingScene.loadGif(name: "joker_kills_Batman")
                startTimerGameOver(timeTemp: 6)
                //gameOver()
            }
            stopTimerRun()
            imageBatman.loadGif(name: "batman_stand")
            imageBlood.isHidden = false
            startTimerRun(timeTemp: 0.5)
        }
        isAttacked = true
    }
    
    func gameOver(){
        imageEndingScene.isHidden = true
        imageGameOver.isHidden = false
        imageHealthBarBatman.isHidden = true
        imageBatman.isHidden = true
        imageBlood.isHidden = true
        imageJocker.isHidden = true
        buttonJump.isHidden = true
        buttonPlayAgain.isHidden = false
        buttonAttack.isHidden = true
    }
}


