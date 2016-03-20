import XCTest
import Deferred


class BringYourOwnPromises: XCTestCase {
    func testGettingAPony() {
        let anyDelay: NSTimeInterval = 1
        let futurePony = giveMeAPony(after: anyDelay)

        let longEnough = anyDelay + 1
        guard let pony = futurePony.wait(.Interval(longEnough)) else {
            XCTFail("no pony ;_;")
            return
        }

        print("we got a pony! \(pony)")
    }


    func testWhenImpatientNoPonyForYou() {
        let anyDelay: NSTimeInterval = 1
        let futurePony = giveMeAPony(after: anyDelay)

        guard let pony = futurePony.wait(.Now) else {
            print("no patience, no pony")
            return
        }

        XCTFail("we got a pony???! \(pony)")
    }
}



func giveMeAPony(after seconds: NSTimeInterval) -> Future<Pony> {
    let eventualPony: Deferred<Pony> = Deferred()
    after(seconds: seconds) {
        let pony = Pony()
        print("dreams come true, have a pony: \(pony)")
        eventualPony.fill(pony)
    }
    return Future(eventualPony)
}



class Pony {}
