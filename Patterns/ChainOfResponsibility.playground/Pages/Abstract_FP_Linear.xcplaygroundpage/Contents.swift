//: Chain of Responsibility Pattern. Behavioral.
//:
//: Reference: https://refactoring.guru/design-patterns/observer
//:
//:![Chain of Responsibility](ChainOfResponsibility.jpg)
import Foundation

typealias Handler<Request, RequestResult> = (Request) -> RequestResult

func chain_handlers<Request, RequestResult>(
    _ handlers: [Handler<Request, RequestResult>],
    _ passIf: @escaping (RequestResult) -> Bool
) -> (Request) -> RequestResult? {
    { request in
        for handler in handlers {
            let result = handler(request)
            if !passIf(result) { return result }
        }
        return nil
    }
}


// MARK: - Main
typealias AnimalRequest = String
typealias AnimalRequestResult = String?
typealias AnimalHandler = (AnimalRequest) -> AnimalRequestResult

let handler_monkey: AnimalHandler = { request in request == "Banana" ? ("Monkey: I'll eat the " + request + ".\n") : nil },
    handler_squirrel: AnimalHandler = { request in request == "Nut" ? ("Squirrel: I'll eat the " + request + ".\n") : nil },
    handler_dog: AnimalHandler = { request in request == "MeatBall" ? ("Dog: I'll eat the " + request + ".\n") : nil }

let animalHandlers = [handler_monkey, handler_squirrel, handler_dog]
let food = ["Nut", "Banana", "Cup of coffee"]

let result = food.map(chain_handlers(animalHandlers, { $0 == nil }))
result
