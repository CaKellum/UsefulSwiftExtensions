import SwiftUI

public extension Color {

    /// Creates the UIColor from a hex value
    /// - Parameter fromRGB: 24  Bit hex integer
    public init(fromRGB: Int) {
        let color = RGBAColor(fromRGB: fromRGB)
        self.init(red: color.red, green: color.green, blue: color.blue, opacity: color.alpha)
    }

    /// Creates the UIColor from a hex value
    /// - Parameter fromRGB: 24  Bit hex integer
    public init(fromRGBA: Int) {
        let color = RGBAColor(fromRGBA: fromRGBA)
        self.init(red: color.red, green: color.green, blue: color.blue, opacity: color.alpha)
    }
}
