//: Composite Pattern. Structural.
//:
//: Reference: https://refactoring.guru/design-patterns/composite
//:
//:![Composite](Composite.jpg)
// MARK: - Component
protocol ComponentType {
    // Calculates value sum.
    func operation() -> Int
}
// Leaf
struct Leaf: ComponentType {
    var value: Int
    
    func operation() -> Int {
        value
    }
}
// Composite
struct Composite: ComponentType {
    var children: [ComponentType]
    
    func operation() -> Int {
        func tranverse(_ component: ComponentType) -> Int {
            if component is Leaf {
                return component.operation()
            }
            if let composite = component as? Composite {
                return composite.children.map(tranverse).reduce(0, +)
            }
            
            return 0
        }
        
        return tranverse(self)
    }
}


// MARK: - Main
let branch_left: Composite = .init(children: [Leaf(value: 3), Leaf(value: 7)]),
    branch_right: Composite = .init(children: [
        Composite(children: [Leaf(value: 11), Leaf(value: 4)]),
        Leaf(value: 10)
    ])

let root: Composite = .init(children: [branch_left, branch_right])
root.operation()
