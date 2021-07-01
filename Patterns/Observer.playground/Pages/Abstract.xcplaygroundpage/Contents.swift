//: Observer Pattern. Behavioral.
//:
//: Reference: https://refactoring.guru/design-patterns/observer
//:
//:![Observer](Observer.heic)
// MARK: - Observer
protocol ObserverType {
    func update()
    
    // Make the types equatable
    var id: Int { get }
    func isEqual(another: ObserverType) -> Bool
}
extension ObserverType {
    func isEqual(another: ObserverType) -> Bool {
        self.id == another.id
    }
}
// Implementation
struct ObserverView: ObserverType {
    var id: Int
    
    func update() {
        // ... change Observer state according to Publisher
        print("Update UI")
    }
}


// MARK: - Publisher
struct Publisher {
    static var subscribers: [ObserverType] = []
    static var state: Int = 0
    
    static func subscribe(_ subscriber: ObserverType) {
        subscribers.append(subscriber)
    }
    
    static func unsubscribe(_ subscriber: ObserverType) {
        subscribers.removeAll { sub in sub.isEqual(another: subscriber) }
    }
    
    static func notify() {
        subscribers.map { sub in sub.update() }
    }
    
    static func do_stuff() {
        // ... some Publisher state change
        state = 1
        notify()
    }
}


// MARK: - Main
let myView: ObserverView = .init(id: 1)
Publisher.subscribe(myView)
Publisher.do_stuff()
