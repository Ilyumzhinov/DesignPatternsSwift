//: Builder pattern: User example.
//:
//: Reference: https://youtu.be/M7Xi1yO_s8E
struct Address {
    var zip: String,
        street: String
}

struct User {
    var name: String,
        age: UInt8,
        phone: String,
        address: Address
}


// MARK: - Builder
struct UserBuilder {
    private var user: User
    // Provide defaults if User requires no optionals
    private static let cName: String = "no name",
                       cAge: UInt8 = 0,
                       cPhone: String = "no phone",
                       cAddress: Address = .init(zip: "1", street: "Main")
    
    private init(user: User) {
        self.user = user
    }
    init(name: String) {
        user = .init(name: name, age: UserBuilder.cAge, phone: UserBuilder.cPhone, address: UserBuilder.cAddress)
    }
    func age(_ age: UInt8) -> UserBuilder {
        // ... some additional logic for setting up age
        var user_new = user
        user_new.age = age
        return .init(user: user_new)
    }
    func phone(_ phone: String) -> UserBuilder {
        // ... some additional logic for setting up phone
        var user_new = user
        user_new.phone = phone
        return .init(user: user_new)
    }
    func address(_ address: Address) -> UserBuilder {
        // ... some additional logic for setting up address
        var user_new = user
        user_new.address = address
        return .init(user: user_new)
    }
    
    func build() -> User {
        user
    }
}


// MARK: - Main
UserBuilder(name: "Me")
    .age(9)
    .build()
