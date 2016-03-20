import XCTest

class LateCallback: XCTestCase {
    let callBackDelay: NSTimeInterval = 2


    func xtestNotWaitingLongEnough() {
        let promiseToCallBack = expectationWithDescription("calls back")
        after(seconds: callBackDelay) { () -> Void in
            print("I knew you'd call!")
            promiseToCallBack.fulfill()
        }

        waitForExpectationsWithTimeout(callBackDelay / 2) { error in
            print("Aww, we timed out: \(error)")
        }
    }


    func testPreparedForNotWaitingLongEnough() {
        weak var promiseToCallBack = expectationWithDescription("calls back")
        after(seconds: callBackDelay) { () -> Void in
            guard let promise = promiseToCallBack else {
                print("too late, buckaroo")
                return
            }

            print("I knew you'd call!")
            promise.fulfill()
        }

        waitForExpectationsWithTimeout(callBackDelay / 2) { error in
            print("Aww, we timed out: \(error)")
        }
    }


    func testZzz() {
        print("Let's just wait a while…")
        let tillAfterCallBack = callBackDelay
        spin(forSeconds: tillAfterCallBack)
        print("Yawn, that was boring.")
    }
}



func after(seconds seconds: NSTimeInterval, call closure: () -> Void) {
    let delay = dispatch_time(
        DISPATCH_TIME_NOW,
        Int64(seconds) * numericCast(NSEC_PER_SEC))
    let ontoQueue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
    dispatch_after(delay, ontoQueue) {
        print("\(seconds): finished waiting")
        closure()
        print("\(seconds): all done here")
    }
}



func spin(forSeconds seconds: NSTimeInterval) {
    let afterCallBack = NSDate(timeIntervalSinceNow: seconds)
    NSRunLoop.mainRunLoop().runUntilDate(afterCallBack)
}
