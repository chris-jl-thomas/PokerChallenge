import Foundation

func getHighestCardHand(player: Player?, river: [Card]) -> [Card] {
    Array(
        getCards(river: river, hand: player?.hand)
            .getOrderedHand()
            .prefix(5))
}
