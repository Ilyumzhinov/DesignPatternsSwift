//: State Pattern. Behavioral.
//:
//: Reference: https://refactoring.guru/design-patterns/state, https://www.youtube.com/watch?v=emQW0UNjgF4.
//:
//: ![State](State.jpg)
// MARK: - Context
class Context {
    let name: String
    var state: StateType
    
    init(name: String, state: StateType) {
        self.name = name
        self.state = state
    }
    
    func change_stateA() { state.change_stateA() }
    func change_stateB() { state.change_stateB() }
}


// MARK: - State
protocol StateType {
    var context: Context? { get }
    func change_stateA()
    func change_stateB()
}

// Implementation
class StateA: StateType {
    var context: Context?
    init(context: Context?) {
        self.context = context
    }
    
    func change_stateA() {
        print("\(context?.name ?? ""): Trying to change State to A")
        print("Already in StateA. Skipping")
    }
    func change_stateB() {
        print("\(context?.name ?? ""): Trying to change State to B")
        print("Switching State to B")
        context?.state = StateB(context: context)
    }
}

class StateB: StateType {
    var context: Context?
    init(context: Context?) {
        self.context = context
    }
    
    func change_stateA() {
        print("\(context?.name ?? ""): Trying to change State to A")
        print("Switching State to A")
        context?.state = StateA(context: context)
    }
    func change_stateB() {
        print("\(context?.name ?? ""): Trying to change State to B")
        print("Already in StateB. Skipping")
    }
}


// MARK: - Main
// Create initial State
var state_initialA = StateA(context: nil)

// Create Context A
let contextA = Context(name: "Context A", state: state_initialA)
state_initialA.context = contextA

// Change states
contextA.change_stateA()
contextA.change_stateB()
contextA.change_stateB()
contextA.change_stateA()
