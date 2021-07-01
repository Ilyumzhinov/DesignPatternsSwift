//: Chain of Resposibility pattern: Ordering system example.
//:
//: Reference: https://refactoring.guru/design-patterns/chain-of-responsibility
//:
//: Beware: better be separated into Authentication, Authorisation, Validation, Caching handling systems
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
enum AuthenticationError: Error {
    case notAuthenticated, tooManyAttempts
}
typealias AuthenticationRequest = (userCredentials: (isAuthenticated: Bool, isAdmin: Bool, ip: String), data: (userInput: String, dataRequested: Int))
typealias AuthenticationHandler = (AuthenticationRequest) -> Result<Int?, AuthenticationError>


// MARK: - Handlers
let handler_userAuthentication: AuthenticationHandler = { request in request.userCredentials.isAuthenticated ? .success(nil) : .failure(.notAuthenticated) }
let handler_adminAccess: AuthenticationHandler = { request in
    if request.userCredentials.isAdmin {
        print("admin access granted")
        return .success(nil) }
    else { return .success(nil) }
}
let handler_sanitizeData: AuthenticationHandler = { request in
    let data = request.data.userInput.trimmingCharacters(in: .whitespacesAndNewlines)
    print("Data sanitized: '\(data)'")
    
    return .success(nil)
}
let handler_IPattacks: ((ip: String, count: Int)) -> AuthenticationHandler = { repeatedRequests in
    { request in
        (repeatedRequests.ip == request.userCredentials.ip && repeatedRequests.count+1 > 3) ? .failure(.tooManyAttempts) : .success(nil)
    }
}
let handler_cache: ([Int: String]) -> AuthenticationHandler = { cache in
    { request in
        if let data = cache[request.data.dataRequested] {
            print("Cached data returned: \(data)")
        }
        
        return .success(nil)
    }
}


// MARK: - Main
// Build handler chain
let authenticationHandlers = [handler_userAuthentication, handler_adminAccess, handler_sanitizeData, handler_IPattacks(("192.168.0.1", 3)), handler_cache([10: "Quick cache"])]

let handleAuthenticationRequests = chain_handlers(authenticationHandlers) { result in
    if case .success(_) = result { return true } else { return false }
}

// Build request
let authenticationRequest: AuthenticationRequest = (
    userCredentials: (isAuthenticated: true, isAdmin: false, ip: "192.168.0.2"),
    data: (userInput: " hello ", dataRequested: 10)
)

// Execute
if let result = handleAuthenticationRequests(authenticationRequest) {
    switch result {
    case .success:
        ()
    case .failure(let error):
        print("Error returned: \(error)")
    }
} else {
    print("All passed")
}

