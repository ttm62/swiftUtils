#if canImport(Foundation)
import Foundation
#endif

public extension Dictionary {
    /// Check if key exists in dictionary.
    ///
    ///        let dict: [String: Any] = ["testKey": "testValue", "testArrayKey": [1, 2, 3, 4, 5]]
    ///        dict.has(key: "testKey") -> true
    ///        dict.has(key: "anotherKey") -> false
    ///
    /// - Parameter key: key to search for.
    /// - Returns: true if key exists in dictionary.
    func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }

    #if canImport(Foundation)
    /// JSON Data from dictionary.
    ///
    /// - Parameter prettify: set true to prettify data (default is false).
    /// - Returns: optional JSON Data (if applicable).
    func jsonData(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization
            .WritingOptions()
        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }
    #endif

    #if canImport(Foundation)
    /// JSON String from dictionary.
    ///
    ///        dict.jsonString() -> "{"testKey":"testValue","testArrayKey":[1,2,3,4,5]}"
    ///
    ///        dict.jsonString(prettify: true)
    ///        /*
    ///        returns the following string:
    ///
    ///        "{
    ///        "testKey" : "testValue",
    ///        "testArrayKey" : [
    ///            1,
    ///            2,
    ///            3,
    ///            4,
    ///            5
    ///        ]
    ///        }"
    ///
    ///        */
    ///
    /// - Parameter prettify: set true to prettify string (default is false).
    /// - Returns: optional JSON String (if applicable).
    func jsonString(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization
            .WritingOptions()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    #endif
}

public extension Dictionary where Value: Equatable {
    /// Returns an array of all keys that have the given value in dictionary.
    ///
    ///        let dict = ["key1": "value1", "key2": "value1", "key3": "value2"]
    ///        dict.keys(forValue: "value1") -> ["key1", "key2"]
    ///        dict.keys(forValue: "value2") -> ["key3"]
    ///        dict.keys(forValue: "value3") -> []
    ///
    /// - Parameter value: Value for which keys are to be fetched.
    /// - Returns: An array containing keys that have the given value.
    func keys(forValue value: Value) -> [Key] {
        return keys.filter { self[$0] == value }
    }
}

public extension Dictionary {
    /// SwifterSwift: Deep fetch or set a value from nested dictionaries.
    ///
    ///        var dict =  ["key": ["key1": ["key2": "value"]]]
    ///        dict[path: ["key", "key1", "key2"]] = "newValue"
    ///        dict[path: ["key", "key1", "key2"]] -> "newValue"
    ///
    /// - Note: Value fetching is iterative, while setting is recursive.
    ///
    /// - Complexity: O(N), _N_ being the length of the path passed in.
    ///
    /// - Parameter path: An array of keys to the desired value.
    ///
    /// - Returns: The value for the key-path passed in. `nil` if no value is found.
    subscript(path path: [Key]) -> Any? {
        get {
            guard !path.isEmpty else { return nil }
            var result: Any? = self
            for key in path {
                if let element = (result as? [Key: Any])?[key] {
                    result = element
                } else {
                    return nil
                }
            }
            return result
        }
        set {
            if let first = path.first {
                if path.count == 1, let new = newValue as? Value {
                    return self[first] = new
                }
                if var nested = self[first] as? [Key: Any] {
                    nested[path: Array(path.dropFirst())] = newValue
                    return self[first] = nested as? Value
                }
            }
        }
    }
}

// do {
//     var dict =  ["key": ["key1": ["key2": "value"]]]
//     let value: [String: Any] = [
//         "name" : "Tam",
//         "age" : 20,
//         "k1" : [
//             "k2": [
//                 "k3": 3
//             ]
//         ]
//     ]

//     print(value[path: ["k1", "k2"]] )
//     print(dict[path: ["key", "key1", "key2"]])
    
// }