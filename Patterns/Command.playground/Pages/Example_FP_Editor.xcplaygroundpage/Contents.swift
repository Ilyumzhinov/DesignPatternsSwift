//: Command pattern. Text editor example.
//:
//: Reference: https://refactoring.guru/design-patterns/command
// MARK: - Commands
typealias CommandFunction = () -> ()

struct Command {
    let execute: CommandFunction
    let undo: CommandFunction
    
    init(execute: @escaping CommandFunction,
         undo: @escaping CommandFunction = { print("Undo command not provided") }) {
        self.execute = execute
        self.undo = undo
    }
}


// MARK: - Invoker
// Contains the UI logic
struct Button {
    let name: String
    private let command: Command
    
    init(name: String, command: Command) {
        self.name = name
        self.command = command
    }
    
    func click() { print("\(name) executed command"); command.execute() }
}
struct Shortcut {
    let name: String
    private let command: Command
    
    init(name: String, command: Command) {
        self.name = name
        self.command = command
    }
    
    func press() { print("\(name) executed command"); command.execute() }
}


// MARK: - Receiver
// Contains business logic of the editor
class Editor {
    var text: String = "",
        clipboard: String = ""
    
    init(text: String) {
        self.text = text
    }
    
    // Editor already contains Receiver (context) information to create commands
    func copy() {
        let text_selected = String(text.split(separator: " ").last ?? "")
        clipboard = text_selected
    }
    
    func paste() {
        let text_pasted = clipboard
        clipboard = ""
        text = text + text_pasted
    }
}


// MARK: - Main
// Create receiver
let editor = Editor(text: "Hello world")
// Create commands
let editor_copy = Command(execute: editor.copy),
    editor_paste = Command(execute: editor.paste)
// Create invokers
let btn_copy = Button(name: "Button Copy", command: editor_copy),
    btn_paste = Button(name: "Button Paste", command: editor_paste),
    shortcut_copy = Shortcut(name: "Command+C", command: editor_copy),
    shortcut_paste = Shortcut(name: "Command+V", command: editor_paste)


print("'\(editor.text)', '\(editor.clipboard)'")
btn_copy.click()
print("'\(editor.text)', '\(editor.clipboard)'")
btn_paste.click()
print("'\(editor.text)', '\(editor.clipboard)'")
shortcut_copy.press()
print("'\(editor.text)', '\(editor.clipboard)'")
shortcut_paste.press()
print("'\(editor.text)', '\(editor.clipboard)'")
