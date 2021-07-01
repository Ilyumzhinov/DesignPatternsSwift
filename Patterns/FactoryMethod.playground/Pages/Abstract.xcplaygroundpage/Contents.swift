//: Factory Method Pattern. Creational.
//:
//: Reference: https://refactoring.guru/design-patterns/factory-method
//:
//:![Factory](Factory.jpg)
// MARK: - Products
protocol ProductType {
    func do_stuff()
}
// Implementation
struct ProductA: ProductType {
    func do_stuff() { print("Product A performed") }
}
struct ProductB: ProductType {
    func do_stuff() { print("Product B performed") }
}


// MARK: - Creators
struct CreatorA {
    func factoryMethod() -> ProductType {
        // ... some additional initilisation code for Product A
        ProductA()
    }
}
struct CreatorB {
    func factoryMethod() -> ProductType {
        // ... some additional initilisation code for Product B
        ProductB()
    }
}


// MARK: - Main
let productA = CreatorA().factoryMethod(),
    productB = CreatorB().factoryMethod()

productA.do_stuff()
productB.do_stuff()
