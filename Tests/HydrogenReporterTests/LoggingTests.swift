import XCTest
@testable import HydrogenReporter

final class LoggingTests: XCTestCase {
    func testLogging() {
        let n = 100000
        for i in 0..<n {
            LOG(i)
        }
        
        XCTAssert(Logger.shared.logs.count == n)
    }

    func testParellelLogging() {
        let n = 100000

        DispatchQueue.concurrentPerform(iterations: n) { (index) in
             LOG(index)
        }
    }
}
