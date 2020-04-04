import Foundation

func getPairHand(player: Player?, river: [Card]) -> [Card] {
    let potentialHand = getCards(river: river, hand: player?.hand)
    let pairDictionary = getPairDictionary(cards: potentialHand)
    
    guard
        pairDictionary.keys.count == 1,
        let pairValue = pairDictionary.keys.first
    else {
        return []
    }
    
    let pair = potentialHand
        .filter { card in
            card.value == pairValue
        }
        .orderBySuit()
    
    let rest = Array(potentialHand
        .filter { card in
            card.value != pairValue
        }
        .getOrderedHand()
        .prefix(3))
    
    return pair + rest
}
