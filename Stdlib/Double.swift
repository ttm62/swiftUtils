import Foundation

#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if os(macOS) || os(iOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif

// MARK: DOUBLE
public 
extension Double {
    var int: Int {
        return Int(self)
    }

    var float: Float {
        return Float(self)
    }

    #if canImport(CoreGraphics)
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    #endif

    func rounded(f: Int) -> Double {
        let temp = pow(10, Double(f))
        return roundl(self * temp) / temp
    }
}

// MARK: OPERATOR
precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator **: PowerPrecedence

/// Value of exponentiation.
///
/// - Parameters:
///   - lhs: base double.
///   - rhs: exponent double.
/// - Returns: exponentiation result (example: 4.4 ** 0.5 = 2.0976176963).
public 
func ** (lhs: Double, rhs: Double) -> Double {
    // http://nshipster.com/swift-operators/
    return pow(lhs, rhs)
}

// Round to the specific decimal place
public 
func rounded(_ value: Double, f: Int) -> Double {
    let temp = pow(10, Double(f))
    return round(value * temp) / temp
}

// do {
//     let value: Double = 4.23555
//     print(rounded(value, f: 2))
//     print(value.rounded(f:  2))
//     //print(300000000.kFormatted)
//     print(3 ** 3)
//     print(3.0 ** 3.0)
// }