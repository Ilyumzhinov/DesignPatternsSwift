//: Proxy pattern: Memoize example.
//:
//: Memoize is a proxy function that caches pure function's results.
import Foundation

// MARK: - Proxy
func memoize<K: Hashable, R>(_ f: @escaping (K) -> R) ->
(K) -> R {
    var memo = Dictionary<K, R>()
    
    return { key in
        if let cache = memo[key] { return cache }
        let new = f(key)
        memo[key] = new
        return new
    }
}


// MARK: - Main
func squared<T: Numeric>(_ number: T) -> T {
    sleep(3)
    return number*number
}
let squared_cached: (Int) -> Int = memoize(squared)

squared(5) // times time
squared(5) // times time

squared_cached(5) // times time
squared_cached(5) // now instantly

squared_cached(4) // takes time
squared_cached(4) // now instantly
