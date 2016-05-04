//
//  LoadPlayerViewController.swift
//  Heroes
//
//  Created by Luis Felipe Salazar on 5/2/16.
//  Copyright © 2016 Luis Felipe Salazar. All rights reserved.
//

import UIKit

class LoadPlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "gamesSegue" {
            let controller: GamesViewController = segue.destinationViewController as! GamesViewController
            //controller.boy = boy
        }
    }
 
    
    @IBAction func backAction(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

}
