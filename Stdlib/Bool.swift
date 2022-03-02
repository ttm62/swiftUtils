import Foundation

public
extension Bool {
    /// Return 1 if true, 0 if false
    ///
    ///     false.int -> 0
    ///     true.int -> 1
    ///
    var int: Int {
        return self ? 1 : 0
    }

    /// Return "true" if true, "false" if false
    ///
    ///     false.int -> "false"
    ///     true.int -> "true"
    ///
    var string: String {
        return self ? "true" : "false"
    }
}
