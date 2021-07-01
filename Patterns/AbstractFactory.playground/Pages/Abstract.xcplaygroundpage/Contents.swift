//: Abstract Factory Pattern. Creational.
//:
//: Reference: https://refactoring.guru/design-patterns/abstract-factory
//:
//:![Abstract Factory](AbstractFactory.png)
// MARK: - Products
protocol ProductAType {
    func do_a()
}
protocol ProductBType {
    func do_b()
}
// Implementation 1
struct ProductA1: ProductAType {
    func do_a() { print("Implementation 1 of Product A performed") }
}
struct ProductB1: ProductBType {
    func do_b() { print("Implementation 1 of Product B performed") }
}
// Implementation 2
struct ProductA2: ProductAType {
    func do_a() { print("Implementation 2 of Product A performed") }
}
struct ProductB2: ProductBType {
    func do_b() { print("Implementation 2 of Product B performed") }
}


// MARK: - Abstract factory
protocol AbstractFactoryType {
    func create_productA() -> ProductAType
    func create_productB() -> ProductBType
}
// Impelemntation 1
struct Factory1: AbstractFactoryType {
    func create_productA() -> ProductAType {
        // ... some additional initilisation code for Implementation 1 of Product A
        ProductA1()
    }
    func create_productB() -> ProductBType {
        // ... some additional initilisation code for Implementation 1 of Product B
        ProductB1()
    }
}
// Implementation 2
struct Factory2: AbstractFactoryType {
    func create_productA() -> ProductAType {
        // ... some additional initilisation code for Implementation 2 of Product A
        ProductA2()
    }
    func create_productB() -> ProductBType {
        // ... some additional initilisation code for Implementation 2 of Product B
        ProductB2()
    }
}


// MARK: - Main
// Set implementation to use
let useImplementation1 = true

// Get products
let productA = useImplementation1 ? Factory1().create_productA() : Factory2().create_productA(),
    productB = useImplementation1 ? Factory1().create_productB() : Factory2().create_productB()
productA.do_a()
productB.do_b()
