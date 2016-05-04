//
//  LoadPlayerViewController.swift
//  Heroes
//
//  Created by Luis Felipe Salazar on 5/2/16.
//  Copyright © 2016 Luis Felipe Salazar. All rights reserved.
//

import UIKit

class LoadPlayerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    var boy : Bool = true
    var playerIndex : Int = 0
    var playersName : [String] = []
    var playersSex : [Bool] = []
    var playersScore1 : [Int] = []
    var playersScore2 : [Int] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateArrays()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(HomeAlbumsCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.reloadData()

        
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
            controller.playerIndex = playerIndex
        }
    }
    
    // MARK: - CollectionView

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playersName.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! HomeAlbumsCell
        
        print(indexPath.item)
        print(playersName[indexPath.item])
        cell.textLabel.text = playersName[indexPath.item]
        
        //cell.setName(playersName[indexPath.item])
        if playersSex[indexPath.item] {
            cell.setThumbnailImage(UIImage(named: "boy")!)
        } else {
            cell.setThumbnailImage(UIImage(named: "girl")!)
        }
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        playerIndex = indexPath.item
        performSegueWithIdentifier("showGamesSegue", sender: self)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 0
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 1
    }
    
    // MARK: - Actions
    
    @IBAction func backAction(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Functions
    
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
        
    }


}
