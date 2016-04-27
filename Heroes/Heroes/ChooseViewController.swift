//
//  ChooseViewController.swift
//  Heroes
//
//  Created by Luis Felipe Salazar on 4/26/16.
//  Copyright © 2016 Luis Felipe Salazar. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController {

    var boy = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func boyAction(sender: AnyObject) {
        boy = true
        performSegueWithIdentifier("tapTapSegue", sender: self)
    }

    
    @IBAction func girlAction(sender: AnyObject) {
        boy = false
        performSegueWithIdentifier("tapTapSegue", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "tapTapSegue" {
            let controller: TapTapViewController = segue.destinationViewController as! TapTapViewController
            controller.boy = boy
        }
    }
    

}