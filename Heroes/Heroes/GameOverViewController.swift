//
//  GameOverViewController.swift
//  Heroes
//
//  Created by Luis Felipe Salazar on 5/2/16.
//  Copyright © 2016 Luis Felipe Salazar. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet var homeButton: UIButton!
    @IBOutlet var background: UILabel!
    
    var score : Int! = 0
    var game : Int!
    var boy = true
    var playerIndex : Int!
    var playersName : [String] = []
    var playersSex : [Bool] = []
    var playersScore1 : [Int] = []
    var playersScore2 : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        homeButton.alpha = 0.0
        background.alpha = 0.0
        if boy {
            background.backgroundColor = .boyColor()
        } else {
            background.backgroundColor = .girlColor()
        }
        
        saveScore()
    }
    
    override func viewWillAppear(animated: Bool) {
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseIn, animations: { 
            self.homeButton.alpha = 1.0
            self.background.alpha = 1.0
            }) { (Bool) in
                
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func goHome(sender: AnyObject) {
        for (var i = 0; i < self.navigationController?.viewControllers.count; i += 1) {
            if(self.navigationController?.viewControllers[i].isKindOfClass(GamesViewController) == true) {
                
                self.navigationController?.popToViewController(self.navigationController!.viewControllers[i] as! GamesViewController, animated: true)
                
                break
            }
        }
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
    }
    
    func saveScore(){
        if game == 1 {
            if let scoreTapTap = NSUserDefaults.standardUserDefaults().arrayForKey("scoreTapTap") {
                print(score)
                let num = scoreTapTap[playerIndex] as! Int
                if score > num {
                    updateArrays()
                    playersScore1[playerIndex] = score
                    NSUserDefaults.standardUserDefaults().setObject(playersScore1, forKey: "scoreTapTap")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    print("New Highscore")
                }
            }
        } else if game == 2 {
            if let scoreSwipe = NSUserDefaults.standardUserDefaults().arrayForKey("scoreSwipe") {
                if score > scoreSwipe[playerIndex] as! Int {
                    updateArrays()
                    playersScore2[playerIndex] = score
                    NSUserDefaults.standardUserDefaults().setObject(playersScore2, forKey: "scoreSwipe")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    print("New Highscore")
                }
            }
        }
        
        
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
