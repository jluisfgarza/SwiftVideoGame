//
//  SwipeViewController.swift
//  Heroes
//
//  Created by Luis Felipe Salazar on 5/2/16.
//  Copyright © 2016 Luis Felipe Salazar. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController, DraggableViewDelegate {
    
    var boy = true
    
    var loadedCards: [DraggableView]! = []
    let MAX_BUFFER_SIZE = 2
    
    // New
    var numbersArray : [Int]! = []
    var iCont = 0
    
    // To be deleted
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if boy {
            view.backgroundColor = .boyColor()
        } else {
            view.backgroundColor = .girlColor()
        }
        
        for i in 1...1000 {
            numbersArray.append(i)
        }
        
        self.loadCards()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createDraggableViewWithDataAtIndex(index: NSInteger) -> DraggableView {
        
        //let cardSide: CGFloat = view.bounds.width - 20
        let draggableView = DraggableView(frame: CGRectMake(372, 125, 280, 280))
        /*
        PHImageManager.defaultManager().requestImageForAsset(albumArray[index], targetSize: CGSize(width: cardSide, height: cardSide), contentMode: .AspectFill, options: nil, resultHandler: {(result, info)in
            draggableView.actualPhoto.image = result
        })
        */
        
        draggableView.number.text = "\(numbersArray[index])"
        
        draggableView.delegate = self
        return draggableView
        
    }
    
    func loadCards() -> Void {
        if numbersArray.count > 0 {
            let numLoadedCardsCap = numbersArray.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : numbersArray.count
            for i in 0 ..< numLoadedCardsCap {
                let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(i)
                loadedCards.append(newCard)
            }
            
            for i in 0 ..< loadedCards.count {
                if i > 0 {
                    view.insertSubview(loadedCards[i], belowSubview: loadedCards[i - 1])
                } else {
                    view.addSubview(loadedCards[i])
                }
            }
        }
    }
    
    func loadNextCard() -> Void {
        print(iCont)
        numbersArray.removeAtIndex(0)
        loadedCards.removeAtIndex(0)
        if numbersArray.count > 0 {
            let numLoadedCardsCap = numbersArray.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : numbersArray.count
            
            if numLoadedCardsCap > 1 {
                let newCard: DraggableView = self.createDraggableViewWithDataAtIndex(1)
                loadedCards.append(newCard)
                view.insertSubview(loadedCards[1], belowSubview: loadedCards[0])
            }
        } else {
//            deleteButton.enabled = false
//            keepButton.enabled = false
//            likeButton.enabled = false
            // Buttons disable
        }
    }
    
    func cardSwipedLeft(card: UIView) -> Void {
        
        // If even
        if numbersArray[0] % 2 == 0 {
            
        } else {
            iCont += 1
        }
        
        loadNextCard()
        
        
        
    }
    
    func cardSwipedRight(card: UIView) -> Void {
        
        // If even
        if numbersArray[0] % 2 == 0 {
            iCont += 1
        } else {
            
        }
        
        loadNextCard()
        
        
    }

    
    func swipeRight() -> Void {
        
        if loadedCards.count <= 0 {
            //noPhotosLeft()
            return
            
        }
        let dragView: DraggableView = loadedCards[0]
        /*
        dragView.overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeRight)
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            dragView.overlayView.alpha = 1
            }, completion: { (Bool) -> Void in
        })
         */
        dragView.rightClickAction()
    }
    
    func swipeLeft() -> Void {
        
        if loadedCards.count <= 0 {
            //noPhotosLeft()
            return
        }
        let dragView: DraggableView = loadedCards[0]
        /*
        dragView.overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeLeft)
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            dragView.overlayView.alpha = 1
            }, completion: { (Bool) -> Void in
        })
         */
        dragView.leftClickAction()
    }

    func deleteCards(){
        if loadedCards.count > 0{
            let card: DraggableView = loadedCards[0]
            card.deleteSubCard()
        }
        if loadedCards.count > 1 {
            let subCard: DraggableView = loadedCards[1]
            subCard.deleteSubCard()
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
