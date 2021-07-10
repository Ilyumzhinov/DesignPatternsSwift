//: Command Pattern. Behavioral.
//:
//: The classic OOP way.
//:
//: Reference: https://refactoring.guru/design-patterns/command, https://research.sylviastuurman.nl/wp-content/uploads/2019/11/REPLACING_PATTERNS.pdf
//:
//: ![Command](CommandOOP.jpg)
import Foundation

// MARK: - Commands
protocol CommandType {
    func execute()
}

// Implementation
struct CommandA: CommandType {
    let receiver: Receiver,
        param1: Int
    
    func execute() {
        receiver.action1(param1)
    }
}
struct CommandB: CommandType {
    let receiver: Receiver,
        param1: Int
    
    func execute() {
        receiver.action2(param1)
    }
}


// MARK: - Invoker
// Invokes a certain  executable command
struct InvokerA {
    private let command: CommandType
    
    init(command: CommandType) {
        self.command = command
    }
    
    func execute() { print("InvokerA executed command"); command.execute() }
}
struct InvokerB {
    private let command: CommandType
    
    init(command: CommandType) {
        self.command = command
    }
    
    func execute() { print("InvokerB executed command"); command.execute() }
}


// MARK: - Receiver
// Contains context/state information and business logic of commands
class Receiver {
    var state: Int = 0
    
    // Receiver (context) commands
    func action1(_ param1: Int) {
        state = state + param1
        print("Receiver action 1. New state: \(state)")
    }
    func action2(_ param1: Int) {
        state = state * param1
        print("Receiver action 2. New state: \(state)")
    }
}

// MARK: - Main
// Possible combinations: Receivers * Commands * Invokers
// Here: 1 * 2 * 2 = 4
// Create receiver
let receiver = Receiver()

// Create commands
let commandA = CommandA(receiver: receiver, param1: 1),
    commandB = CommandB(receiver: receiver, param1: 2)

// Create invokers for Receiver
let invokerA_cmdA = InvokerA(command: commandA),
    invokerA_cmdB = InvokerA(command: commandB),
    invokerB_cmdA = InvokerB(command: commandA),
    invokerB_cmdB = InvokerB(command: commandB)

invokerA_cmdA.execute()
invokerA_cmdB.execute()
invokerB_cmdA.execute()
invokerB_cmdB.execute()
