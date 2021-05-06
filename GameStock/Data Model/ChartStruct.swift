//
//  ChartStruct.swift
//  GameStock
//
//  Created by Nahom  Atsbeha on 4/26/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import Foundation
import SwiftUI

/// THIS STRUCT ORGANIZES DATA FOR THE RETURN VALUE OF
/// "apiGetStockChart()" FUNCTION CALL IN  IEXApi.swift
struct HisStockData: Hashable, Codable, Identifiable {
    
    var id: UUID
    var stockSymbol: String
    var fOpen: Double
    var fClose: Double
    var fHigh: Double
    var fLow: Double
    var fVolume: Int
    var date: String
    var priceChange: Double
    var changePercent: Double
    
    
}
