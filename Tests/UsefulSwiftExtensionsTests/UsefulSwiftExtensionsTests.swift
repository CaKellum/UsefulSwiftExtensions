import XCTest
@testable import UsefulSwiftExtensions
import SwiftUI

final class UsefulSwiftExtensionsTests: XCTestCase {
    let hexBlue = 0x0000ff
    let hexRed = 0xff0000
    let hexGreen = 0x00ff00
    let hexBlueAlpha = 0x0000ffff
    let hexRedAlpha = 0xff0000ff
    let hexGreenAlpha = 0x00ff00ff

    func testHexToRGBAColor() throws {

        let blue = RGBAColor(fromRGB: hexBlue)
        let red = RGBAColor(fromRGB: hexRed)
        let green = RGBAColor(fromRGB: hexGreen)
        XCTAssertEqual(1.0, blue.blue)
        XCTAssertEqual(1.0, green.green)
        XCTAssertEqual(1.0, red.red)
    }

    func testHexAlphaToRGBAColor() throws {
        let blue = RGBAColor(fromRGBA: hexBlueAlpha)
        let red = RGBAColor(fromRGBA: hexRedAlpha)
        let green = RGBAColor(fromRGBA: hexGreenAlpha)
        XCTAssertEqual(1.0, blue.blue)
        XCTAssertEqual(1.0, green.green)
        XCTAssertEqual(1.0, red.red)
        XCTAssertEqual(1.0, blue.alpha)
        XCTAssertEqual(1.0, green.alpha)
        XCTAssertEqual(1.0, red.alpha)
    }

    func testHexToUIColor() {
        let red = UIColor(fromRGB: hexRed)
        let green = UIColor(fromRGB: hexGreen)
        let blue = UIColor(fromRGB: hexBlue)
        var redValue: CGFloat = 0.0
        var greenValue: CGFloat = 0.0
        var blueValue: CGFloat = 0.0
        var alphaValue: CGFloat = 0.0
        red.getRed(&redValue, green: &greenValue, blue: &blueValue, alpha: &alphaValue)
        XCTAssert(redValue == 1.0 && blueValue == 0.0 && greenValue == 0.0 && alphaValue == 1.0)
        green.getRed(&redValue, green: &greenValue, blue: &blueValue, alpha: &alphaValue)
        XCTAssert(redValue == 0.0 && blueValue == 0.0 && greenValue == 1.0 && alphaValue == 1.0)
        blue.getRed(&redValue, green: &greenValue, blue: &blueValue, alpha: &alphaValue)
        XCTAssert(redValue == 0.0 && blueValue == 1.0 && greenValue == 0.0 && alphaValue == 1.0)
    }

    func testHexToUIColorWithAlpha() {
        let red = UIColor(fromRGBA: hexRedAlpha)
        let green = UIColor(fromRGBA: hexGreenAlpha)
        let blue = UIColor(fromRGBA: hexBlueAlpha)
        var redValue: CGFloat = 0.0
        var greenValue: CGFloat = 0.0
        var blueValue: CGFloat = 0.0
        var alphaValue: CGFloat = 0.0
        red.getRed(&redValue, green: &greenValue, blue: &blueValue, alpha: &alphaValue)
        XCTAssert(redValue == 1.0 && blueValue == 0.0 && greenValue == 0.0 && alphaValue == 1.0)
        green.getRed(&redValue, green: &greenValue, blue: &blueValue, alpha: &alphaValue)
        XCTAssert(redValue == 0.0 && blueValue == 0.0 && greenValue == 1.0 && alphaValue == 1.0)
        blue.getRed(&redValue, green: &greenValue, blue: &blueValue, alpha: &alphaValue)
        XCTAssert(redValue == 0.0 && blueValue == 1.0 && greenValue == 0.0 && alphaValue == 1.0)
    }

