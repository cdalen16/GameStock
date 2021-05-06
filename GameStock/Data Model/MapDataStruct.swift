//
//  MapData.swift
//  GameStock
//
//  Created by Nahom  Atsbeha on 4/21/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import Foundation


/// THIS STRUCT ORGANIZES DATA FOR THE RETURN VALUE OF
/// "getLatLong()" FUNCTION CALL IN  MapAPIData.swift

struct MapDetails: Hashable, Codable, Identifiable {
    
    var id: UUID
    var latitude: Double
    var longitude: Double
    
}
