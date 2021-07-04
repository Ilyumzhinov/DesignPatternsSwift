//: Abstract Factory Pattern: Platform-independent GUI example.
//:
//: Reference: https://refactoring.guru/design-patterns/abstract-factory
import SwiftUI
typealias GUI = Image


// MARK: - GUI elements
protocol ButtonType {
    func draw_button() -> GUI?
}
protocol CheckboxType {
    func draw_checkbox() -> GUI?
}

// MARK: GUI elements implementation
// For iOS
struct IOSButton: ButtonType {
    func draw_button() -> GUI? { Image(resource: "iOS_button.png") }
}
struct IOSCheckbox: CheckboxType {
    func draw_checkbox() -> GUI? { Image(resource: "iOS_checkbox.png") }
}

// For mac
struct MacButton: ButtonType {
    func draw_button() -> GUI? { Image(resource: "macOS_button.png") }
}
struct MacCheckbox: CheckboxType {
    func draw_checkbox() -> GUI? { Image(resource: "macOS_checkbox.png") }
}


// MARK: - Factory
protocol GUIFactory {
    func createButton() -> ButtonType
    func createCheckbox() -> CheckboxType
}

// MARK: Factory implementation
// For iOS
struct IOSGUIFactory: GUIFactory {
    func createButton() -> ButtonType {
        // ... some logic for creating iOS button
        IOSButton()
    }
    
    func createCheckbox() -> CheckboxType {
        // ... some logic for creating iOS checkbox
        IOSCheckbox()
    }
}

// For mac
struct MacGUIFactory: GUIFactory {
    func createButton() -> ButtonType {
        // ... some logic for creating iOS button
        MacButton()
    }
    
    func createCheckbox() -> CheckboxType {
        // ... some logic for creating iOS checkbox
        MacCheckbox()
    }
}


// MARK: - Main
// Determined on launch
enum OSEnvironment { case iOS, macOS }
let currentEnvironment: OSEnvironment = .macOS

// Create UI elements
let guiFactory: GUIFactory = currentEnvironment == .iOS ? IOSGUIFactory() : MacGUIFactory()
let button: ButtonType = guiFactory.createButton(),
    checkbox: CheckboxType = guiFactory.createCheckbox()

// Draw UI
button.draw_button()
checkbox.draw_checkbox()

