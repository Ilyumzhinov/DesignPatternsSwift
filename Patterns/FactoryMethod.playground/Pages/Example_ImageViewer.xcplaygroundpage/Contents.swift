//: Factory method pattern: Image Viewer example.
//:
//: Reference: https://arjunsk.medium.com/factory-pattern-in-java-ccedb7bb9124
import SwiftUI
import PlaygroundSupport

// MARK: - Products
protocol ImageType {
    var path: String { get }
    func render() -> Image?
}
struct PNGImage: ImageType {
    let path: String
    func render() -> Image? {
        // ... some PNG specific render
        Image(resource: path)
    }
}
struct JPGImage: ImageType {
    let path: String
    func render() -> Image? {
        // ... some JPG specific render
        Image(resource: path)
    }
}
struct HEICImage: ImageType {
    let path: String
    func render() -> Image? {
        // ... some HEIC specific render
        Image(resource: path)
    }
}


// MARK: - Factory
struct ImageViewer {
    let image: ImageType?
    
    // Factory method
    init(_ path: String) {
        guard fileExists(path) else {
            image = nil
            return
        }
        let fileExtension = path.split(separator: ".").last
        switch fileExtension {
        case "png":
            // ... some logic for creating a PNG file
            image = PNGImage(path: path)
        case "jpg":
            // ... some logic for creating a JPG file
            image = JPGImage(path: path)
        case "heic":
            // ... some logic for creating a HEIC file
            image = HEICImage(path: path)
        default:
            image = nil
        }
    }
    
    func render() -> Image {
        image?.render() ?? Image(systemName: "questionmark")
    }
}


// MARK: - Main
let imageViewer = ImageViewer("dogs.heic")
imageViewer.render()
