import UIKit
import SwiftUI

public extension Image {
    /// Assumption: resource must not be empty!
    init(resource: String) {
        self.init(uiImage: UIImage(named: resource)!)
    }
}

public func fileExists(_ name: String) -> Bool {
    UIImage.init(named: name) != nil ? true : false
}
