//
//  CreaUsuarioViewController.swift
//  Heroes
//
//  Created by Luis Felipe Salazar on 4/27/16.
//  Copyright © 2016 Luis Felipe Salazar. All rights reserved.
//

import UIKit

class CreaUsuarioViewController: UIViewController {
    
    @IBOutlet var boyImage: UIImageView!
    @IBOutlet var girlImage: UIImageView!
    
    @IBOutlet var primSecBoy: UISegmentedControl!
    @IBOutlet var gradoPrimBoy: UISegmentedControl!
    @IBOutlet var gradoSecBoy: UISegmentedControl!
    @IBOutlet var nombreBoy: UILabel!
    @IBOutlet var nombreTextFieldBoy: UITextField!
    @IBOutlet var gradoBoy: UILabel!
    
    @IBOutlet var primSecGirl: UISegmentedControl!
    @IBOutlet var gradoPrimGirl: UISegmentedControl!
    @IBOutlet var gradoSecGirl: UISegmentedControl!
    @IBOutlet var nombreGirl: UILabel!
    @IBOutlet var nombreTextFieldGirl: UITextField!
    @IBOutlet var gradoGirl: UILabel!
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var backButton: UIButton!
    
    @IBOutlet var titleLabel: UILabel!
    
    var boy : Bool = true
    var playerIndex : Int = 0
    var playersName : [String] = []
    var playersSex : [Bool] = []
    var playersScore1 : [Int] = []
    var playersScore2 : [Int] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Read the data
        
        // Get data saved on NSUserDefaults and pass it to array
        
        
        
        updateArrays()
        
