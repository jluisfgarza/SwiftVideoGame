//
//  tapsTimer.swift
//  Tap Don't Tap
//
//  Created by Luis Felipe Salazar on 1/12/15.
//  Copyright (c) 2015 Luis Felipe Salazar. All rights reserved.
//

import Foundation

class tapsTimer: NSObject {
    
    var timer = NSTimer()
    var timerIsRunning = false
    
    var milliseconds:Int = 0
    var seconds:Int = 0
    var minutes:Int = 0
    
    var startTime = NSTimeInterval()
    var endTime = NSTimeInterval()
    var elapsedTime = NSTimeInterval()
    
    
    
    var returnValues: (milliseconds:Int,seconds:Int,minutes:Int) -> ()
    
    init(closure: (milliseconds:Int,seconds:Int,minutes:Int) -> ()) {
        returnValues = closure
        super.init()
    }
    
    func start(){
        if !(timerIsRunning){
            timerIsRunning = true
            startTime = NSDate.timeIntervalSinceReferenceDate()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: #selector(tapsTimer.tick), userInfo: nil, repeats: true)
        }
    }
    
    func pause(){
        endTime = NSDate.timeIntervalSinceReferenceDate()
        timer.invalidate()
        timerIsRunning  = false
    }
    
    func reset(){
        startTime = 0
        endTime = 0
        elapsedTime = 0
        milliseconds = 0
        seconds = 0
        minutes = 0
        timer.invalidate()
        timerIsRunning = false
    }
    
    func tick(){
        var diff = NSTimeInterval()
        var calc = NSTimeInterval()
        endTime = NSDate.timeIntervalSinceReferenceDate()
        diff = (endTime - startTime)
        //restart counting ASAP to reduce loss of accuracy
        startTime = NSDate.timeIntervalSinceReferenceDate()
        
        elapsedTime += diff
        calc = elapsedTime
        minutes = Int(calc/60)
        calc -= Double(minutes * 60)
        seconds = Int(calc)
        calc -= Double(seconds)
        milliseconds = Int(round(Double(calc) * 1000))
        returnToCaller()
    }
    
    func returnToCaller(){
        returnValues(milliseconds: milliseconds,seconds: seconds,minutes: minutes)
    }
    
    
    
}
