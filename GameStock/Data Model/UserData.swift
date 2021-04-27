//
//  UserData.swift
//  MyPIM
//
//  Created by CS3714 on 3/14/21.
//  Copyright © 2021 Campbell Dalen. All rights reserved.
//

import Combine
import SwiftUI
 
final class UserData: ObservableObject {
    /*
     ===============================================================================
     |                   Publisher-Subscriber Design Pattern                       |
     ===============================================================================
     | Publisher:   @Published var under class conforming to ObservableObject      |
     | Subscriber:  Any View declaring '@EnvironmentObject var userData: UserData' |
     ===============================================================================
     
     By modifying the first View to be shown, ContentView(), with '.environmentObject(UserData())' in
     SceneDelegate, we inject an instance of this UserData() class into the environment and make it
     available to every View subscribing to it by declaring '@EnvironmentObject var userData: UserData'.
    
     When a change occurs in UserData, every View subscribed to it is notified to re-render its View.
     */
   
    /*
     ---------------------------
     MARK: - Published Variables
     ---------------------------
     */
    
    // Publish if the user is authenticated or not
    @Published var userAuthenticated = false
    
    @Published var securityQ = "What is the name of the first boy or girl that you first kissed?"
    
    @Published var userBalance = UserDefaults.standard.double(forKey: "balance")
    
    @Published var addedBalance = 0.0
    
    @Published var newsSearchResults = getNews(search: "")
    
    // Instance Variables for Voice Recording Duration Timer
    var durationTimer = Timer()
    var startTime: Double = 0
    var timeElapsed: Double = 0
    var timerHours: UInt8 = 0
    var timerMinutes: UInt8 = 0
    var timerSeconds: UInt8 = 0
    var timerMilliseconds: UInt8 = 0
   
    // Publish voiceRecordingDuration
    @Published var voiceRecordingDuration = ""
    
    
    /*
     ---------------------------------------------------
     MARK: - Scheduling a Voice Recording Duration Timer
     ---------------------------------------------------
     */
    public func startDurationTimer() {
        /*
         Schedule a timer to invoke the updateTimeLabel() function given below
         after 0.01 second in a loop that repeats itself until it is stopped.
         */
        durationTimer = Timer.scheduledTimer(timeInterval: 0.01,
                                             target: self,
                                             selector: (#selector(self.updateTimeLabel)),
                                             userInfo: nil,
                                             repeats: true)
       
        // Time at which the timer starts
        startTime = Date().timeIntervalSinceReferenceDate
    }
   
    public func stopDurationTimer() {
        durationTimer.invalidate()
    }
   
    @objc func updateTimeLabel(){
        // Calculate total time since timer started in seconds
        timeElapsed = Date().timeIntervalSinceReferenceDate - startTime
       
        // Calculate hours
        timerHours = UInt8(timeElapsed / 3600)
        timeElapsed = timeElapsed - (TimeInterval(timerHours) * 3600)
       
        // Calculate minutes
        timerMinutes = UInt8(timeElapsed / 60.0)
        timeElapsed = timeElapsed - (TimeInterval(timerMinutes) * 60)
       
        // Calculate seconds
        timerSeconds = UInt8(timeElapsed)
        timeElapsed = timeElapsed - TimeInterval(timerSeconds)
       
        // Calculate milliseconds
        timerMilliseconds = UInt8(timeElapsed * 100)
       
        // Create the time string and update the label
        let timeString = String(format: "%02d:%02d:%02d.%02d", timerHours, timerMinutes, timerSeconds, timerMilliseconds)
        voiceRecordingDuration = timeString
    }
}
