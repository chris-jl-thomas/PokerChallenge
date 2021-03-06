import Foundation

extension Sequence {
    public func pairwise() -> AnyIterator<(Element, Element)> {
        var it = makeIterator()
        guard var last_value = it.next() else { return AnyIterator{ return nil } }

        return AnyIterator {
            guard let value = it.next() else { return nil }
            defer { last_value = value }
            return (last_value, value)
        }
    }
}

extension Sequence {
    public func all(pass predicate: (Element) -> Bool) -> Bool {
        // If nothing is false, everything is true
        return !self.contains(where: { !predicate($0) })
    }
}

extension Sequence {
    public func passesForConsecutiveValues(_ predicate:(Element, Element) -> Bool) -> Bool {
        return pairwise().all(pass: predicate)
    }
}

extension Array where Element == Card {
    public func getOrderedHand() -> [Card] {
        Array(self
            .getOrdered()
            .prefix(5)
        )
    }
    
    public func getOrdered() -> [Card] {
        Array(self
            .sorted { $0.value.rawValue > $1.value.rawValue }
        )
    }
    
    public func orderBySuit() -> [Card] {
        Array(self
            .sorted { $0.suit.rawValue < $1.suit.rawValue }
        )
    }
}

extension Array where Element == Card {
    func remove(where value: Value) -> [Card] {
        self.filter { $0.value != value }
    }
}

extension Array where Element: Hashable {
    public func toDictionary(with selectValue: (Element) -> BestHand) -> [Element: BestHand] {
        var dict = [Element: BestHand]()
        for element in self {
            let result = selectValue(element)
            dict[element] = BestHand(cards: result.cards, hand: result.hand)
        }
        return dict
    }
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

