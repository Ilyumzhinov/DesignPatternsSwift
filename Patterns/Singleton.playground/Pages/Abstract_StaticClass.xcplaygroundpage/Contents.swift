//: Singleton Pattern. Creational.
//:
//: Implemented as a static class.
//:
//: Reference: https://stackoverflow.com/questions/519520/difference-between-static-class-and-singleton-pattern
// MARK: - Singleton
final class Singleton {
    // No instantiation allowed
    private init() { }
    
    // ... some shared state like attributes and functions
    static let data: Int = 1
    static func businessLogic() -> Int {
        data + 1
    }
}


// MARK: - Main
Singleton.data
Singleton.businessLogic()
