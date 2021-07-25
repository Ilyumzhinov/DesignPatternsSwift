//: Adapter Pattern. Structural.
//:
//: Adapter is realised via an instance inside a new class.
//:
//: Reference: https://refactoring.guru/design-patterns/adapter, https://www.youtube.com/watch?v=6xDBbYe11HQ
//:
//:![Adapter](Adapter.jpg)
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

struct Adapter: AdapterType {
    private let adaptee: Adaptee
    
    init(adaptee: Adaptee) {
        self.adaptee = adaptee
    }
    
    func doAtoB(_ a: A) {
        // ... some code conversion between A and B
        let b = B(a)
        adaptee.doB(b)
    }
}


// MARK: - Main
let adapter: AdapterType = Adapter(adaptee: Adaptee())
adapter.doAtoB(123)
