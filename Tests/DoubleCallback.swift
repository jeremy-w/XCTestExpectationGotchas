import XCTest

class DoubleCallback: XCTestCase {
    func xtestDoubleTheFulfillment() {
        let promiseToCallBack = expectationWithDescription("calls back")
        let callBackDelay: NSTimeInterval = 1

        twiceAfter(seconds: callBackDelay) {
            print("i hear you calling me")
            promiseToCallBack.fulfill()
        }

        let afterCallBack = 2 * callBackDelay
        waitForExpectationsWithTimeout(afterCallBack, handler: nil)
    }


    func testSafelyDoubleTheFulfillment() {
        weak var promiseToCallBack = expectationWithDescription("calls back")
        let callBackDelay: NSTimeInterval = 1

        twiceAfter(seconds: callBackDelay) {
            guard let promise = promiseToCallBack else {
                print("once was enough, thanks!")
                return
            }

            promise.fulfill()
            promiseToCallBack = nil
        }

        let afterCallBack = 2 * callBackDelay
        waitForExpectationsWithTimeout(afterCallBack, handler: nil)
    }
}



func twiceAfter(seconds seconds: NSTimeInterval, call closure: () -> Void) {
    after(seconds: seconds) { () -> Void in
        print("now once")
        closure()

        print("now twice")
        closure()

        print("wasn't that nice?")
    }
}
