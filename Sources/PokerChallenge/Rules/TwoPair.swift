import Foundation

func getTwoPairHand(player: Player?, river: [Card]) -> [Card] {
    let potentialHand = getCards(river: river, hand: player?.hand)
    let pairKeys = getPairDictionary(cards: potentialHand)
    
    guard pairKeys.keys.count >= 2 else {
        return []
    }
    
    let arrayOfKeys = Array(pairKeys.keys)
        .sorted { $0.rawValue > $1.rawValue}
    
    guard
        let highestPairValue = arrayOfKeys.first,
        let secondPairValue = arrayOfKeys.dropFirst().first
    else {
        return []
    }
    
    let highestPair = potentialHand
        .filter { card in
            card.value == highestPairValue
        }
        .orderBySuit()
    
    let secondPair = potentialHand
        .filter { card in
            card.value == secondPairValue
        }
        .orderBySuit()
    
    let rest = Array(potentialHand
        .filter { card in
            card.value != highestPairValue && card.value != secondPairValue
        }
        .getOrderedHand()
        .prefix(1))
    
    return highestPair + secondPair + rest

}

func getPairDictionary(cards: [Card]) -> [Value: Int] {
    cards.map { card in
        card.value
    }
    .reduce(into: [:]) { counts, number in
        counts[number, default: 0] += 1
    }
    .filter { (suit, count) in
        count == 2
    }
}
