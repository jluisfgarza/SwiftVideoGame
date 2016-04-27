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
    
    
    var boy : Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if boy {
            view.backgroundColor = .boyColor()
            hideGirlDataInputs()
            animateBoyDataInputs()
        } else {
            view.backgroundColor = .girlColor()
            hideBoyDataInputs()
            animateGirlDataInputs()
        }
        
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
    
    func hideBoyDataInputs() {
        boyImage.alpha = 0.0
        self.gradoSecBoy.alpha = 0.0
        self.gradoPrimBoy.alpha = 0.0
        self.primSecBoy.alpha = 0.0
        self.nombreBoy.alpha = 0.0
        self.nombreTextFieldBoy.alpha = 0.0
        self.gradoBoy.alpha = 0.0
        self.gradoSecGirl.alpha = 0.0
    }
    
    func hideGirlDataInputs() {
        girlImage.alpha = 0.0
        self.gradoSecGirl.alpha = 0.0
        self.gradoPrimGirl.alpha = 0.0
        self.primSecGirl.alpha = 0.0
        self.nombreGirl.alpha = 0.0
        self.nombreTextFieldGirl.alpha = 0.0
        self.gradoGirl.alpha = 0.0
        self.gradoSecBoy.alpha = 0.0
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
        performSegueWithIdentifier("gamesSegue", sender: self)
    }
    
    
    @IBAction func backAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "gamesSegue" {
            let controller: GamesViewController = segue.destinationViewController as! GamesViewController
            controller.boy = boy
        }
    }
    

}
