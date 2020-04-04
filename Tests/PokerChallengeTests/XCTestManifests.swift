import XCTest

#if !canImport(ObjectiveC)
extension PokerChallengeTests {
    static let __allTests__PokerChallengeTests = [
            ("test_arrayGetOrdered", test_arrayGetOrdered),
        ]
    }
}

extension BestHandsTests {
    static let __allTests__BestHandsTests = [
            ("test_getBestPlayerHand_straightFlush", test_getBestPlayerHand_straightFlush),
        ]
    }
}

public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PokerChallengeTests.__allTests__PokerChallengeTests),
        testCase(BestHandsTests.__allTests__BestHandsTests),
    ]
}
#endif
