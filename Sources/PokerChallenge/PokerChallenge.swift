func decideWinner(players: [Player], river: [Card]) -> [Player] {
    let availablePlayers = players.getAllPlayersWhoBetEnoughToPlay()
    
    guard availablePlayers.count > 1 else { return availablePlayers }
    
    let playersAndBestHand = availablePlayers.toDictionary {
        $0.getBestHand(river: river)
    }
    
    return players
}

func getCards(river: [Card], hand: [Card]?) -> [Card] {
    return river + (hand ?? [])
}

extension Array where Element == Player {
    func getAllPlayersWhoBetEnoughToPlay() -> [Player] {
        
        guard let highestBet = self
            .filter({ $0.bet > 0 })
            .max(by: { (left, right) -> Bool in
                left.bet <= right.bet
            })?
            .bet else { return [] }
    
        return self.filter { $0.bet == highestBet }
    }
}
