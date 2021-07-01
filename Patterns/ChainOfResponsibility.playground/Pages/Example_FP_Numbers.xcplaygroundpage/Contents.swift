//: Chain of Resposibility pattern: Numbers example.
//:
//: Reference: https://youtu.be/jDX6x8qmjbA
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


// MARK: - Types
typealias NumberRequest = (type: String, number1: Int, number2: Int)
typealias NumberHandler = (NumberRequest) -> Int?


// MARK: - Handlers
let addNumbersHandler: NumberHandler = { request in request.type == "add" ? request.number1 + request.number2 : nil },
    subNumbersHandler: NumberHandler = { request in request.type == "sub" ? request.number1 - request.number2 : nil },
    multNumbersHandler: NumberHandler = { request in request.type == "mult" ? request.number1 * request.number2 : nil },
    divNumbersHandler: NumberHandler = { request in request.type == "div" ? request.number1 / request.number2 : nil }


// MARK: - Main
let numberHandlers = [addNumbersHandler, subNumbersHandler, multNumbersHandler, divNumbersHandler]
let numberRequest: NumberRequest = ("div", 4, 2)

let result = chain_handlers(numberHandlers, { $0 == nil })(numberRequest)
result
