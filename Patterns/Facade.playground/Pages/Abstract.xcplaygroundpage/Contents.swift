//: Facade Pattern. Structural.
//:
//: Reference: https://refactoring.guru/design-patterns/facade
//:
//:![Facade](Facade.jpg)
// MARK: - System/Library/Framework
struct System {
    // ... some internal types
    struct AClass { let a: Bool }
    struct BClass { let b: Int }
    struct CClass { let c: String }
    struct DClass {
        let a: AClass, b: BClass, c: CClass
    }
    
    // ... some internal functions
    func method1(_ a: Bool) -> AClass {
        .init(a: a)
    }
    func method2(_ b: Int) -> BClass {
        .init(b: b)
    }
    func method3(_ c: String) -> CClass {
        .init(c: c)
    }
}


// MARK: - Facade
extension System {
    /// Exposes a user friendly method
    func facade(_ a: Bool, _ b: Int, _ c: String) -> DClass {
        // ... calling/using a lot of internal methods and structures
        let A = method1(a),
            B = method2(b),
            C = method3(c)
        
        return .init(a: A, b: B, c: C)
    }
}


// MARK: - Main
// Without facade
let system = System()
let d = System.DClass.init(a: system.method1(false), b: system.method2(1), c: system.method3("hello"))
print(d)

// With Facade
let d2 = system.facade(false, 1, "hello")
print(d2)
