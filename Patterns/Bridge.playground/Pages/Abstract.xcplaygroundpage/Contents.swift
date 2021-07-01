//: Bridge Pattern. Structural.
//:
//: Reference: https://refactoring.guru/design-patterns/bridge
//:
//:![Bridge](Bridge.png)
// MARK: - Abstraction
struct Abstraction {
    let implementation: ImplementationType
    
    // Features available everywhere
    func feature1() -> String {
        implementation.method1()
    }
    func feature2() -> String {
        implementation.method2()
    }
}


// MARK: - Implementation
protocol ImplementationType {
    func method1() -> String
    func method2() -> String
}
// Implementation
struct MacImplementation: ImplementationType {
    func method1() -> String { "GUI drawn using AppKit" }
    func method2() -> String { "mySQL query" }
}
struct IOSImplementation: ImplementationType {
    func method1() -> String { "GUI drawn using UIKit" }
    func method2() -> String { "SQLite query" }
}


// MARK: - Main
let mac = Abstraction(implementation: MacImplementation())
mac.feature1()
mac.feature2()

let ios = Abstraction(implementation: IOSImplementation())
ios.feature1()
ios.feature2()
