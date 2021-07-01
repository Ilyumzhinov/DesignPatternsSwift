//: Prototype Pattern. Creational.
//:
//: Reference: https://refactoring.guru/design-patterns/prototype
//:
//:![Prototype](Prototype.jpg)
import Foundation
typealias CopyType = NSCopying
// Implementation
class BaseClass: CopyType {
    private var A: Int
    private var B: String
    
    required init(A: Int = 1, B: String = "Value") {
        self.A = A
        self.B = B
    }
    
    /// Copying
    func copy(with zone: NSZone? = nil) -> Any {
        let prototype = type(of: self).init()
        prototype.A = A
        prototype.B = B
        return prototype
    }
}

class SubClass: BaseClass {
    private var C: Bool = false
    
    override func copy(with zone: NSZone? = nil) -> Any {
        guard let prototype = super.copy(with: zone) as? SubClass else {
            return SubClass() // oops
        }
        prototype.C = C
        return prototype
    }
}


// MARK: - Main
var base = BaseClass(A: 1, B: "text")
var copy = base.copy() as! BaseClass

var sub = SubClass()
var copy_sub = sub.copy() as! SubClass
