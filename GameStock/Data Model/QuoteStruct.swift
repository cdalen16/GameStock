//
//  QuoteStruct.swift
//  GameStock
//
//  Created by Nahom  Atsbeha on 5/4/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import Foundation

/// THIS STRUCT ORGANIZES DATA FOR THE RETURN VALUE OF
/// "readQuotesDataFiles()" FUNCTION CALL IN  QuotesData.swift
public struct QuoteStruct: Hashable, Codable {
    
    //public var id: UUID
    var text: String
    var from: String
    
}
