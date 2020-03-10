//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Aaron Prestidge on 3/10/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation
import UIKit

struct Card: Codable {
    var value: String
    var suit: String
    var code: String
    var image: URL
    
}

struct TopLevelObject: Codable {
    var cards: [Card]
    
}
