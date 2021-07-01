//: Chain of Resposibility pattern: Real World example.
//:
//: Reference: https://refactoring.guru/design-patterns/chain-of-responsibility/swift/example#example-1
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


// MARK: - Types
// MARK: Request types
protocol RequestType {
    var firstName: String? { get }
    var lastName: String? { get }
    var email: String? { get }
    var password: String? { get }
    var repeatedPassword: String? { get }
}
extension RequestType {
    var firstName: String? { return nil }
    var lastName: String? { return nil }
    var email: String? { return nil }
    var password: String? { return nil }
    var repeatedPassword: String? { return nil }
}
struct SignUpRequest: RequestType {
    var firstName: String?, lastName: String?
    var email: String?, password: String?, repeatedPassword: String?
}
struct LoginRequest: RequestType {
    var email: String?, password: String?
}

// MARK: Error types
enum AuthError: Error {
    case emptyFirstName, emptyLastName
    case emptyEmail, emptyPassword
    case invalidEmail, invalidPassword, differentPasswords
    case locationDisabled, notificationsDisabled
}
extension AuthError {
    var errorDescription: String? {
        switch self {
        case .emptyFirstName:
            return "First name is empty"
        case .emptyLastName:
            return "Last name is empty"
        case .emptyEmail:
            return "Email is empty"
        case .emptyPassword:
            return "Password is empty"
        case .invalidEmail:
            return "Email is invalid"
        case .invalidPassword:
            return "Password is invalid"
        case .differentPasswords:
            return "Password and repeated password should be equal"
        case .locationDisabled:
            return "Please turn location services on"
        case .notificationsDisabled:
            return "Please turn notifications on"
        }
    }
}

// MARK: Handler type
typealias RequestResult = Result<Bool, AuthError>
typealias AuthenticationHandler = (RequestType) -> RequestResult


// MARK: - Handlers
let handler_login: AuthenticationHandler = { request in
    guard request.email?.isEmpty == false else {
        return .failure(.emptyEmail)
    }
    guard request.password?.isEmpty == false else {
        return .failure(.emptyPassword)
    }
    
    return .success(true)
}
let handler_signUp: AuthenticationHandler = { request in
    let limit_passwordLength = 8
    
    guard request.email?.contains("@") == true else {
        return .failure(.invalidEmail)
    }
    guard (request.password?.count ?? 0) >= limit_passwordLength else {
        return .failure(.invalidPassword)
    }
    guard request.password == request.repeatedPassword else {
        return .failure(.differentPasswords)
    }
    return .success(true)
}
let handler_location: AuthenticationHandler = { request in
    func isLocationEnabled() -> Bool { true }
    
    guard isLocationEnabled() else {
        return .failure(.locationDisabled)
    }
    return .success(true)
}
let handler_notifiation: AuthenticationHandler = {request in
    func isNotificationsEnabled() -> Bool { true }
    
    guard isNotificationsEnabled() else {
        return .failure(.notificationsDisabled)
    }
    return .success(true)
}


// MARK: - Main
// Login
let handlers_login = [handler_login, handler_location]
let request_login = LoginRequest(email: "smth@gmail.com", password: "123HardPass")

if let resultError = chain_handlers(handlers_login, { $0 == .success(true) })(request_login),
   case let .failure(error) = resultError {
    print("Login View Controller: something went wrong")
    print("Login View Controller: Error -> " + (error.errorDescription ?? ""))
} else {
    print("Login View Controller: Preconditions are successfully validated")
}

// Sigup
let handlers_signUp = [handler_signUp, handler_location, handler_notifiation]
let request_signUp = SignUpRequest(firstName: "Vasya", lastName: "Pupkin", email: "vasya.pupkin@gmail.com", password: "123HardPass", repeatedPassword: "123HardPass")

if let resultError = chain_handlers(handlers_signUp, { $0 == .success(true) })(request_signUp),
   case let .failure(error) = resultError {
    print("SignUp View Controller: something went wrong")
    print("SignUp View Controller: Error -> " + (error.errorDescription ?? ""))
} else {
    print("SignUp View Controller: Preconditions are successfully validated")
}
