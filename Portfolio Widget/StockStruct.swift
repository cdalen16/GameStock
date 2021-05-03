//
//  StockStruct.swift
//  Portfolio WidgetExtension
//
//  Created by CS3714 on 5/3/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI

struct StockStruct: Hashable, Codable, Identifiable {
   
    var id: UUID
    var high: Double
    var low: Double
    var percentChange: Double
    var isMarketOpen: Bool
    var label: String
    var latestPrice: Double
    var primaryExchange: String
    var symbol: String
    var name: String
    var imgURL: String
    var latitude: Double
    var longitude: Double
    
}

//"id": "FC991AC2-CD4F-4A8B-96E3-89363CE55CF2",
//"title": "Joker",
//"posterFileName": "udDclJoHjfjb8Ekgsd4FDteOkCU.jpg",
//"overview": "During the 1980s, a failed stand-up comedian is driven insane and turns to a life of crime and chaos in Gotham City while becoming an infamous psychopathic crime figure.",
//"genres": "Crime, Drama, Thriller",
//"releaseDate": "2019-10-04",
//"runtime": 122,
//"director": "Todd Phillips",
//"actors": "Joaquin Phoenix, Robert De Niro, Zazie Beetz, Frances Conroy",
//"mpaaRating": "R",
//"imdbRating": "9.1",
//"youTubeTrailerId": "xRjvmVaFHkk",
//"tmdbID": 475557
