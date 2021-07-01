//: Builder Pattern. Creational.
//:
//: Reference: https://refactoring.guru/design-patterns/factory-method
//:
//:![Builder](Builder.jpg)
struct ObjectToBuild {
    let A: Bool, B: Int?, C: String?
}

// MARK: - Builder
struct Builder {
    var A: Bool = false, B: Int? = nil, C: String? = nil
    
    func buildA(_ a: Bool) -> Builder {
        // ... some building logic
        .init(A: a, B: B, C: C)
    }
    func buildB(_ b: Int) -> Builder {
        // ... some other building logic
        .init(A: A, B: b, C: C)
    }
    func buildC(_ c: String) -> Builder {
        // ... some other building logic
        .init(A: A, B: B, C: c)
    }
    
    func build() -> ObjectToBuild {
        .init(A: A, B: B, C: C)
    }
}


// MARK: - Director
struct Director {
    let builder: Builder
    
    func simpleBuild() -> Builder {
        builder.buildA(true)
    }
    
    func completeBuild() -> Builder {
        builder.buildA(true).buildB(1).buildC("Hello")
    }
}


// MARK: - Main
// Option 1. Build without a director
let objBuilder = Builder().buildA(true).buildC("Example")
print(objBuilder.build())

// Option 2. Build with director
let objBuilderSimple = Director(builder: Builder()).simpleBuild()
let objBuilderComplete = Director(builder: Builder()).completeBuild()

print(objBuilderSimple.build())
print(objBuilderComplete.build())
