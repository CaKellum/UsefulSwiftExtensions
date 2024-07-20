import UIKit

public extension UIColor {
    /// Creates the UIColor from a hex value
    /// - Parameter fromRGB: 24  Bit hex integer
    convenience init(fromRGB: Int) {
        let color = RGBAColor(fromRGB: fromRGB)
        self.init(red: color.red, green: color.green, blue: color.blue,
                  alpha: color.alpha)
    }

    /// Creates the UIColor from a hex value
    /// - Parameter fromRGB: 24  Bit hex integer
    convenience init(fromRGBA: Int) {
        let color = RGBAColor(fromRGBA: fromRGBA)
        self.init(red: color.red, green: color.green, blue: color.blue, alpha: color.alpha)
    }
}
