//
//  File.swift
//  
//
//  Created by Chris Thomas on 03/04/2020.
//

import Foundation

public struct Player: Equatable, Hashable {
    
    public let name: String
    public let bet: Double
    public let card1: Card
    public let card2: Card

    public init(name: String, bet: Double, card1: Card, card2: Card) {
        self.name = name
        self.bet = bet
        self.card1 = card1
        self.card2 = card2
    }
    
    
    public var hand: [Card] {
        [card1, card2]
    }
}


extension Player {
    func getBestHand(river: [Card]) -> BestHand {
        var cards = river
        
        cards = getStraightFlush(player: self, river: river)
        if !cards.isEmpty {
            return BestHand(cards: cards, hand: .straightFlush)
        }
        
        cards = getFourOfAKind(player: self, river: river)
        if !cards.isEmpty {
            return BestHand(cards: cards, hand: .fourOfAKind)
        }
        
        cards = getFullHouseHand(player: self, river: river)
        if !cards.isEmpty {
            return BestHand(cards: cards, hand: .fullHouse)
        }
        
        cards = getBestFlushHand(player: self, river: river)
        if !cards.isEmpty {
            return BestHand(cards: cards, hand: .flush)
        }
        
        cards = getStraightHand(player: self, river: river)
        if !cards.isEmpty {
            return BestHand(cards: cards, hand: .straight)
        }
        
        cards = getThreeOfAKindHand(player: self, river: river)
        if !cards.isEmpty {
            return BestHand(cards: cards, hand: .threeOfAKind)
        }
        
        cards = getTwoPairHand(player: self, river: river)
        if !cards.isEmpty {
            return BestHand(cards: cards, hand: .twoPair)
        }
        
        cards = getPairHand(player: self, river: river)
        if !cards.isEmpty {
            return BestHand(cards: cards, hand: .pair)
        }
        
        return BestHand(cards: getHighestCardHand(player: self, river: river), hand: .highest)
    }
}
