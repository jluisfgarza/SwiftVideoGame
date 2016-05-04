//
//  DraggableView.swift
//  Heroes
//
//  Created by Luis Felipe Salazar on 5/3/16.
//  Copyright © 2016 Luis Felipe Salazar. All rights reserved.
//

import Foundation
import UIKit

let ACTION_MARGIN: Float = 90      //%%% distance from center where the action applies. Higher = swipe further in order for the action to be called
let SCALE_STRENGTH: Float = 4       //%%% how quickly the card shrinks. Higher = slower shrinking
let SCALE_MAX:Float = 0.93          //%%% upper bar for how much the card shrinks. Higher = shrinks less
let ROTATION_MAX: Float = 1         //%%% the maximum rotation allowed in radians.  Higher = card can keep rotating longer
let ROTATION_STRENGTH: Float = 320  //%%% strength of rotation. Higher = weaker rotation
let ROTATION_ANGLE: Float = 3.14/8  //%%% Higher = stronger rotation angle

protocol DraggableViewDelegate {
    func cardSwipedLeft(card: UIView) -> Void
    func cardSwipedRight(card: UIView) -> Void
}

class DraggableView: UIView {
    var delegate: DraggableViewDelegate!
    var panGestureRecognizer: UIPanGestureRecognizer!
    var tapGestureRecognizer: UITapGestureRecognizer!
    var doubleTapGestureRecognizer: UITapGestureRecognizer!
    var longPressRecognizer: UILongPressGestureRecognizer!
    var originPoint: CGPoint!
    //var overlayView: OverlayView!
    var actualPhoto: UIImageView!
    var number: UILabel!
    var xFromCenter: Float!
    var yFromCenter: Float!
    var tapped = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        
        let nombre = "screenshot1"
        
        actualPhoto = UIImageView(image: UIImage(named: nombre))
        actualPhoto.contentMode = UIViewContentMode.ScaleAspectFill
        actualPhoto.frame = CGRectMake(0, 0, self.frame.size.width , self.frame.size.height)
        actualPhoto.layer.masksToBounds = true
        
        number = UILabel(frame: CGRectMake(0, 0, self.frame.size.width , self.frame.size.height))
        number.textAlignment = .Center
        
