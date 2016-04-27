//
//  ChooseViewController.swift
//  Heroes
//
//  Created by Luis Felipe Salazar on 4/26/16.
//  Copyright © 2016 Luis Felipe Salazar. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController {
    
    
    @IBOutlet var boyButton: UIButton!
    @IBOutlet var girlButton: UIButton!
    @IBOutlet var backgroundColor: UILabel!
    
    var boy = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundColor.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func boyAction(sender: AnyObject) {
        boy = true
        backgroundColor.backgroundColor = .boyColor()
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.backgroundColor.alpha = 1.0
            self.girlButton.alpha = 0.0
        }) { (Bool) in
            
            self.performSegueWithIdentifier("crearUsuarioSegue", sender: self)
            
        }
    }
    
    
    @IBAction func girlAction(sender: AnyObject) {
        boy = false
        backgroundColor.backgroundColor = .girlColor()
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.backgroundColor.alpha = 1.0
            self.boyButton.alpha = 0.0
        }) { (Bool) in
            self.performSegueWithIdentifier("crearUsuarioSegue", sender: self)
        }
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "crearUsuarioSegue" {
            let controller: CreaUsuarioViewController = segue.destinationViewController as! CreaUsuarioViewController
            controller.boy = boy
        }
        
    }
    
    
}
