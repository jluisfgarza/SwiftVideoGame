//
//  InitialViewController.swift
//  Heroes
//
//  Created by Luis Felipe Salazar on 5/2/16.
//  Copyright © 2016 Luis Felipe Salazar. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet var playButton: UIButton!
    @IBOutlet var settingsButton: UIButton!
    
    @IBOutlet var heroesTitle: UIImageView!
    @IBOutlet var herosBG: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        playButton.alpha = 0.0
        settingsButton.alpha = 0.0
        heroesTitle.alpha = 0.0
        herosBG.alpha = 0.0
        animates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playAction(sender: AnyObject) {
        performSegueWithIdentifier("elegirSegue", sender: self)
    }
    
    
    @IBAction func settingsAction(sender: AnyObject) {
        performSegueWithIdentifier("settingsSegue", sender: self)
    }
    
    
    
    func animates() {
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseIn, animations: {
            self.herosBG.alpha = 1.0
        }) { (Bool) in
        }
        UIView.animateWithDuration(0.2, delay: 0.1, options: .CurveEaseIn, animations: {
            self.playButton.alpha = 1.0
        }) { (Bool) in
        }
        UIView.animateWithDuration(0.2, delay: 0.2, options: .CurveEaseIn, animations: {
            self.heroesTitle.alpha = 1.0
            self.settingsButton.alpha = 1.0
        }) { (Bool) in
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
