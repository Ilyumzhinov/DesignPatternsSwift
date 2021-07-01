//: Proxy Pattern. Structural.
//:
//: Reference: https://refactoring.guru/design-patterns/proxy
//:
//:![Proxy](Proxy.jpg)
import Foundation
typealias ServiceResult = Int

// MARK: - Service
// MARK: Common interface
protocol ServiceType {
    func request() -> ServiceResult
}

// MARK: Real service
struct RealService: ServiceType {
    func request() -> ServiceResult {
        print("Processing heavy request...")
        sleep(4)
        return 1
    }
}


// MARK: - Proxy
class Proxy: ServiceType {
    private let service: ServiceType
    private var cache: ServiceResult?
    
    init() { self.service = RealService() }
    
    func request() -> ServiceResult {
        print("Processing cached request...")
        guard let result = cache else {
            cache = service.request()
            return cache!
        }
        
        return result
    }
}


// MARK: - Main
let service: ServiceType = Proxy()
service.request()
service.request()