        self.backgroundColor = UIColor.whiteColor()
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DraggableView.beingDragged(_:)))
        
        //self.addGestureRecognizer(tapGestureRecognizer)
        //self.addGestureRecognizer(doubleTapGestureRecognizer)
        self.addGestureRecognizer(panGestureRecognizer)
        //self.addGestureRecognizer(longPressRecognizer)
        self.addSubview(actualPhoto)
        self.addSubview(number)
        
        //tapGestureRecognizer.requireGestureRecognizerToFail(doubleTapGestureRecognizer)
        
        //overlayView = OverlayView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        //overlayView.alpha = 0
        //self.addSubview(overlayView)
        
        xFromCenter = 0
        yFromCenter = 0
    }
    
    func setupView() -> Void {
        self.layer.cornerRadius = 140;
        self.layer.shadowRadius = 3;
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowOffset = CGSizeMake(1, 1);
    }
    
    func beingDragged(gestureRecognizer: UIPanGestureRecognizer) -> Void {
        if !tapped {
            xFromCenter = Float(gestureRecognizer.translationInView(self).x)
            yFromCenter = Float(gestureRecognizer.translationInView(self).y)
            
            switch gestureRecognizer.state {
            case UIGestureRecognizerState.Began:
                self.originPoint = self.center
            case UIGestureRecognizerState.Changed:
                let rotationStrength: Float = min(xFromCenter/ROTATION_STRENGTH, ROTATION_MAX)
                let rotationAngle = ROTATION_ANGLE * rotationStrength
                let scale = max(1 - fabsf(rotationStrength) / SCALE_STRENGTH, SCALE_MAX)
                
                self.center = CGPointMake(self.originPoint.x + CGFloat(xFromCenter), self.originPoint.y + CGFloat(yFromCenter))
                
                let transform = CGAffineTransformMakeRotation(CGFloat(rotationAngle))
                let scaleTransform = CGAffineTransformScale(transform, CGFloat(scale), CGFloat(scale))
                self.transform = scaleTransform
                //self.updateOverlay(CGFloat(xFromCenter))
            case UIGestureRecognizerState.Ended:
                self.afterSwipeAction()
            case UIGestureRecognizerState.Possible:
                fallthrough
            case UIGestureRecognizerState.Cancelled:
                fallthrough
            case UIGestureRecognizerState.Failed:
                fallthrough
            default:
                break
            }
        }
        
    }
    
    /*
    func oneTap(){
        delegate.showImage()
        print("Tapped once")
    }
    
    func doubleTap(){
        if !tapped {
            delegate.likeClick()
            print("Double tapped")
        }
    }
    
    func longPressed(){
        delegate.shareImage()
        print("Long Pressed")
    }
    */
    /*
    func updateOverlay(distance: CGFloat) -> Void {
        if distance > 0 {
            overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeRight)
        } else {
            overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeLeft)
        }
        overlayView.alpha = CGFloat(min(fabsf(Float(distance))/100, 0.6))
    }
    */
    func afterSwipeAction() -> Void {
        let floatXFromCenter = Float(xFromCenter)
        if floatXFromCenter > ACTION_MARGIN {
            self.rightAction()
        } else if floatXFromCenter < -ACTION_MARGIN {
            self.leftAction()
        } else {
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.center = self.originPoint
                self.transform = CGAffineTransformMakeRotation(0)
                //self.overlayView.alpha = 0
                }, completion: { (Bool) -> Void in
            })
        }
    }
    
    func rightAction() -> Void {
        let finishPoint: CGPoint = CGPointMake(1024+400,2 * CGFloat(yFromCenter) + self.originPoint.y)
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.center = finishPoint
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedRight(self)
    }
    
    func leftAction() -> Void {
        let finishPoint: CGPoint = CGPointMake(-400, 2 * CGFloat(yFromCenter) + self.originPoint.y)
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.center = finishPoint
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardSwipedLeft(self)
    }
    
    func rightClickAction() -> Void {
        let finishPoint = CGPointMake(700, self.center.y)
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.center = finishPoint
            self.transform = CGAffineTransformMakeRotation(1)
            }, completion: { (Bool) -> Void in
                self.removeFromSuperview()
        })
        delegate.cardSwipedRight(self)
    }
    
    func leftClickAction() -> Void {
        let finishPoint: CGPoint = CGPointMake(-700 + self.frame.size.width, self.center.y)
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.center = finishPoint
            self.transform = CGAffineTransformMakeRotation(-1)
            }, completion: { (Bool) -> Void in
                self.removeFromSuperview()
        })
        delegate.cardSwipedLeft(self)
    }
    /*
    func likeClickAction() -> Void {
        
        UIView.animateWithDuration(0.4,
                                   animations: {
                                    self.transform = CGAffineTransformMakeScale(1.5, 1.5)
                                    self.alpha = 0
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        delegate.cardLike(self)
    }
    
    func undoLikeAction() -> Void {
        
        self.alpha = 0
        self.transform = CGAffineTransformMakeScale(1.5, 1.5)
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(1, 1)
            self.alpha = 1
            }, completion: { (Bool) -> Void in
        })
        
    }
    
    func undoDeleteAction() -> Void {
        let startPoint = CGPointMake(-600 + self.frame.size.width * 1.43, self.center.y)
        let finishPoint: CGPoint = CGPointMake(self.center.x, self.center.y)
        
        self.center = startPoint
        self.transform = CGAffineTransformMakeRotation(-1)
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.center = finishPoint
            self.transform = CGAffineTransformMakeRotation(0)
            }, completion: { (Bool) -> Void in
        })
        
    }
    
    func undoKeepAction() -> Void {
        let startPoint = CGPointMake(600, self.center.y)
        let finishPoint = CGPointMake(self.center.x, self.center.y)
        
        self.center = startPoint
        self.transform = CGAffineTransformMakeRotation(1)
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.center = finishPoint
            self.transform = CGAffineTransformMakeRotation(0)
            }, completion: { (Bool) -> Void in
        })
        
    }
    */
    func deleteSubCard() ->Void {
        self.removeFromSuperview()
    }
    
}
