//: Command Pattern. Behavioral.
//:
//: Provides ability to undo commands.
//:
//: Reference: https://research.sylviastuurman.nl/wp-content/uploads/2019/11/REPLACING_PATTERNS.pdf
//:
//: ![Command](Command.jpg)
import Foundation

// MARK: - Commands
typealias CommandFunction = () -> ()

struct Command {
    let execute: CommandFunction,
        undo: CommandFunction
    
    init(execute: @escaping CommandFunction,
         undo: @escaping CommandFunction = { print("Undo command not provided") }) {
        self.execute = execute
        self.undo = undo
    }
}


// MARK: - Invoker
// Contains some executable command
struct InvokerA {
    private let command: Command
    
    init(command: Command) {
        self.command = command
    }
    
    func execute() { print("InvokerA executed command"); command.execute() }
}
struct InvokerB {
    private let command: Command
    
    init(command: Command) {
        self.command = command
    }
    
    func execute() { print("InvokerB executed command"); command.execute() }
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
    func action1_undo() {
        stateA = stateA - 1
        print("ReceiverA action 1 undid. New state: \(stateA)")
    }
    func action2() {
        stateA = stateA * 2
        print("ReceiverA action 2. New state: \(stateA)")
    }
    func action2_undo() {
        stateA = stateA / 2
        print("ReceiverA action 2 undid. New state: \(stateA)")
    }
}
class ReceiverB {
    var stateB: String = ""
    // Receiver (context) commands
    func action1() {
        stateB = stateB + "hello"
        print("ReceiverB action 1. New state: \(stateB)")
    }
    func action1_undo() {
        stateB = stateB.replacingOccurrences(of: "hello", with: "")
        print("ReceiverB action 1. New state: \(stateB)")
    }
    func action2() {
        stateB = stateB + "world"
        print("ReceiverB action 2. New state: \(stateB)")
    }
    func action2_undo() {
        stateB = stateB.replacingOccurrences(of: "world", with: "")
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
let action1_receiverA = Command(execute: receiverA.action1, undo: receiverA.action1_undo),
    action2_receiverA = Command(execute: receiverA.action2, undo: receiverA.action2_undo)
// Create invokers for Receiver A
let invokerA_recA_cmd1 = InvokerA(command: action1_receiverA),
    invokerA_recA_cmd2 = InvokerA(command: action2_receiverA),
    invokerB_recA_cmd1 = InvokerB(command: action1_receiverA),
    invokerB_recA_cmd2 = InvokerB(command: action2_receiverA)

// Create commands for Receiver B
let action1_receiverB = Command(execute: receiverB.action1, undo: receiverB.action1_undo),
    action2_receiverB = Command(execute: receiverB.action2, undo: receiverB.action2_undo)
// Create invokers for Receiver B
let invokerA_recB_cmd1 = InvokerA(command: action1_receiverB),
    invokerA_recB_cmd2 = InvokerA(command: action2_receiverB),
    invokerB_recB_cmd1 = InvokerB(command: action1_receiverB),
    invokerB_recB_cmd2 = InvokerB(command: action2_receiverB)

invokerA_recA_cmd1.execute()
invokerA_recA_cmd2.execute()
invokerB_recA_cmd1.execute()
invokerB_recA_cmd2.execute()

print("\n" + "RECEIVER B commands")
invokerA_recB_cmd1.execute()
invokerA_recB_cmd2.execute()
invokerB_recB_cmd1.execute()
invokerB_recB_cmd2.execute()
