//: Singleton Pattern. Creational.
//:
//: Reference: https://refactoring.guru/design-patterns/singleton, https://stackoverflow.com/questions/519520/difference-between-static-class-and-singleton-pattern
//:
//:![Singleton](Singleton.jpg)
// MARK: - Singleton
final class Singleton {
    private static var uniqueInstance: Singleton? = nil
    
    private init() { }
    
    static func instance() -> Singleton {
        guard let uniqueInstance = Singleton.uniqueInstance else {
            uniqueInstance = .init()
            return uniqueInstance!
        }
        
        return uniqueInstance
    }
    
    // ... some shared state like attributes and functions
    let data: Int = 1
    func businessLogic() -> Int {
        data + 1
    }
}


// MARK: - Main
let singleton = Singleton.instance(),
    singleton2 = Singleton.instance()

singleton.data
singleton2.data
singleton.businessLogic()
singleton2.businessLogic()
