import XCTest
@testable import PokerChallenge

final public class PokerChallengeTests: XCTestCase {
    func test_arrayGetOrdered() {
        let array = [Card(suit: .Clubs, value: .Two), Card(suit: .Clubs, value: .Six), Card(suit: .Clubs, value: .Three), Card(suit: .Clubs, value: .Four), Card(suit: .Clubs, value: .Nine), Card(suit: .Clubs, value: .Eight), Card(suit: .Clubs, value: .Queen),]
        XCTAssertEqual(array.getOrdered(), [Card(suit: .Clubs, value: .Queen), Card(suit: .Clubs, value: .Nine), Card(suit: .Clubs, value: .Eight), Card(suit: .Clubs, value: .Six), Card(suit: .Clubs, value: .Four), Card(suit: .Clubs, value: .Three), Card(suit: .Clubs, value: .Two)])
    }
    
    func test_arrayGetOrderedHand_returns5HighestCards() {
        let array = [Card(suit: .Clubs, value: .Two), Card(suit: .Clubs, value: .Six), Card(suit: .Clubs, value: .Three), Card(suit: .Clubs, value: .Four), Card(suit: .Clubs, value: .Nine), Card(suit: .Clubs, value: .Eight), Card(suit: .Clubs, value: .Queen),]
        XCTAssertEqual(array.getOrderedHand(), [Card(suit: .Clubs, value: .Queen), Card(suit: .Clubs, value: .Nine), Card(suit: .Clubs, value: .Eight), Card(suit: .Clubs, value: .Six), Card(suit: .Clubs, value: .Four)])
    }
    
    func test_cards_returnsIfPlayerHasHand() {
        let player = Player(name: "Alan", bet: 11.00, card1: Card(suit: .Clubs, value: .Three), card2: Card(suit: .Hearts, value: .Eight))
        let cards = getCards(river: [], hand: player.hand)
        
        XCTAssertEqual([Card(suit: .Clubs, value: .Three), Card(suit: .Hearts, value: .Eight)], cards)
    }
    
    func test_cards_returnsIfPlayerHasHandAndRiver() {
        let player = Player(name: "Alan", bet: 11.00, card1: Card(suit: .Clubs, value: .Three), card2: Card(suit: .Hearts, value: .Eight))
        let cards = getCards(river: [Card(suit: .Clubs, value: .Two), Card(suit: .Clubs, value: .Six)], hand: player.hand)
        
        XCTAssertEqual([Card(suit: .Clubs, value: .Two), Card(suit: .Clubs, value: .Six), Card(suit: .Clubs, value: .Three), Card(suit: .Hearts, value: .Eight)], cards)
    }
    
    func test_cards_returnsOnlyPassedRiver() {
        let cards = getCards(river: [Card(suit: .Clubs, value: .Two), Card(suit: .Clubs, value: .Six)], hand: nil)
        
        XCTAssertEqual([Card(suit: .Clubs, value: .Two), Card(suit: .Clubs, value: .Six)], cards)
    }
    
