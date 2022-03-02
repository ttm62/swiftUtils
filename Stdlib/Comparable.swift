import Foundation

public 
extension Comparable {
    /// Returns true if value is in the provided range.
    ///
    ///    1.isBetween(5...7) // false
    ///    7.isBetween(6...12) // true
    ///    date.isBetween(date1...date2)
    ///    "c".isBetween(a...d) // true
    ///    0.32.isBetween(0.31...0.33) // true
    ///
    /// - Parameter range: Closed range against which the value is checked to be included.
    /// - Returns: `true` if the value is included in the range, `false` otherwise.
    func isBetween(_ range: ClosedRange<Self>) -> Bool {
        return range ~= self
    }
}