    @available(iOS 17.0, *)
    @available(macCatalyst 17.0, *)
    func testHexToColor() {
        let red = Color(fromRGB: hexRed)
        let green = Color(fromRGB: hexGreen)
        let blue = Color(fromRGB: hexBlue)
        XCTAssertEqual(ceil(red.resolve(in: .init()).red), 1.0)
        XCTAssertEqual(ceil(red.resolve(in: .init()).green), 0.0)
        XCTAssertEqual(ceil(red.resolve(in: .init()).blue), 0.0)

        XCTAssertEqual(ceil(blue.resolve(in: .init()).blue), 1.0)
        XCTAssertEqual(ceil(blue.resolve(in: .init()).red), 0.0)
        XCTAssertEqual(ceil(blue.resolve(in: .init()).green), 0.0)

        XCTAssertEqual(ceil(green.resolve(in: .init()).green), 1.0)
        XCTAssertEqual(ceil(green.resolve(in: .init()).blue), 0.0)
        XCTAssertEqual(ceil(green.resolve(in: .init()).red), 0.0)
    }

    @available(iOS 17.0, *)
    @available(macCatalyst 17.0, *)
    func testHexToColorWithAlpha() {
        let red = Color(fromRGBA: hexRedAlpha)
        let green = Color(fromRGBA: hexGreenAlpha)
        let blue = Color(fromRGBA: hexBlueAlpha)
        XCTAssertEqual(ceil(red.resolve(in: .init()).red), 1.0)
        XCTAssertEqual(ceil(red.resolve(in: .init()).green), 0.0)
        XCTAssertEqual(ceil(red.resolve(in: .init()).blue), 0.0)
        XCTAssertEqual(ceil(red.resolve(in: .init()).cgColor.alpha), 1.0)

        XCTAssertEqual(ceil(blue.resolve(in: .init()).blue), 1.0)
        XCTAssertEqual(ceil(blue.resolve(in: .init()).red), 0.0)
        XCTAssertEqual(ceil(blue.resolve(in: .init()).green), 0.0)
        XCTAssertEqual(ceil(blue.resolve(in: .init()).cgColor.alpha), 1.0)

        XCTAssertEqual(ceil(green.resolve(in: .init()).green), 1.0)
        XCTAssertEqual(ceil(green.resolve(in: .init()).blue), 0.0)
        XCTAssertEqual(ceil(green.resolve(in: .init()).red), 0.0)
        XCTAssertEqual(ceil(green.resolve(in: .init()).cgColor.alpha), 1.0)
    }

    func testConstraints() {
        let superView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        let subView = UIView()
        superView.addSubView(subView, with: [.top(constant: 10), .bottom(constant: 11),
                                             .leading(constant: 1), .trailing(constant: 3)])
        XCTAssertEqual(superView.constraints.count, 4)
        let topConstraint = superView.constraints.first(where: {$0.firstAttribute == .top})?.constant ?? 0.0
        let leadingConstraint = superView.constraints.first(where: {$0.firstAttribute == .leading})?.constant ?? 0.0
        let trailingConstraint = superView.constraints.first(where: {$0.firstAttribute == .trailing})?.constant ?? 0.0
        let bottomConstraint = superView.constraints.first(where: {$0.firstAttribute == .bottom})?.constant ?? 0.0
        XCTAssertEqual(topConstraint, 10.0)
        XCTAssertEqual(leadingConstraint, 1.0)
        XCTAssertEqual(trailingConstraint, 3.0)
        XCTAssertEqual(bottomConstraint, 11.0)
    }

    func testCaseInsensitiveDictionsary() {
        var dictionary = ["name": "chris"]
        assert(dictionary[ci: "NAME"] == "chris")
        assert(dictionary[ci: "Name"] == "chris")
        assert(dictionary[ci: "namE"] == "chris")
        assert(dictionary[ci: "naME"] == "chris")
        assert(dictionary[ci: "name"] == "chris")
        dictionary[ci: "NAME"] = "Crystal"
        assert(dictionary[ci: "name"] == "Crystal")
    }
}
