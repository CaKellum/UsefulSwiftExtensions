import Foundation

struct RGBAColor {

    private static let mask = 0xff
    private static let redShift = 0x10
    private static let greenShift = 0x8
    private static let blueShift = 0x0
    private static let alphaShifter = 0x8

    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat

    init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) {
        self.red = red/255.0
        self.green = green/255.0
        self.blue = blue/255.0
        self.alpha = alpha/255.0
    }

    init(fromRGB: Int) {
        self.red = CGFloat((fromRGB >> Self.redShift) & Self.mask)/255.0
        self.green = CGFloat((fromRGB >> Self.greenShift) & Self.mask)/255.0
        self.blue = CGFloat(fromRGB & Self.mask)/255.0
        self.alpha = 1.0
    }

    init(fromRGBA: Int) {
        self.red = CGFloat((fromRGBA >> (Self.redShift + Self.alphaShifter)) & Self.mask)/255.0
        self.green = CGFloat((fromRGBA >> (Self.greenShift + Self.alphaShifter)) & Self.mask)/255.0
        self.blue = CGFloat((fromRGBA >> (Self.blueShift + Self.alphaShifter)) & Self.mask)/255.0
        self.alpha = CGFloat(fromRGBA & Self.mask)/255.0
    }
}
