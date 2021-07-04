//: Visitor Pattern. Behavioral.
//:
//: Reference: https://refactoring.guru/design-patterns/visitor, https://softwareengineering.stackexchange.com/a/412367
//:
//: ![Visitor](Visitor.jpg)
// MARK: - Elements
protocol ElementType { func accept(_ visitor: VisitorType) }

class ElementA: ElementType {
    func accept(_ visitor: VisitorType) { visitor.visitElement(self) }
}
class ElementB: ElementType {
    func accept(_ visitor: VisitorType) { visitor.visitElement(self) }
}


// MARK: - Visitor
protocol VisitorType {
    func visitElement(_ a: ElementA)
    func visitElement(_ b: ElementB)
}

class VisitorA: VisitorType {
    func visitElement(_ a: ElementA) {
        // ... some logic
        print("Element A visited by visitor A")
    }
    
    func visitElement(_ b: ElementB) {
        // ... some logic
        print("Element B visited by visitor A")
    }
}

class VisitorB: VisitorType {
    func visitElement(_ a: ElementA) {
        // ... some logic
        print("Element A visited by visitor B")
    }
    
    func visitElement(_ b: ElementB) {
        // ... some logic
        print("Element B visited by visitor B")
    }
}


// MARK: - Main
let visitors: [VisitorType] = [VisitorA(), VisitorB()]
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
