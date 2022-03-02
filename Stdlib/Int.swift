import Foundation

#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if os(macOS) || os(iOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif

// MARK: INT
public 
extension Int {
    var uInt: UInt {
        return UInt(self)
    }

    var double: Double {
        return Double(self)
    }

    var float: Float {
        return Float(self)
    }

    #if canImport(CoreGraphics)
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    #endif

    // CountableRange 0..<Int.
    var countableRange: CountableRange<Int> {
        return 0..<self
    }

    /// Radian value of degree input.
    var degreesToRadians: Double {
        return Double.pi * Double(self) / 180.0
    }

    /// Degree value of radian input.
    var radiansToDegrees: Double {
        return Double(self) * 180 / Double.pi
    }

    /// String formatted for values over ±1000 (example: 1k, -2k, 100k, 1kk, -5kk..).
    var kFormatted: String {
        var sign: String {
            return self >= 0 ? "" : "-"
        }
        let abs = Swift.abs(self)
        if abs == 0 {
            return "0k"
        } else if abs >= 0, abs < 1000 {
            return "0k"
        } else if abs >= 1000, abs < 1_000_000 {
            return String(format: "\(sign)%ik", abs / 1000)
        }
        return String(format: "\(sign)%ikk", abs / 100_000)
    }
}

// MARK: OPERATOR
precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator **: PowerPrecedence

/// Value of exponentiation.
///
/// - Parameters:
///   - lhs: base integer.
///   - rhs: exponent integer.
/// - Returns: exponentiation result (example: 2 ** 3 = 8).
public func ** (lhs: Int, rhs: Int) -> Double {
    // http://nshipster.com/swift-operators/
    return pow(Double(lhs), Double(rhs))
}