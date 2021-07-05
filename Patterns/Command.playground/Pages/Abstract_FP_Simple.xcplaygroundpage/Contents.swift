//: Command Pattern. Behavioral.
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
    func action1() {
        stateA = stateA + 1
        print("ReceiverA action 1. New state: \(stateA)")
    }
    func action2() {
        stateA = stateA * 2
        print("ReceiverA action 2. New state: \(stateA)")
    }
}
class ReceiverB {
    var stateB: String = ""
    // Receiver (context) commands
    func action1() {
        stateB = stateB + "hello"
        print("ReceiverB action 1. New state: \(stateB)")
    }
    func action2() {
        stateB = stateB + "world"
        print("ReceiverB action 2. New state: \(stateB)")
    }
}


// MARK: - Main
// Possible combinations: Receivers * Actions per Receiver * Invokers
// Here: 2 * 2 * 2 = 8
// Create receiver
let receiverA = ReceiverA(),
    receiverB = ReceiverB()

// Create invokers for Receiver A
let invokerA_recA_cmd1 = InvokerA(command: receiverA.action1),
    invokerA_recA_cmd2 = InvokerA(command: receiverA.action2),
    invokerB_recA_cmd1 = InvokerB(command: receiverA.action1),
    invokerB_recA_cmd2 = InvokerB(command: receiverA.action2)

// Create invokers for Receiver B
let invokerA_recB_cmd1 = InvokerA(command: receiverB.action1),
    invokerA_recB_cmd2 = InvokerA(command: receiverB.action2),
    invokerB_recB_cmd1 = InvokerB(command: receiverB.action1),
    invokerB_recB_cmd2 = InvokerB(command: receiverB.action2)

invokerA_recA_cmd1.execute()
invokerA_recA_cmd2.execute()
invokerB_recA_cmd1.execute()
invokerB_recA_cmd2.execute()

print("\n" + "RECEIVER B commands")
invokerA_recB_cmd1.execute()
invokerA_recB_cmd2.execute()
invokerB_recB_cmd1.execute()
invokerB_recB_cmd2.execute()
