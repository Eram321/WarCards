//
//  Card.swift
//  WarCards
//
//  Created by Eram on 19/03/2018.
//  Copyright © 2018 Eram. All rights reserved.
//

import Foundation
import UIKit

struct Card {
    let value : Int
    let image : UIImage
    
}

class Deck {
    var cards : [Card]
    
    init(clubs_spades : Bool) {
        cards = [Card]()
        
        var cardNames : [String] = [String]()
        if clubs_spades {
            cardNames = ["clubs", "spades"]
        }
        else{
            cardNames = ["hearths", "diamonts"]
        }
        
        for cardName in cardNames{
            for i in 2...14{
                let imageName = cardName + "\(i)"
                let image : UIImage = UIImage(named: imageName)!
                cards.append(Card(value: i, image: image))
            }
        }
        
        cards.remove(at: 1)
    }
    
    func getNextRandomCard() -> Card?{
    
        if cards.count == 0{
            return nil
        }
        
        let random = Int(arc4random_uniform((UInt32)(cards.count)))
        let card = cards[random]
        
        cards.remove(at: random)
        
        return card
    }
}
