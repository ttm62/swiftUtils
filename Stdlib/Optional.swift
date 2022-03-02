import Foundation

public
extension Optional {

    /// Get self of default value (if self is nil).
    ///
    ///		let foo: String? = nil
    ///		print(foo.value(or: "bar")) -> "bar"
    ///
    ///		let bar: String? = "bar"
    ///		print(bar.value(or: "foo")) -> "bar"
    ///
    /// - Parameter defaultValue: default value to return if self is nil.
    /// - Returns: self if not nil or default value if nil.
    func value(or defaultValue: Wrapped) -> Wrapped {
        guard let result = self else {
            return defaultValue
        }
        return result
    }

    /// Gets the wrapped value of an optional. If the optional is `nil`, throw a custom error.
    ///
    ///        let foo: String? = nil
    ///        try print(foo.value(or: MyError.notFound)) -> error: MyError.notFound
    ///
    ///        let bar: String? = "bar"
    ///        try print(bar.value(or: MyError.notFound)) -> "bar"
    ///
    /// - Parameter error: The error to throw if the optional is `nil`.
    /// - Throws: The error passed in.
    /// - Returns: The value wrapped by the optional.
    func value(or error: Error) throws -> Wrapped {
        guard let wrapped = self else { throw error }
        return wrapped
    }
}

public 
extension Optional where Wrapped: RawRepresentable, Wrapped.RawValue: Equatable {
    // swiftlint:disable missing_swifterswift_prefix

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable static 
    func == (lhs: Optional, rhs: Wrapped.RawValue?) -> Bool {
        return lhs?.rawValue == rhs
    }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable static 
    func == (lhs: Wrapped.RawValue?, rhs: Optional) -> Bool {
        return lhs == rhs?.rawValue
    }

    /// Returns a Boolean value indicating whether two values are not equal.
    ///
    /// Inequality is the inverse of equality. For any values `a` and `b`,
    /// `a != b` implies that `a == b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable static 
    func != (lhs: Optional, rhs: Wrapped.RawValue?) -> Bool {
        return lhs?.rawValue != rhs
    }

    /// Returns a Boolean value indicating whether two values are not equal.
    ///
    /// Inequality is the inverse of equality. For any values `a` and `b`,
    /// `a != b` implies that `a == b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable static 
    func != (lhs: Wrapped.RawValue?, rhs: Optional) -> Bool {
        return lhs != rhs?.rawValue
    }

    // swiftlint:enable missing_swifterswift_prefix
}

// enum MyError: Error {
//         case internalServerError
//         case notFound
//     }

// do {
//     let foo: String? = nil
//     try print(foo.value(or: MyError.notFound))

//     let bar: String? = "bar"
//     try print(bar.value(or: MyError.internalServerError))

//     print(4 == Optional(4))
    
// } 
// catch MyError.notFound {
//     print("Not Found")
// } catch MyError.internalServerError {
//     print("SERVER ERROR")
// }
