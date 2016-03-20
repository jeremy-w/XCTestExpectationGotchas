# XCTestExpectation Gotchas

[Read the Article!](https://jeremywsherman.com/blog/2016/03/19/xctestexpectation-gotchas/)

This repository contains the code that accompanies that article.
For more information about the code, you'll want to read that.


## Building
- Run `carthage bootstrap` to build Deferred and its dependencies.
- Open the .xcodeproj file.
- Hit Cmd-u to run the unit tests.
    - Don't worry if you get one test failure:
      `LateCallback.testPreparedForNotWaitingLongEnough()`
      is supposed to fail, unlike its cousin,
      `testNotWaitingLongEnough()`, which takes out the entire
      process rather than simply failing.


## Configuration
Swift is changing quickly.
For your convenience, here's the versions of All The Things
that this code was originally written against:

```
Apple Swift version 2.1.1 (swiftlang-700.1.101.15 clang-700.1.81)
Target: x86_64-apple-darwin14.5.0

Xcode 7.2.1
Build version 7C1002

ProductName:	Mac OS X
ProductVersion:	10.10.5
BuildVersion:	14F1605
```


## License
The code is licensed under the [ISC license.](LICENSE-ISC.txt)

You're unlikely to actually need to directly use any of the code;
it's really just an example of pitfalls and workarounds
that you'll be able to apply from memory,
but a clear license beats none, so.
