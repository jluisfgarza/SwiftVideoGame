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

    // Initialization of variables.
    var iTaps = 0               // Integer number of taps made.
    var number = 0              // Integer number 🇲🇽
    var boy = true              // Boolean variable 🇲🇽
    var pares = true            // Boolean variable 🇲🇽
    var newButtonX : CGFloat!   // 🇲🇽
    var newButtonY : CGFloat!   // 🇲🇽

    // Initialization of sound variables.
    var circleSound: AVAudioPlayer = AVAudioPlayer()
    var wrongSound: AVAudioPlayer = AVAudioPlayer()
    let circleSoundLocation = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("circleSound", ofType: "mp3")!)
    let wrongSoundLocation = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("wrong", ofType: "mp3")!)

    // First function that runs when the game starts.
    override func viewDidLoad() {
        super.viewDidLoad() // 🇲🇽

        // Sounds 🇲🇽
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        try! AVAudioSession.sharedInstance().setActive(true)
        try! wrongSound = AVAudioPlayer(contentsOfURL: wrongSoundLocation, fileTypeHint: nil)
        try! circleSound = AVAudioPlayer(contentsOfURL: circleSoundLocation, fileTypeHint: nil)
        circleSound.volume = 9
        wrongSound.prepareToPlay()
        circleSound.prepareToPlay()

        // Do any additional setup after loading the view.
        if boy {
            view.backgroundColor = .boyColor()
            circleButton.setTitleColor(.boyColor(), forState: .Normal)
        } else {
            view.backgroundColor = .girlColor()
            circleButton.setTitleColor(.girlColor(), forState: .Normal)
        }
        
        displayCircle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        if let buttonX = newButtonX {
            circleButton.center.x = buttonX
        }
        if let buttonY = newButtonY {
            circleButton.center.y = buttonY
        }
    }

    // Sound functions.
    func playCircleSound() {
        circleSound.play()
    }

    func playWrongSound() {
        wrongSound.play()
    }

    // 🇲🇽
    @IBAction func tapCircle(sender: AnyObject) {
        if pares {
            if (number % 2) == 0 {
                playCircleSound()
                iTaps += 1
                displayCircle()
            } else {
                // Player looses.
                playWrongSound()
            }
        } else {
            if (number % 2) == 1 {
                playCircleSound()
                iTaps += 1
                displayCircle()

            } else {
                // Player looses.
                playWrongSound()
            }
        }
    }

    @IBAction func tapBackground(sender: AnyObject) {
        if pares {
            if (number % 2) == 0 {
                // lose
               playWrongSound()
            } else {
                playCircleSound()
                iTaps += 1
                displayCircle()
            }
        } else {
            if (number % 2) == 1 {
                // lose
                playWrongSound()
            } else {
                playCircleSound()
                iTaps += 1
                displayCircle()
            }
        }
    }

    func displayCircle(){
        // Set by rand from 0 to 150
        number = Int(arc4random_uniform(151))

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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
