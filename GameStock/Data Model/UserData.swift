//
//  UserData.swift
//  MyPIM
//
//  Created by CS3714 on 3/14/21.
//  Copyright © 2021 Campbell Dalen. All rights reserved.
//

import Combine
import SwiftUI
import CoreData
 
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
    
    @Published var initialValue = UserDefaults.standard.double(forKey: "initialBalance")
    
    @Published var addedBalance = 0.0
    
    @Published var quoteList = quotesStructList
    
    @Published var newsSearchResults = getNews(search: "")
//    @Published var getHotList = getHomeStocks()
    
    @Published var currStocksInvested = [Stock]()
    
     // Publish imageNumber to refresh the View body in Home.swift when it is changed in the slide show
    @Published var stockValue = UserDefaults.standard.double(forKey: "stockValue")
    
    @Published var savedInDatabase =  NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)

    /*
     Create a Timer using initializer () and store its object reference into slideShowTimer.
     A Timer() object invokes a method after a certain time interval has elapsed.
     */
    var slideShowTimer = Timer()
 
    /*
     ===============================================================================
     MARK: -               Publisher-Subscriber Design Pattern
     ===============================================================================
     | Publisher:   @Published var under class conforming to ObservableObject      |
     | Subscriber:  Any View declaring '@EnvironmentObject var userData: UserData' |
     ===============================================================================
    
     By modifying the first View to be shown, ContentView(), with '.environmentObject(UserData())' in
     SceneDelegate, we inject an instance of this UserData() class into the environment and make it
     available to every View subscribing to it by declaring '@EnvironmentObject var userData: UserData'.
    
     When a change occurs in userData (e.g., deleting a country from the list, reordering countries list,
     adding a new country to the list), every View subscribed to it is notified to re-render its View.
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     NOTE:  Only Views can subscribe to it. You cannot subscribe to it within
            a non-View Swift file such as our CountriesData.swift file.
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */

   
    /*
     --------------------------
     MARK: - Scheduling a Timer
     --------------------------
     */
    public func startTimer() {
        // Stop timer if running
        stopTimer()
 
        /*
         Schedule a timer to invoke the fireTimer() method given below
         after 3 seconds in a loop that repeats itself until it is stopped.
         */
        slideShowTimer = Timer.scheduledTimer(timeInterval: 15,
                             target: self,
                             selector: (#selector(fireTimer)),
                             userInfo: nil,
                             repeats: true)
    }
 
    public func stopTimer() {
        slideShowTimer.invalidate()
    }
   
    @objc func fireTimer() {
        
        var currValue = 0.0

        for aStock in currStocksInvested {
            
            let currStock = apiGetStockData(stockSymbol: aStock.stockSymbol!)
            currValue = currValue + currStock.latestPrice * Double(aStock.numberOfShares!)
        }
        print(currValue)
        self.stockValue = currValue
        UserDefaults.standard.set(currValue, forKey: "stockValue")
        
    }
    
    public func getAQuote() -> QuoteStruct {
        
        let rand = Int.random(in: 0..<325)
        
        let quote = quotesStructList[rand]
        
        return quote
    }
    
}
