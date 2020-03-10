//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by Aaron Prestidge on 3/10/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation
import UIKit

enum CardError: LocalizedError {
    //What we see: error cases
        case invalidURL
        case thrown(Error)
        case noData
        case unableToDecode
        
        //What the viewer sees: corresponding error messages
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Unable to reach server."
            case .thrown(let error):
                return error.localizedDescription
            case .noData:
                return "There was no data found on server."
            case .unableToDecode:
                return "Server responded with data that could not be used."
            
        }
    }
}
