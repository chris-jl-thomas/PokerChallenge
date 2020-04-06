func decideWinner(players: [Player], river: [Card]) -> [Player] {
    let availablePlayers = players.getAllPlayersWhoBetEnoughToPlay()
    
    guard availablePlayers.count > 1 else { return availablePlayers }
    
    let playersAndBestHand = availablePlayers.toDictionary {
        $0.getBestHand(river: river)
    }
    
    let highestRankedHand = playersAndBestHand
        .max(by: { (left, right) -> Bool in
            left.value.hand.rawValue < right.value.hand.rawValue
        })?
        .value
        .hand

    let playersWithHighestRankedHand = playersAndBestHand.filter { (player, hand) -> Bool in
        hand.hand == highestRankedHand
    }
    
    return compare(playersAndHand: playersWithHighestRankedHand)
}

func getCards(river: [Card], hand: [Card]?) -> [Card] {
    return river + (hand ?? [])
}

func compare(playersAndHand: [Player : BestHand]) -> [Player] {
    if playersAndHand.count <= 1 {
        return Array(playersAndHand.keys)
    }
    
    return Array(playersAndHand.keys)
}
