import XCTest
@testable import PokerChallenge

final public class DecideWinnerTests: XCTestCase {
    func test_decideWinner_noBetsNoWinners() {
        let player1 = Player(name: "Alan",
                             bet: 0,
                             card1: Card(suit: .Hearts, value: .Queen),
                             card2: Card(suit: .Diamonds, value: .Five))
        
        let player2 = Player(name: "Beth",
                             bet: 0,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let player3 = Player(name: "Charles",
                             bet: 0,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let player4 = Player(name: "Donald",
                             bet: 0,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let player5 = Player(name: "Elizabeth",
                             bet: 0,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let allPlayers = [player1, player2, player3, player4, player5]
        
        let river = [
        Card(suit: .Diamonds, value: .Ten),
        Card(suit: .Diamonds, value: .Six),
        Card(suit: .Diamonds, value: .Seven),
        Card(suit: .Diamonds, value: .Nine),
        Card(suit: .Diamonds, value: .Four)]
        
        XCTAssertEqual(decideWinner(players: allPlayers, river: river), [])
    }
    
    func test_decideWinner_oneBetsOneWinners() {
        let player1 = Player(name: "Alan",
                             bet: 0,
                             card1: Card(suit: .Hearts, value: .Queen),
                             card2: Card(suit: .Diamonds, value: .Five))
        
        let player2 = Player(name: "Beth",
                             bet: 0,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let player3 = Player(name: "Charles",
                             bet: 10,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let player4 = Player(name: "Donald",
                             bet: 0,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let player5 = Player(name: "Elizabeth",
                             bet: 0,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let allPlayers = [player1, player2, player3, player4, player5]
        
        let river = [
        Card(suit: .Diamonds, value: .Ten),
        Card(suit: .Diamonds, value: .Six),
        Card(suit: .Diamonds, value: .Seven),
        Card(suit: .Diamonds, value: .Nine),
        Card(suit: .Diamonds, value: .Four)]
        
        XCTAssertEqual(decideWinner(players: allPlayers, river: river), [player3])
    }
    
    func test_decideWinner_flushIsHighestHand() {
        let player1 = Player(name: "Alan",
                             bet: 10,
                             card1: Card(suit: .Diamonds, value: .Queen),
                             card2: Card(suit: .Diamonds, value: .Five))
        
        let player2 = Player(name: "Beth",
                             bet: 10,
                             card1: Card(suit: .Spades, value: .Jack),
                             card2: Card(suit: .Clubs, value: .Four))
        
        let player3 = Player(name: "Charles",
                             bet: 10,
                             card1: Card(suit: .Clubs, value: .Jack),
                             card2: Card(suit: .Spades, value: .Four))
        
        let player4 = Player(name: "Donald",
                             bet: 10,
                             card1: Card(suit: .Diamonds, value: .Jack),
                             card2: Card(suit: .Hearts, value: .Four))
        
        let player5 = Player(name: "Elizabeth",
                             bet: 10,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let allPlayers = [player1, player2, player3, player4, player5]
        
        let river = [
        Card(suit: .Diamonds, value: .Queen),
        Card(suit: .Clubs, value: .Six),
        Card(suit: .Diamonds, value: .Seven),
        Card(suit: .Spades, value: .Nine),
        Card(suit: .Diamonds, value: .Three)]
        
        XCTAssertEqual(decideWinner(players: allPlayers, river: river), [player1])
    }
}