        hideDataInputs()
        if boy {
            girlImage.alpha = 0.0
            view.backgroundColor = .boyColor()
            animateBoyDataInputs()
        } else {
            boyImage.alpha = 0.0
            view.backgroundColor = .girlColor()
            animateGirlDataInputs()
        }
        animateView()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateBoyDataInputs() {
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseIn, animations: {
            self.gradoPrimBoy.alpha = 1.0
            self.primSecBoy.alpha = 1.0
            self.nombreBoy.alpha = 1.0
            self.nombreTextFieldBoy.alpha = 1.0
            self.gradoBoy.alpha = 1.0
            }) { (Bool) in
        }
    }
    
    func animateGirlDataInputs() {
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseIn, animations: {
            self.gradoPrimGirl.alpha = 1.0
            self.primSecGirl.alpha = 1.0
            self.nombreGirl.alpha = 1.0
            self.nombreTextFieldGirl.alpha = 1.0
            self.gradoGirl.alpha = 1.0
        }) { (Bool) in
        }
    }
    
    func animateView()  {
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseIn, animations: {
            self.playButton.alpha = 1.0
            self.titleLabel.alpha = 1.0
            //self.backButton.alpha = 1.0
        }) { (Bool) in
        }
    }
    
    func hideDataInputs() {
        self.gradoSecBoy.alpha = 0.0
        self.gradoPrimBoy.alpha = 0.0
        self.primSecBoy.alpha = 0.0
        self.nombreBoy.alpha = 0.0
        self.nombreTextFieldBoy.alpha = 0.0
        self.gradoBoy.alpha = 0.0
        self.gradoSecGirl.alpha = 0.0
        self.gradoSecGirl.alpha = 0.0
        self.gradoPrimGirl.alpha = 0.0
        self.primSecGirl.alpha = 0.0
        self.nombreGirl.alpha = 0.0
        self.nombreTextFieldGirl.alpha = 0.0
        self.gradoGirl.alpha = 0.0
        self.gradoSecBoy.alpha = 0.0
        playButton.alpha = 0.0
        titleLabel.alpha = 0.0
    }
    
    @IBAction func primSecAction(sender: UISegmentedControl) {
        if boy {
            if sender.selectedSegmentIndex  == 0 {
                gradoPrimBoy.alpha = 1.0
                gradoSecBoy.alpha = 0.0
            } else {
                gradoSecBoy.alpha = 1.0
                gradoPrimBoy.alpha = 0.0
            }

        } else {
            if sender.selectedSegmentIndex  == 0 {
                gradoPrimGirl.alpha = 1.0
                gradoSecGirl.alpha = 0.0
            } else {
                gradoSecGirl.alpha = 1.0
                gradoPrimGirl.alpha = 0.0
            }
        }
    }
    
    
    @IBAction func gradoPrimAction(sender: UISegmentedControl) {
        if boy {
            
            
        } else {
            
            
        }
    }

    
    @IBAction func gradoSecAction(sender: UISegmentedControl) {
        if boy {
            
            
        } else {
            
            
        }
    }
    
    
    @IBAction func playAction(sender: AnyObject) {
        if boy {
            if nombreTextFieldBoy.text == "" {
                showAlert()
                return
            }
            print("Nombre: \(nombreTextFieldBoy.text)")
            print("Sexo: Niño")
            savePlayer()
            if primSecBoy.selectedSegmentIndex == 0 {
                print("Primaria: \(gradoPrimBoy.selectedSegmentIndex + 1)")
                
                
            } else {
                print("Secundaria: \(gradoSecBoy.selectedSegmentIndex + 1)")
            }
        } else {
            if nombreTextFieldGirl.text == "" {
                showAlert()
                return
            }
            print(nombreTextFieldGirl.text)
            print("Sexo: Niña")
            savePlayer()
            if primSecGirl.selectedSegmentIndex == 0 {
                print("Primaria: \(gradoPrimGirl.selectedSegmentIndex + 1)")
            } else {
                print("Secundaria: \(gradoSecGirl.selectedSegmentIndex + 1)")
            }
        }
        
        
        
        performSegueWithIdentifier("gamesSegue", sender: self)
    }
    
    func savePlayer(){
        
        playerIndex = playersName.count
        
        if boy {
            playersName.append(nombreTextFieldBoy.text!)
        } else {
            playersName.append(nombreTextFieldGirl.text!)
        }
        
        playersSex.append(boy)
        playersScore1.append(0)
        playersScore2.append(0)
        
        // Save the data
        NSUserDefaults.standardUserDefaults().setObject(playersName, forKey : "playersName")
        NSUserDefaults.standardUserDefaults().setObject(playersSex, forKey : "playersSex")
        NSUserDefaults.standardUserDefaults().setObject(playersScore1, forKey: "scoreTapTap")
        NSUserDefaults.standardUserDefaults().setObject(playersScore2, forKey: "scoreSwipe")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func updateArrays(){
        if let names = NSUserDefaults.standardUserDefaults().arrayForKey("playersName") {
            for name in names {
                playersName.append(name as! String)
            }
        }
        
        if let sex = NSUserDefaults.standardUserDefaults().arrayForKey("playersSex") {
            for gender in sex {
                playersSex.append(gender as! Bool)
            }
        }
        
        if let scoreTapTap = NSUserDefaults.standardUserDefaults().arrayForKey("scoreTapTap") {
            for score in scoreTapTap {
                playersScore1.append(score as! Int)
            }
        }
        
        if let scoreSwipe = NSUserDefaults.standardUserDefaults().arrayForKey("scoreSwipe") {
            for score in scoreSwipe {
                playersScore2.append(score as! Int)
            }
        }
        
        let count = playersName.count
        
        if count != 0 {
            for i in 0..<count {
                print("JUGADOR \(i + 1)")
                print("Nombre: \(playersName[i])")
                print("Sexo: \(playersSex[i])")
                print("ScoreTapTap: \(playersScore1[i])")
                print("ScoreSwipe: \(playersScore2[i])")
            }
        }
        
        
        
    }
    
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Escribe tu nombre", message:
            "Es necesario que escribas tu nombre para continuar", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "gamesSegue" {
            let controller: GamesViewController = segue.destinationViewController as! GamesViewController
            controller.boy = boy
            controller.playerIndex = playerIndex
        }
    }
    

}
