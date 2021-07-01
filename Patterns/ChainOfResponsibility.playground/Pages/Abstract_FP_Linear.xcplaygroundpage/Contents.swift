//: Chain of Responsibility Pattern. Behavioral.
//:
//: Reference: https://refactoring.guru/design-patterns/observer
//:
//:![Chain of Responsibility](ChainOfResponsibility.jpg)
import Foundation

/// Strictly speaking, I think, RequestResult should be of Result type, i.e. either return .success or .failure so that passIf() argument could define when to abort.
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
enum AnimalRequestError: Error { case cannotHandle }
typealias AnimalRequestResult = Result<String, AnimalRequestError>
typealias AnimalHandler = (AnimalRequest) -> AnimalRequestResult

let handler_monkey: AnimalHandler = { request in request == "Banana" ? .success("Monkey: I'll eat the " + request + ".\n") : .failure(.cannotHandle) },
    handler_squirrel: AnimalHandler = { request in request == "Nut" ? .success("Squirrel: I'll eat the " + request + ".\n") : .failure(.cannotHandle) },
    handler_dog: AnimalHandler = { request in request == "MeatBall" ? .success("Dog: I'll eat the " + request + ".\n") : .failure(.cannotHandle) }

let animalHandlers = [handler_monkey, handler_squirrel, handler_dog]
let food = ["Nut", "Banana", "Cup of coffee"]

let result = food.map(chain_handlers(animalHandlers, { $0 == .failure(.cannotHandle) }))
result


