//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Aaron Prestidge on 3/10/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation
import UIKit

class CardController: Codable {
    
    static let endpointURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1")
    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        // 1 - Prepare URL
        guard let endpointURL = endpointURL else {return (completion(.failure(.invalidURL))) }
        print(endpointURL)
        // 2 - Contact server
        URLSession.shared.dataTask(with: endpointURL) { (data, _, error) in
            // 3 - Handle errors from the server
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            // 4 - Check for json data
            guard let data = data else {return completion(.failure(.noData))}
            // 5 - Decode json into a Card
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                guard let card = topLevelObject.cards.first else {return completion(.failure(.unableToDecode))}
                return completion(.success(card))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result <UIImage, CardError>) -> Void) {
        
        // 1 - Prepare URL
        let imageURL = card.image
        print(imageURL)
        // 2 - Contact server
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            // 3 - Handle errors from the server
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
            // 4 - Check for image data
            guard let data = data else {return completion(.failure(.noData))}
            // 5 - Initialize an image from the data
            guard let image = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            return completion(.success(image))
        }.resume()
    }
    
}//End Class
