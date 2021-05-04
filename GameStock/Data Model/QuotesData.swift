//
//  QuotesData.swift
//  GameStock
//
//  Created by Nahom  Atsbeha on 5/4/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import Foundation

// Global arrays of structs
 
var quotesStructList = [QuoteStruct]()
 
/*
 ***********************
 MARK: - Read Data Files
 ***********************
 */
public func readQuotesDataFiles() {
    let jsonDataFullFilename = "QuotesData.json"
   
    // Obtain URL of the data file in document directory on user's device
    let urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(jsonDataFullFilename)
 
    do {
        _ = try Data(contentsOf: urlOfJsonFileInDocumentDirectory)
        
        quotesStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: jsonDataFullFilename, fileLocation: "Document Directory")
        print("Quotesdata is loaded from document directory")
       
    } catch {
      
       
        quotesStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: "QuotesData.json", fileLocation: "Main Bundle")
        print("Quotesdata is loaded from main bundle")
    }
    
}