    func test_getFlush_returnsNilIfNoFlush() {
        let array = [
            Card(suit: .Clubs, value: .Two),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Hearts, value: .Three),
            Card(suit: .Spades, value: .Four),
            Card(suit: .Clubs, value: .Nine)]
        
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .Three),
                            card2: Card(suit: .Hearts, value: .Eight))
        
        let flush = getFlush(player: player, river: array)
        XCTAssertEqual(flush, nil)
    }
    
    func test_getFlush_returnsSuitIfFlush() {
        let array = [
            Card(suit: .Clubs, value: .Two),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Diamonds, value: .Three),
            Card(suit: .Diamonds, value: .Four),
            Card(suit: .Clubs, value: .Nine)]
        
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .Three),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let flush = getFlush(player: player, river: array)
        XCTAssertEqual(flush, .Diamonds)
    }
    
    func test_getFlushHand_returnsCardsIfFlushOrdered() {
        let array = [
            Card(suit: .Clubs, value: .Two),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Diamonds, value: .Four),
            Card(suit: .Clubs, value: .Nine)]
        
        let expected = [
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Diamonds, value: .Four),
            Card(suit: .Diamonds, value: .Three)]
        
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .Three),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let flush = getBestFlushHand(player: player, river: array)
        XCTAssertEqual(flush, expected)
    }
    
    func test_getFlushHand_returnsHighestFlush() {
        let array = [
            Card(suit: .Clubs, value: .Two),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected = [
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Diamonds, value: .Four)]
        
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .Three),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let flush = getBestFlushHand(player: player, river: array)
        XCTAssertEqual(flush, expected)
    }
    
    func test_getFlushHand_returnsEmptyArrayIfNoFlush() {
        let array = [
            Card(suit: .Clubs, value: .Two),
            Card(suit: .Hearts, value: .Six),
            Card(suit: .Spades, value: .Seven),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = []
        
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .Three),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let flush = getBestFlushHand(player: player, river: array)
        XCTAssertEqual(flush, expected)
    }
    
    func test_getStraightHand_highestCardIsInStraigh() {
        let array = [
            Card(suit: .Clubs, value: .Two),
            Card(suit: .Hearts, value: .Six),
            Card(suit: .Spades, value: .Seven),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = [
            Card(suit: .Diamonds, value: .Ten),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Spades, value: .Seven),
            Card(suit: .Hearts, value: .Six)]
        
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .Ten),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let straight = getStraightHand(player: player, river: array)
        XCTAssertEqual(straight, expected)
    }
    
    func test_getStraightHand_2ndHighestCardStartsStraight() {
        let array = [
            Card(suit: .Clubs, value: .Ten),
            Card(suit: .Hearts, value: .Six),
            Card(suit: .Spades, value: .Seven),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = [
            Card(suit: .Clubs, value: .Ten),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Spades, value: .Seven),
            Card(suit: .Hearts, value: .Six)]
        
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .King),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let straight = getStraightHand(player: player, river: array)
        XCTAssertEqual(straight, expected)
    }
    
    func test_getStraightHand_NoStraight() {
        let array = [
            Card(suit: .Clubs, value: .Ten),
            Card(suit: .Hearts, value: .Six),
            Card(suit: .Spades, value: .Seven),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = []
        
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .King),
                            card2: Card(suit: .Spades, value: .Four))
        
        let straight = getStraightHand(player: player, river: array)
        XCTAssertEqual(straight, expected)
    }
    
    func test_straightFlush_DoesntExist() {
        let array = [
            Card(suit: .Diamonds, value: .Ten),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = []
        
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .King),
                            card2: Card(suit: .Diamonds, value: .Ace))
        
        let straight = getStraightFlush(player: player, river: array)
        XCTAssertEqual(straight, expected)
    }
    
    func test_straightFlush_Exists() {
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
        
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .King),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let straight = getStraightFlush(player: player, river: array)
        XCTAssertEqual(straight, expected)
    }
    
    func test_getFourOfAKind() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Spades, value: .Seven),
                            card2: Card(suit: .Diamonds, value: .Seven))
        
        let array = [
            Card(suit: .Clubs, value: .Seven),
            Card(suit: .Hearts, value: .Seven),
            Card(suit: .Hearts, value: .Six),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Spades, value: .Six)]
        
        let expected = [
            Card(suit: .Clubs, value: .Seven),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Hearts, value: .Seven),
            Card(suit: .Spades, value: .Seven),
            Card(suit: .Diamonds, value: .Six)]
        
        XCTAssertEqual(getFourOfAKind(player: player, river: array), expected)
    }
    
    func test_getFourOfAKind_HighestIsGotFromPlayer() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Spades, value: .Seven),
                            card2: Card(suit: .Diamonds, value: .Nine))
        
        let array = [
            Card(suit: .Clubs, value: .Seven),
            Card(suit: .Hearts, value: .Seven),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Diamonds, value: .Six)]
        
        let expected = [
            Card(suit: .Clubs, value: .Seven),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Hearts, value: .Seven),
            Card(suit: .Spades, value: .Seven),
            Card(suit: .Diamonds, value: .Nine)]
        
        XCTAssertEqual(getFourOfAKind(player: player, river: array), expected)
    }
    
    func test_getFourOfAKind_HighestIsGotFromRiver() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Spades, value: .Seven),
                            card2: Card(suit: .Diamonds, value: .Nine))
        
        let array = [
            Card(suit: .Clubs, value: .Seven),
            Card(suit: .Hearts, value: .Seven),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Diamonds, value: .Ten)]
        
        let expected = [
            Card(suit: .Clubs, value: .Seven),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Hearts, value: .Seven),
            Card(suit: .Spades, value: .Seven),
            Card(suit: .Diamonds, value: .Ten)]
        
        XCTAssertEqual(getFourOfAKind(player: player, river: array), expected)
    }
    
    func test_getFourOfAKind_NoFourOfAKind() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Spades, value: .Seven),
                            card2: Card(suit: .Diamonds, value: .Nine))
        
        let array = [
            Card(suit: .Clubs, value: .Seven),
            Card(suit: .Hearts, value: .Eight),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Diamonds, value: .Six),
            Card(suit: .Diamonds, value: .Ten)]
        
        XCTAssertEqual(getFourOfAKind(player: player, river: array), [])
    }
    
    func test_getFullHouse_8sAnd9s() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .King),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let array = [
            Card(suit: .Spades, value: .Eight),
            Card(suit: .Hearts, value: .Eight),
            Card(suit: .Clubs, value: .Nine),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = [
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Hearts, value: .Eight),
            Card(suit: .Spades, value: .Eight),
            Card(suit: .Clubs, value: .Nine),
            Card(suit: .Diamonds, value: .Nine)]
        
        let hand = getFullHouseHand(player: player, river: array)
        XCTAssertEqual(hand, expected)
    }
    
    func test_getFullHouse_emptyReturn() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .King),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let array = [
            Card(suit: .Spades, value: .Eight),
            Card(suit: .Hearts, value: .Eight),
            Card(suit: .Clubs, value: .Nine),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = []
        
        let hand = getFullHouseHand(player: player, river: array)
        XCTAssertEqual(hand, expected)
    }
    
    func test_getFullHouse_fromRiver() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .King),
                            card2: Card(suit: .Diamonds, value: .Seven))
        
        let array = [
            Card(suit: .Spades, value: .Eight),
            Card(suit: .Hearts, value: .Eight),
            Card(suit: .Clubs, value: .Nine),
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Diamonds, value: .Nine)]
        
        let expected: [Card] = [
        Card(suit: .Diamonds, value: .Eight),
        Card(suit: .Hearts, value: .Eight),
        Card(suit: .Spades, value: .Eight),
        Card(suit: .Clubs, value: .Nine),
        Card(suit: .Diamonds, value: .Nine)]
        
        let hand = getFullHouseHand(player: player, river: array)
        XCTAssertEqual(hand, expected)
    }
    
    func test_threeOfAKind() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .King),
                            card2: Card(suit: .Diamonds, value: .Eight))
        
        let array = [
            Card(suit: .Spades, value: .Eight),
            Card(suit: .Hearts, value: .Eight),
            Card(suit: .Clubs, value: .Nine),
            Card(suit: .Diamonds, value: .Seven),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = [
        Card(suit: .Diamonds, value: .Eight),
        Card(suit: .Hearts, value: .Eight),
        Card(suit: .Spades, value: .Eight),
        Card(suit: .Diamonds, value: .King),
        Card(suit: .Clubs, value: .Nine)]
        
        let hand = getThreeOfAKindHand(player: player, river: array)
        XCTAssertEqual(hand, expected)
    }
    
    func test_threeOfAKind_fromRiver_highFromHand() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .King),
                            card2: Card(suit: .Diamonds, value: .Queen))
        
        let array = [
            Card(suit: .Spades, value: .Eight),
            Card(suit: .Hearts, value: .Eight),
            Card(suit: .Clubs, value: .Nine),
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = [
        Card(suit: .Diamonds, value: .Eight),
        Card(suit: .Hearts, value: .Eight),
        Card(suit: .Spades, value: .Eight),
        Card(suit: .Diamonds, value: .King),
        Card(suit: .Diamonds, value: .Queen)]
        
        let hand = getThreeOfAKindHand(player: player, river: array)
        XCTAssertEqual(hand, expected)
    }
    
    func test_twoPair_threePossiblePairsTakesHighestTwo() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .Queen),
                            card2: Card(suit: .Diamonds, value: .King))
        
        let array = [
            Card(suit: .Spades, value: .King),
            Card(suit: .Hearts, value: .Queen),
            Card(suit: .Clubs, value: .Jack),
            Card(suit: .Diamonds, value: .Jack),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = [
        Card(suit: .Diamonds, value: .King),
        Card(suit: .Spades, value: .King),
        Card(suit: .Diamonds, value: .Queen),
        Card(suit: .Hearts, value: .Queen),
        Card(suit: .Clubs, value: .Jack)]
        
        let hand = getTwoPairHand(player: player, river: array)
        XCTAssertEqual(hand, expected)
    }
    
    func test_twoPair_fromRiver() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .Nine),
                            card2: Card(suit: .Diamonds, value: .Jack))
        
        let array = [
            Card(suit: .Spades, value: .King),
            Card(suit: .Hearts, value: .Queen),
            Card(suit: .Clubs, value: .King),
            Card(suit: .Diamonds, value: .Queen),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = [
        Card(suit: .Clubs, value: .King),
        Card(suit: .Spades, value: .King),
        Card(suit: .Diamonds, value: .Queen),
        Card(suit: .Hearts, value: .Queen),
        Card(suit: .Diamonds, value: .Jack)]
        
        let hand = getTwoPairHand(player: player, river: array)
        XCTAssertEqual(hand, expected)
    }
    
    func test_pair_fromRiverWithHighCard() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .Nine),
                            card2: Card(suit: .Diamonds, value: .Ace))
        
        let array = [
            Card(suit: .Spades, value: .King),
            Card(suit: .Hearts, value: .Queen),
            Card(suit: .Clubs, value: .King),
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = [
        Card(suit: .Clubs, value: .King),
        Card(suit: .Spades, value: .King),
        Card(suit: .Diamonds, value: .Ace),
        Card(suit: .Hearts, value: .Queen),
        Card(suit: .Diamonds, value: .Nine)]
        
        let hand = getPairHand(player: player, river: array)
        XCTAssertEqual(hand, expected)
    }
    
    func test_pair_fromHandAndRiverWithHighCard() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Diamonds, value: .Nine),
                            card2: Card(suit: .Diamonds, value: .Queen))
        
        let array = [
            Card(suit: .Spades, value: .Ace),
            Card(suit: .Hearts, value: .Queen),
            Card(suit: .Clubs, value: .King),
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = [
        Card(suit: .Diamonds, value: .Queen),
        Card(suit: .Hearts, value: .Queen),
        Card(suit: .Spades, value: .Ace),
        Card(suit: .Clubs, value: .King),
        Card(suit: .Diamonds, value: .Nine)]
        
        let hand = getPairHand(player: player, river: array)
        XCTAssertEqual(hand, expected)
    }
    
    func test_pair_fromHandWithHighCard() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Hearts, value: .Queen),
                            card2: Card(suit: .Diamonds, value: .Queen))
        
        let array = [
            Card(suit: .Spades, value: .Ace),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Clubs, value: .King),
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = [
        Card(suit: .Diamonds, value: .Queen),
        Card(suit: .Hearts, value: .Queen),
        Card(suit: .Spades, value: .Ace),
        Card(suit: .Clubs, value: .King),
        Card(suit: .Diamonds, value: .Nine)]
        
        let hand = getPairHand(player: player, river: array)
        XCTAssertEqual(hand, expected)
    }
    
    func test_pair_noPair() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Hearts, value: .Queen),
                            card2: Card(suit: .Diamonds, value: .Five))
        
        let array = [
            Card(suit: .Spades, value: .Ace),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Clubs, value: .King),
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = []
        
        let hand = getPairHand(player: player, river: array)
        XCTAssertEqual(hand, expected)
    }
    
    func test_highestCard() {
        let player = Player(name: "Alan",
                            bet: 11.00,
                            card1: Card(suit: .Hearts, value: .Queen),
                            card2: Card(suit: .Diamonds, value: .Five))
        
        let array = [
            Card(suit: .Spades, value: .Ace),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Clubs, value: .King),
            Card(suit: .Diamonds, value: .Eight),
            Card(suit: .Diamonds, value: .Four)]
        
        let expected: [Card] = [
            Card(suit: .Spades, value: .Ace),
            Card(suit: .Clubs, value: .King),
            Card(suit: .Hearts, value: .Queen),
            Card(suit: .Diamonds, value: .Nine),
            Card(suit: .Diamonds, value: .Eight),
        ]
        
        XCTAssertEqual(getHighestCardHand(player: player, river: array), expected)
    }
    
    func test_getAllPlayersWhoBetEnoughToPlay() {
        let player1 = Player(name: "Alan",
                             bet: 12.00,
                             card1: Card(suit: .Hearts, value: .Queen),
                             card2: Card(suit: .Diamonds, value: .Five))
        
        let player2 = Player(name: "Beth",
                             bet: 10.00,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let player3 = Player(name: "Charles",
                             bet: 11.00,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let player4 = Player(name: "Donald",
                             bet: 12.00,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let player5 = Player(name: "Elizabeth",
                             bet: 11.00,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let allPlayers = [player1, player2, player3, player4, player5]
        let expectedPlayers = [player1, player4]
        
        XCTAssertEqual(allPlayers.getAllPlayersWhoBetEnoughToPlay(), expectedPlayers)
        
    }
    
    func test_getAllPlayersWhoBetEnoughToPlay_everyonePlays() {
        let player1 = Player(name: "Alan",
                             bet: 12.00,
                             card1: Card(suit: .Hearts, value: .Queen),
                             card2: Card(suit: .Diamonds, value: .Five))
        
        let player2 = Player(name: "Beth",
                             bet: 12.00,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let player3 = Player(name: "Charles",
                             bet: 12.00,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let player4 = Player(name: "Donald",
                             bet: 12.00,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let player5 = Player(name: "Elizabeth",
                             bet: 12.00,
                             card1: Card(suit: .Hearts, value: .Jack),
                             card2: Card(suit: .Diamonds, value: .Four))
        
        let allPlayers = [player1, player2, player3, player4, player5]
        
        XCTAssertEqual(allPlayers.getAllPlayersWhoBetEnoughToPlay(), allPlayers)
        
    }
    
    func test_getAllPlayersWhoBetEnoughToPlay_bet0() {
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
        
        XCTAssertEqual(allPlayers.getAllPlayersWhoBetEnoughToPlay(), [])
        
    }
}
    
