import Foundation

public enum Suit: Int, Equatable {
    case Clubs = 1
    case Diamonds = 2
    case Hearts = 3
    case Spades = 4
}

public enum Value: Int {
    case Two = 2
    case Three = 3
    case Four = 4
    case Five = 5
    case Six = 6
    case Seven = 7
    case Eight = 8
    case Nine = 9
    case Ten = 10
    case Jack = 11
    case Queen = 12
    case King = 13
    case Ace = 14
}

public struct Card: Equatable {
    public let suit: Suit
    public let value: Value
    
    public init (suit: Suit, value: Value) {
        self.suit = suit
        self.value = value
    }
}

public enum Hand: Int {
    case straightFlush = 9
    case fourOfAKind = 8
    case fullHouse = 7
    case flush = 6
    case straight = 5
    case threeOfAKind = 4
    case twoPair = 3
    case pair = 2
    case highest = 1
}
