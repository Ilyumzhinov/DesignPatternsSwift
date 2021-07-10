//: Command Pattern. Behavioral.
//:
//: Functional programming implementation. Without undoing operation.
//:
//: Reference: https://refactoring.guru/design-patterns/command, https://research.sylviastuurman.nl/wp-content/uploads/2019/11/REPLACING_PATTERNS.pdf
//:
//: ![Command](Command.jpg)
import Foundation

// MARK: - Commands
typealias CommandFunction = () -> ()


// MARK: - Invoker
// Contains some executable command
struct InvokerA {
    private let command: CommandFunction
    
    init(command: @escaping CommandFunction) {
        self.command = command
    }
    
    func execute() { print("InvokerA executed command"); command() }
}
struct InvokerB {
    private let command: CommandFunction
    
    init(command: @escaping CommandFunction) {
        self.command = command
    }
    
    func execute() { print("InvokerB executed command"); command() }
}


// MARK: - Receiver
// Contains context/state information and business logic of commands
class ReceiverA {
    var stateA: Int = 0
    
    // Receiver (context) commands
    func action1(_ param1: Int) {
        stateA = stateA + param1
        print("ReceiverA action 1. New state: \(stateA)")
    }
    func action2(_ param1: Int) {
        stateA = stateA * param1
        print("ReceiverA action 2. New state: \(stateA)")
    }
}
class ReceiverB {
    var stateB: String = ""
    // Receiver (context) commands
    func action1(_ param1: String) {
        stateB = param1 + stateB
        print("ReceiverB action 1. New state: \(stateB)")
    }
    func action2(_ param1: String) {
        stateB = stateB + param1
        print("ReceiverB action 2. New state: \(stateB)")
    }
}


// MARK: - Main
// Possible combinations: Receivers * Actions per Receiver * Invokers
// Here: 2 * 2 * 2 = 8
// Create receiver
let receiverA = ReceiverA(),
    receiverB = ReceiverB()

// Create commands for Receiver A
let commandA_recA: CommandFunction = { receiverA.action1(1) },
    commandB_recA: CommandFunction = { receiverA.action2(2) }

// Create invokers for Receiver A
let invokerA_recA_cmd1 = InvokerA(command: commandA_recA)
let invokerA_recA_cmd2 = InvokerA(command: commandB_recA)
let invokerB_recA_cmd1 = InvokerB(command: commandA_recA)
let invokerB_recA_cmd2 = InvokerB(command: commandB_recA)

// Create invokers for Receiver B
let invokerA_recB_cmd1 = InvokerA() { receiverB.action1("Hello") },
    invokerA_recB_cmd2 = InvokerA() { receiverB.action2("World") },
    invokerB_recB_cmd1 = InvokerB() { receiverB.action1("Hello") },
    invokerB_recB_cmd2 = InvokerB() { receiverB.action2("World") }

invokerA_recA_cmd1.execute()
invokerA_recA_cmd2.execute()
invokerB_recA_cmd1.execute()
invokerB_recA_cmd2.execute()

print("\n" + "RECEIVER B commands")
invokerA_recB_cmd1.execute()
invokerA_recB_cmd2.execute()
invokerB_recB_cmd1.execute()
invokerB_recB_cmd2.execute()
