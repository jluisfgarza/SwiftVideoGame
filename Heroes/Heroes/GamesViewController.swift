//
//  GamesViewController.swift
//  Heroes
//
//  Created by Luis Felipe Salazar on 4/27/16.
//  Copyright © 2016 Luis Felipe Salazar. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController {
    
    @IBOutlet var labelJuegos: UILabel!
    
    var boy : Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if boy {
            labelJuegos.backgroundColor = .boyColor()
        } else {
            labelJuegos.backgroundColor = .girlColor()
        }
        
        // Read the data
        if let playersName = NSUserDefaults.standardUserDefaults().objectForKey ( "playersName" ) {
            print( "We saved this data: \( playersName )")
        }
        if let playersSex = NSUserDefaults.standardUserDefaults().objectForKey("playersSex") {
            print( "We saved this data: \( playersSex )")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func game1Action(sender: AnyObject) {
        performSegueWithIdentifier("tapTapSegue", sender: self)
    }
    
    @IBAction func game3Action(sender: AnyObject) {
        performSegueWithIdentifier("swipeSegue", sender: self)
    }
    
    @IBAction func backAction(sender: AnyObject) {
        
        for (var i = 0; i < self.navigationController?.viewControllers.count; i += 1) {
            if(self.navigationController?.viewControllers[i].isKindOfClass(ChooseViewController) == true) {
                
                self.navigationController?.popToViewController(self.navigationController!.viewControllers[i] as! ChooseViewController, animated: true)
                
                break
            }
        }
        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "tapTapSegue" {
            let controller: TapTapViewController = segue.destinationViewController as! TapTapViewController
            controller.boy = boy
        } else if segue.identifier == "swipeSegue" {
            let controller: SwipeViewController = segue.destinationViewController as! SwipeViewController
            controller.boy = boy
        }
    }
    

}
