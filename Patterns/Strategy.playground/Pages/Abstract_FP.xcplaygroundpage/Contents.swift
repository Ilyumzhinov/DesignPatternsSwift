//: Strategy Pattern. Behavioral.
//:
//: Reference: https://refactoring.guru/design-patterns/strategy, https://research.sylviastuurman.nl/wp-content/uploads/2019/11/REPLACING_PATTERNS.pdf
//:
//: ![Strategy](Strategy.jpg)
// MARK: - Strategy
typealias StrategyFunction = ([Int]) -> [Int]

// Implementation
let sort_asc: StrategyFunction = { array in array.sorted() },
    sort_desc: StrategyFunction = { array in array.sorted(by: >) }


// MARK: - Context
struct Context {
    let data: [Int],
        strategy: StrategyFunction
    
    func doSomething() {
        print(strategy(data))
    }
}


// MARK: - Main
Context(data: [1,3,2], strategy: sort_asc)
    .doSomething()
Context(data: [1,3,2], strategy: sort_desc)
    .doSomething()
