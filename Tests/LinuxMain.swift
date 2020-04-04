import XCTest

import PokerChallengeTests

var tests = [XCTestCaseEntry]()
tests += PokerChallengeTests.allTests()
tests += BestHandTests.allTests()
XCTMain(tests)
