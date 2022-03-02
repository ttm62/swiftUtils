import Foundation

#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if os(macOS) || os(iOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif

// MARK: FLOAT
public 
extension Float {
    var int: Int {
        return Int(self)
    }

    var double: Double {
        return Double(self)
    }

    #if canImport(CoreGraphics)
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    #endif

    func rounded(f: Int) -> Float {
        let temp = pow(10, Double(f))
        return Float(roundl(Double(self) * temp) / temp)
    }
}


// MARK: OPERATOR
precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator **: PowerPrecedence

/// Value of exponentiation.
///
/// - Parameters:
///   - lhs: base float.
///   - rhs: exponent float.
/// - Returns: exponentiation result (example: 4.4 ** 0.5 = 2.0976176963).
public 
func ** (lhs: Float, rhs: Float) -> Float {
    // http://nshipster.com/swift-operators/
    return pow(lhs, rhs)
}

public 
func rounded(_ value: Float, f: Int) -> Float {
    let temp = pow(10, Double(f))
    return Float(round(Double(value) * temp) / temp)
}

