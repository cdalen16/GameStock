//
//  MapAPIData.swift
//  GameStock
//
//  Created by Nahom  Atsbeha on 4/21/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import Foundation

var mapStructList = [MapDetails]()

var apiKey = "mm26MMKcoLqlS7TkRTPprfPvduyvw09d"

// GETS JSON DATA FROM THE API AND RETURNS DATA?

public func getJsonDataFromApi(apiUrl: String) -> Data? {
    
    var apiQueryUrlStruct: URL?
    
    if let urlStruct = URL(string: apiUrl) {
        apiQueryUrlStruct = urlStruct
    } else {
        return nil
    }
    
    let jsonData: Data?
    do {
        /*
         Try getting the JSON data from the URL and map it into virtual memory, if possible and safe.
         Option mappedIfSafe indicates that the file should be mapped into virtual memory, if possible and safe.
         */
        jsonData = try Data(contentsOf: apiQueryUrlStruct!, options: Data.ReadingOptions.mappedIfSafe)
        return jsonData
        
    } catch {
        return nil
    }
}

// GETS A LATITUDE AND LONGITUDE
// FROM THE API BY USING AN ADDRESS AS AN INPUT

func getLatLong(addressInput: String) -> [MapDetails] {
    
    var searchResults = [MapDetails]()
    
    let apiQueryUrlString = "http://www.mapquestapi.com/geocoding/v1/address?key=mm26MMKcoLqlS7TkRTPprfPvduyvw09d&location=\(addressInput)&maxResults=1"
    let apiQueryUrlStringFixed = apiQueryUrlString.replacingOccurrences(of: " ", with: "+")
    
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: apiQueryUrlStringFixed)
    
    if(jsonDataFromApi == nil){
        return [MapDetails]()
    }
    
    do{
        
        var lat = 0.0, lon = 0.0
        
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        
        var jsonDataDictionary = Dictionary<String, Any>()
        
        if let jsonObject = jsonResponse as? [String: Any] {
            jsonDataDictionary = jsonObject
            
            var resultsDic = jsonResponse as? [Dictionary <String, Any>]
            if let resultsDictionary = jsonDataDictionary["results"] as? [Dictionary <String, Any>] {
                resultsDic = resultsDictionary
                
                var locDic = jsonResponse as? [String: Any]
                let locationDictionary = resultsDic![0]
                locDic = locationDictionary
                
                var lDic = jsonResponse as? [Dictionary <String, Any>]
                if let locsDictionary = locDic!["locations"] as? [Dictionary <String, Any>] {
                    lDic = locsDictionary
                    
                    var cDic = jsonResponse as? [String: Any]
                    let coordDictionary = lDic![0]
                    cDic = coordDictionary
                    
                    var latlngDic = jsonResponse as? Dictionary <String, Any>
                    if let latlngDictionary = cDic!["latLng"] as? Dictionary <String, Any> {
                        latlngDic = latlngDictionary
                        
                        var latitude = jsonResponse as? Double
                        if let latnum = latlngDic!["lat"] as? Double {
                            latitude = latnum
                            lat = latitude!
                        }
                        var longitude = jsonResponse as? Double
                        if let lngnum = latlngDic!["lng"] as? Double {
                            longitude = lngnum
                            lon = longitude!
                        }
                        
                    } else { return [MapDetails]()}
                } else { return [MapDetails]()}
            } else { return [MapDetails]()}
            
        } else { return [MapDetails]()}
        
        
        let newLocation = MapDetails(id: UUID(), latitude: lat, longitude: lon)
        searchResults.append(newLocation)
        
    } catch{
        print("Failed trying to get API Data")
    }
    
    return searchResults
}

