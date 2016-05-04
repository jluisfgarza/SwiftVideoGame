//
//  TapTapViewController.swift
//  Heroes
//
//  Created by Luis Felipe Salazar on 4/25/16.
//  Copyright © 2016 Luis Felipe Salazar. All rights reserved.
//

import UIKit
import AVFoundation

/**
 *
 * @authors Luis Felipe Salazar, Juan Luis Flores, Carlos Serret, Melissa Treviño
 *
 * TapTap is a time-based game about choosing if a number is the right answer,
 * depending on the instruction given at the beginning.
 *
 * 25/APR/16
 * @version 1.0
 *
 */

class TapTapViewController: UIViewController {

    // 🇲🇽
    @IBOutlet var circleButton: UIButton!
    @IBOutlet var instructionLabel: UILabel!
    @IBOutlet var whiteLayer: UILabel!

    @IBOutlet var pauseBackground: UILabel!
    @IBOutlet var continueButton: UIButton!
    
    @IBOutlet var playerImage: UIImageView!
    @IBOutlet var timerLabel: UILabel!
    
    // Initialization of variables.
    var iTaps = 0               // Integer number of taps made.
    var iCounter = 30           // Integer for timer
    var number = 0              // Integer number that is showed on the game
    var boy = true              // Bool variable that tells us if the player is a boy or a girls
    var even = true             // Bool variable to know if the answers are odd or even
    var playing = false         // Bool variable
    var newButtonX : CGFloat!   // CGFloat variable to change X position of the circle button
    var newButtonY : CGFloat!   // CGFloat variable to change Y position of the circle button
    var multiple = 0            // Integer number to know if the game is for multiples and which one
    var playerIndex : Int!
    
    var timer = NSTimer()

    // Initialization of sound variables.
    var circleSound: AVAudioPlayer = AVAudioPlayer()
    var wrongSound: AVAudioPlayer = AVAudioPlayer()
    let circleSoundLocation = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("circleSound", ofType: "mp3")!)
    let wrongSoundLocation = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("wrong", ofType: "mp3")!)

    // First function that runs when the game starts.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting sounds
        //try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        //try! AVAudioSession.sharedInstance().setActive(true)
        try! wrongSound = AVAudioPlayer(contentsOfURL: wrongSoundLocation, fileTypeHint: nil)
        try! circleSound = AVAudioPlayer(contentsOfURL: circleSoundLocation, fileTypeHint: nil)
        circleSound.volume = 9
        wrongSound.prepareToPlay()
        circleSound.prepareToPlay()

        // Changing colors
        if boy {
            view.backgroundColor = .boyColor()
            circleButton.setTitleColor(.boyColor(), forState: .Normal)
        } else {
            view.backgroundColor = .girlColor()
            circleButton.setTitleColor(.girlColor(), forState: .Normal)
        }
        
        pauseBackground.alpha = 0.0
        continueButton.alpha = 0.0
        playerImage.alpha = 0.0
        whiteLayer.alpha = 0.0
        
        if boy {
            playerImage.image = UIImage(named: "boy")
        } else {
            playerImage.image = UIImage(named: "girl")
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(TapTapViewController.result), userInfo: nil, repeats: true)
        
        
        // Start game
        displayCircle()
        playing = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        /*
        if let buttonX = newButtonX {
            circleButton.center.x = buttonX
        }
        if let buttonY = newButtonY {
            circleButton.center.y = buttonY
        }
        */
    }

    // Sound functions.
    func playCircleSound() {
        circleSound.play()
    }

    func playWrongSound() {
        wrongSound.play()
    }
    
    func result (){
        if iCounter != 0 {
            iCounter -= 1
            timerLabel.text = String(iCounter)
        } else {
            timer.invalidate()
            wrong()
        }
    }

    // 🇲🇽
    @IBAction func tapCircle(sender: AnyObject) {
        if playing {
            if even {
                checkEven(true)
            } else if multiple != 0{
                checkMultiple(true)
            } else {
                checkOdd(true)
            }
        }
        
    }

    @IBAction func tapBackground(sender: AnyObject) {
        if playing {
            if even {
                checkEven(false)
            } else if multiple != 0 {
                checkMultiple(false)
            } else {
                checkOdd(false)
            }
        }
        
    }
    
    @IBAction func pauseAction(sender: AnyObject) {
        playing = false
        timer.invalidate()
        UIView.animateWithDuration(0.3) { 
            self.pauseBackground.alpha = 0.7
            self.continueButton.alpha = 1.0
            self.playerImage.alpha = 1.0
        }
    }
    
    @IBAction func continueAction(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(TapTapViewController.result), userInfo: nil, repeats: true)
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseIn, animations: { 
            self.pauseBackground.alpha = 0.0
            self.continueButton.alpha = 0.0
            self.playerImage.alpha = 0.0
            }) { (Bool) in
                self.playing = true
        }
    }
    
    func correct() {
        playCircleSound()
        iTaps += 1
        displayCircle()
    }
    
    func wrong() {
        playWrongSound()
        endGame()
    }
    
    func checkEven(circle: Bool) {
        if (number % 2) == 0 {
            if circle {
                correct()
            } else {
                wrong()
            }
        } else {
            if circle {
                wrong()
            } else {
                correct()
            }
        }
    }
    
    func checkOdd(circle: Bool) {
        if (number % 2) == 0 {
            if circle {
                wrong()
            } else {
                correct()
            }
        } else {
            if circle {
                correct()
            } else {
                wrong()
            }
        }
    }
    
    func checkMultiple(circle: Bool) {
        if (number % multiple) == 0 {
            if circle {
                correct()
            } else {
                wrong()
            }
            
        } else {
            if circle {
                wrong()
            } else {
                correct()
            }
        }
    }

    func displayCircle(){
        // Set by rand from 0 to 150
        number = Int(arc4random_uniform(150)) + 1

        // Set button title
        circleButton.setTitle("\(number)", forState: .Normal)

        // Get button width and height
        let buttonWidth = circleButton.frame.width
        let buttonHeight = circleButton.frame.height

        // Find the width and height of the enclosing view
        let viewWidth = circleButton.superview!.bounds.width
        let viewHeight = circleButton.superview!.bounds.height

        // Compute width and height of the area to contain the button's center
        let xwidth = viewWidth - buttonWidth
        let yheight = viewHeight - buttonHeight

        // Generate a random x and y offset
        let xoffset = CGFloat(arc4random_uniform(UInt32(xwidth)))
        let yoffset = CGFloat(arc4random_uniform(UInt32(yheight - 50)))

        // Offset the button's center by the random offsets.
        newButtonX = xoffset + buttonWidth / 2
        newButtonY = yoffset + 50 + buttonHeight / 2 //50 is for notifications
        circleButton.center.x = newButtonX
        circleButton.center.y = newButtonY
        
    }
    
    func endGame() {
        playing = false
        UIView.animateWithDuration(0.2, delay: 0.0, options: [], animations: {
            self.whiteLayer.alpha = 1.0
            }) { (Bool) in
                self.performSegueWithIdentifier("gameOver1Segue", sender: self)
        }
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "gameOver1Segue" {
            let controller: GameOverViewController = segue.destinationViewController as! GameOverViewController
            controller.score = iTaps
            controller.boy = boy
            controller.game = 1
            controller.playerIndex = playerIndex
        }
    }
    

}
