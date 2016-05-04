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
    
    
    var score : Int!
    var boy = true
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
