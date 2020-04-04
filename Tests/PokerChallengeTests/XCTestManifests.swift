import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PokerChallengeTests.allTests),
        testCase(BestHandsTests.allTests)
    ]
}
#endif

#if os(Linux)
extension PokerChallengeTests {
    static var allTests : [(String, (PokerChallengeTests) -> () throws -> Void)] {
        return [
            ("test_arrayGetOrdered", test_arrayGetOrdered),
        ]
    }
}

extension BestHandsTests {
    static var allTests : [(String, (BestHandsTests) -> () throws -> Void)] {
        return [
            ("test_getBestPlayerHand_straightFlush", test_getBestPlayerHand_straightFlush),
        ]
    }
}
#endif
