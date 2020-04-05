import XCTest
@testable import PokerChallenge

final public class BestHandsTests: XCTestCase {
    
    func test_getBestPlayerHand_straightFlush() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .King),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let array = [
            Card(suit: .Diamonds, value: .Ten),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = [
            Card(suit: .Diamonds, value: .Ten),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Diamonds, value: .Six)]
        
        XCTAssertEqual(player.getBestHand(river: array).cards, expected)
        XCTAssertEqual(player.getBestHand(river: array).hand, .straightFlush)
    }
    
    func test_getBestPlayerHand_flushGotStraightAvailable() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .King),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let array = [
            Card(suit: .Hearts, value: .Five),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = [
            Card(suit: .Diamonds, value: .King),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Diamonds, value: .Six)]
        
        XCTAssertEqual(player.getBestHand(river: array).cards, expected)
        XCTAssertEqual(player.getBestHand(river: array).hand, .flush)
    }
    
    func test_bestHand_fourOfAKind() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .King),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let array = [
            Card(suit: .Hearts, value: .Eight),
            Card(suit: .Spades, value: .Eight),
            Card(suit: .Clubs, value: .Eight),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = [
            Card(suit: .Clubs, value: .Eight),
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Hearts, value: .Eight),
            Card(suit: .Spades, value: .Eight),
            Card(suit: .Diamonds, value: .King)]
        
        let bestHand = player.getBestHand(river: array)
        XCTAssertEqual(bestHand.cards, expected)
        XCTAssertEqual(bestHand.hand, .fourOfAKind)
    }
    
    func test_bestHand_bestFullHouse() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .Seven),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let array = [
            Card(suit: .Hearts, value: .Eight),
            Card(suit: .Spades, value: .Eight),
            Card(suit: .Clubs, value: .Nine),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Hearts, value: .Seven)]
        
        let expected: [Card] = [
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Hearts, value: .Eight),
            Card(suit: .Spades, value: .Eight),
            Card(suit: .Clubs, value: .Nine),
            Card(suit: .Diamonds, value: .Nine)]
        
        let bestHand = player.getBestHand(river: array)
        XCTAssertEqual(bestHand.cards, expected)
        XCTAssertEqual(bestHand.hand, .fullHouse)
    }
    
    func test_bestHand_bestThreeOfAKind() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .Seven),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let array = [
            Card(suit: .Hearts, value: .Eight),
            Card(suit: .Spades, value: .Eight),
            Card(suit: .Clubs, value: .Nine),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Hearts, value: .Four)]
        
        let expected: [Card] = [
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Hearts, value: .Eight),
            Card(suit: .Spades, value: .Eight),
            Card(suit: .Clubs, value: .Nine),
            Card(suit: .Diamonds, value: .Seven)]
        
        let bestHand = player.getBestHand(river: array)
        XCTAssertEqual(bestHand.cards, expected)
        XCTAssertEqual(bestHand.hand, .threeOfAKind)
    }
    
    func test_bestHand_bestTwoPair() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .Seven),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let array = [
            Card(suit: .Hearts, value: .Seven),
            Card(suit: .Spades, value: .Eight),
            Card(suit: .Clubs, value: .Nine),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Hearts, value: .Four)]
        
        let expected: [Card] = [
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Spades, value: .Eight),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Hearts, value: .Seven),
            Card(suit: .Clubs, value: .Nine)]
        
        let bestHand = player.getBestHand(river: array)
        XCTAssertEqual(bestHand.cards, expected)
        XCTAssertEqual(bestHand.hand, .twoPair)
    }
    
    func test_bestHand_bestPair() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .Seven),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let array = [
            Card(suit: .Hearts, value: .Seven),
            Card(suit: .Spades, value: .Two),
            Card(suit: .Clubs, value: .Nine),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Hearts, value: .Four)]
        
        let expected: [Card] = [
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Hearts, value: .Seven),
            Card(suit: .Clubs, value: .Nine),
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Diamonds, value: .Six)]
        
        let bestHand = player.getBestHand(river: array)
        XCTAssertEqual(bestHand.cards, expected)
        XCTAssertEqual(bestHand.hand, .pair)
    }
    
    func test_bestHand_bestHighest() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .Two),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let array = [
            Card(suit: .Hearts, value: .Seven),
            Card(suit: .Spades, value: .Three),
            Card(suit: .Clubs, value: .Nine),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Hearts, value: .Four)]
        
        let expected: [Card] = [
            Card(suit: .Clubs, value: .Nine),
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Hearts, value: .Seven),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Hearts, value: .Four)]
        
        let bestHand = player.getBestHand(river: array)
        XCTAssertEqual(bestHand.cards, expected)
        XCTAssertEqual(bestHand.hand, .highest)
    }
}
