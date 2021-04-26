//
//  NewsStruct.swift
//  GameStock
//
//  Created by CS3714 on 4/25/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI

struct NewsStruct: Hashable, Codable, Identifiable {
   
    var id: UUID
    var headline: String
    var author: String
    var datePub: Date
    var content: String
    var storyUrl: String
    var imageUrl: String
}
