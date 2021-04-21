//
//  MapData.swift
//  GameStock
//
//  Created by Nahom  Atsbeha on 4/21/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import Foundation

struct MapDetails: Hashable, Codable, Identifiable {
    
    var id: UUID
    var location: String
    var latitude: Double
    var longitude: Double
    
}
