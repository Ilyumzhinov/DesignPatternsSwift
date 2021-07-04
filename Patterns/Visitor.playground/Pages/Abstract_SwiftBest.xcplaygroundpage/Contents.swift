//: Visitor Pattern. Behavioral.
//:
//: What I believe is an easier solution.
// MARK: - Elements
protocol ElementType {
    func accept(_ visitor: Visitor)
}

struct ElementA { }
struct ElementB { }


// MARK: - Visitor
// Pattern match different visitor implementation
enum Visitor {
    case a, b
}

// MARK: Implementation of visitor
// Instead of writing logic in a separate class, Swift allows code separation through extensions.
extension ElementA: ElementType {
    func accept(_ visitor: Visitor) {
        // ... some logic
        switch visitor {
        case .a:
            // ... some implementation for Visitor A
            print("Element A visited by visitor A")
        case .b:
            // ... some implementation for Visitor B
            print("Element A visited by visitor B")
        }
    }
}
extension ElementB: ElementType {
    func accept(_ visitor: Visitor) {
        // ... some logic
        switch visitor {
        case .a:
            // ... some implementation for Visitor A
            print("Element B visited by visitor A")
        case .b:
            // ... some implementation for Visitor B
            print("Element B visited by visitor B")
        }
    }
}


// MARK: - Main
let visitors: [Visitor] = [.a, .b]
let element_a = ElementA(),
    element_b = ElementB()

visitors.map { visitor in
    // See how an element "accepts" a "visitor"
    element_a.accept(visitor)
    element_b.accept(visitor)
    
    // Dinamically perform type specific implementation from abstract visitor
    let elements: [ElementType] = [element_a, element_b]
    elements.map { el in el.accept(visitor) }
}
