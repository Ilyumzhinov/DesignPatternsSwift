//: Command Pattern. Game Controller Example.
//:
//: Reference: https://arjunsk.medium.com/command-pattern-in-java-35574450266c
typealias CommandFunction = () -> ()

// MARK: - Invoker
struct Button {
    private let command: CommandFunction
    
    init(command: @escaping CommandFunction = { print("Button clicked") }) {
        self.command = command
    }
    
    func onPress() {
        command()
    }
}


// MARK: - Receiver
class GameCharacter {
    var latitude: Int,
        logitude: Int
    
    init() {
        self.latitude = 0 // Y
        self.logitude = 0 // X
    }
    
    func moveDown() {
        latitude = latitude - 1
        print("New Latitude Execute \(latitude)")
    }
    
    func undo_MoveDown() {
        latitude = latitude + 1
        print("New Latitude Un-Execute \(latitude)")
    }
    
    func moveUp() {
        latitude = latitude + 1
        print("New Latitude Execute \(latitude)")
    }
    
    func undo_moveDown() {
        latitude = latitude - 1
        print("New Latitude Un-Execute \(latitude)")
    }
}


// MARK: - Main
let mario = GameCharacter()

let buttonA = Button(command: mario.moveUp),
    buttonS = Button(),
    buttonW = Button(),
    buttonD = Button()

// for testing
buttonA.onPress()
buttonA.onPress()
buttonA.onPress()
