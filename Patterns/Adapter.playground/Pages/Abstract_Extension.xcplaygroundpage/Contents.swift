//: Adapter Pattern. Structural.
//:
//: Adapter is realised via an extension. Similar to realisation via class inheritance and interface conformance.
//:
//: Reference: https://refactoring.guru/design-patterns/adapter, https://www.youtube.com/watch?v=6xDBbYe11HQ
//:
//:![Adapter](Adapter_Extension.jpg)
typealias A = Int
typealias B = String


// MARK: - Service
struct Adaptee {
    func doB(_ b: B) {
        print("Performs B: \(b)")
    }
}


// MARK: - Adapter
protocol AdapterType {
    func doAtoB(_ a: A)
}

extension Adaptee: AdapterType {
    func doAtoB(_ a: A) {
        // ... some code conversion between A and B
        let b = B(a)
        doB(b)
    }
}


// MARK: - Main
let adapter: AdapterType = Adaptee()
adapter.doAtoB(123)
