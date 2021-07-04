//: Singleton Pattern: Database connection example.
//:
//: Reference: https://refactoring.guru/design-patterns/singleton
struct Connection {
    let connectionID: Int
    func request(_ data: String) -> String {
        "Coonection \(connectionID): Output for \(data)"
    }
}


// MARK: - Singleton
final class Database {
    // No instantiation allowed
    private init() { }
    
    // Open database connection
    private static let database: Connection = .init(connectionID: 1)
    static func query(_ sql: String) -> String {
        database.request(sql)
    }
}


// MARK: - Main
Database.query("123")
Database.query("345")
