//: Adapter pattern: Requester example.
//:
//: Confroms an existing Requester class whose Sender functionality we want to reuse without modifying its previous interfaces.
//:
//: Reference: https://www.youtube.com/watch?v=6xDBbYe11HQ
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
import Foundation


// MARK: - Adaptee
// Serice type that we want to use but cannot modify.
class Requester {
    // Cannot rename sendRequest() to send().
    func sendRequest(_ url: String) {
        let url = URL(string: url)!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            print(String(data: data, encoding: .utf8)!)
        }
        
        task.resume()
    }
}


// MARK: - Adapter
// Interface that we want to use in client code.
protocol SenderType {
    func send(_ url: String)
}

// Add functionality to Requester without modifying its existing interfaces
extension Requester: SenderType {
    func send(_ url: String) {
        sendRequest(url)
    }
}


// MARK: - Main
let requester: SenderType = Requester()

requester.send("http://www.stackoverflow.com")
