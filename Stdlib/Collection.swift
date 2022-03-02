import Foundation

// MARK: COLLECTION
public
extension Collection {
    /// the full range of collection
    var fullRange: Range<Index> { startIndex..<endIndex }

    /// Safe unwrap
    ///
    ///   let arr = [1, 2, 3, 4, 5]
    ///   arr[safe: 1] -> 2
    ///   arr[safe: 10] -> nil
    ///
    /// - Parameter index: index of element to access element.
    subscript(safe index: Index) -> Element? {
        // startIndex <= index && index < endIndex ? self[index] : nil
        return indices.contains(index) ? self[index] : nil
    }

    /// Returns an array of slices of length "size" from the array. If array can't be split evenly, the final slice will be the remaining elements.
    ///
    ///     [0, 2, 4, 7].group(by: 2) -> [[0, 2], [4, 7]]
    ///     [0, 2, 4, 7, 6].group(by: 2) -> [[0, 2], [4, 7], [6]]
    ///
    /// - Parameter size: The size of the slices to be returned.
    /// - Returns: grouped self.
    func group(by size: Int) -> [[Element]]? {
        guard size>0, !isEmpty else { return nil }
        var start = startIndex
        var slices = [[Element]]()

        while start != endIndex {
            let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex
            slices.append(Array(self[start..<end]))
            start = end
        }

        return slices
    }

    /// Calls the given closure with an array of size of the parameter slice.
    ///
    ///     [0, 2, 4, 7].forEach(slice: 2) { print($0) } -> // print: [0, 2], [4, 7]
    ///     [0, 2, 4, 7, 6].forEach(slice: 2) { print($0) } -> // print: [0, 2], [4, 7], [6]
    ///
    /// - Parameters:
    ///   - slice: size of array in each interation.
    ///   - body: a closure that takes an array of slice size as a parameter.
    func forEach(slice: Int, body: ([Element]) throws -> Void) rethrows {
        var start = startIndex
        while case let end = index(start, offsetBy: slice, limitedBy: endIndex) ?? endIndex,
            start != end {
            try body(Array(self[start..<end]))
            start = end
        }
    }
}

// MARK: Floating-Point Average (2 types)
public 
extension Collection where Element: BinaryInteger {
    /// Average of all elements in array.
    ///
    /// - Returns: the average of the array's elements.
    func average() -> Double {
        // http://stackoverflow.com/questions/28288148/making-my-function-calculate-average-of-array-swift
        guard !isEmpty else { return .zero }
        return Double(reduce(.zero, +)) / Double(count)
    }
}

public 
extension Collection where Element: FloatingPoint {
    /// SwifterSwift: Average of all elements in array.
    ///
    ///        [1.2, 2.3, 4.5, 3.4, 4.5].average() = 3.18
    ///
    /// - Returns: average of the array's elements.
    func average() -> Element {
        guard !isEmpty else { return .zero }
        return reduce(.zero, +) / Element(count)
    }
}


// do {
//     var x = ["x","b","c","d","e"]
//     print(x.fullRange)
//     print(x[safe: 0])
//     print(x.group(by: 2))
//     [0, 2, 4, 7, 6].forEach(slice: 2) { print($0) }
//     print([0, 2, 4, 7, 6].average())
//     print([0.1, 0.3].average())
// }