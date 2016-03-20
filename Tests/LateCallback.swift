import XCTest

func after(seconds seconds: NSTimeInterval, call closure: () -> Void) {
    let delay = dispatch_time(
        DISPATCH_TIME_NOW,
        Int64(seconds) * numericCast(NSEC_PER_SEC))
    let ontoQueue = dispatch_get_main_queue()
    dispatch_after(delay, ontoQueue) {
        print("\(seconds): finished waiting")
        closure()
        print("\(seconds): all done here")
    }
}



class LateCallback: XCTestCase {
    let callBackDelay: NSTimeInterval = 2


    func testNotWaitingLongEnough() {
        let promiseToCallBack = expectationWithDescription("calls back")
        after(seconds: callBackDelay) { () -> Void in
            print("I knew you'd call!")
            promiseToCallBack.fulfill()
        }

        waitForExpectationsWithTimeout(callBackDelay / 2) { error in
            print("Aww, we timed out: \(error)")
        }
    }
}
