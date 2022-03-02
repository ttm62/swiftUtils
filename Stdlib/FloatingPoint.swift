#if canImport(Foundation)
import Foundation
#endif

public 
extension FloatingPoint {
    var abs: Self {
        return Swift.abs(self)
    }

    var isPositive: Bool {
        return self > 0
    }

    var isNegative: Bool {
        return self < 0
    }

    #if canImport(Foundation)
    var ceil: Self {
        return Foundation.ceil(self)
    }
    #endif

    #if canImport(Foundation)
    var floor: Self {
        return Foundation.floor(self)
    }
    #endif

    /// Radian value of degree input.
    var degreesToRadians: Self {
        return Self.pi * self / Self(180)
    }

    /// Degree value of radian input.
    var radiansToDegrees: Self {
        return self * Self(180) / Self.pi
    }
}