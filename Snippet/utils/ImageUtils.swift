import AppKit
import SwiftUI

func copyPrettyCodePNGToClipboard(
    _ attributedString: AttributedString,
    width: CGFloat = 1000,
    fontSize: CGFloat = 20,
    fontName: String = "SF Mono",
    outerBackground: NSColor = .systemPurple,
    editorBackground: NSColor = NSColor(calibratedWhite: 0.1, alpha: 1)
) {
    let mutableAttr = NSMutableAttributedString(attributedString: NSAttributedString(attributedString))
    let range = NSRange(location: 0, length: mutableAttr.length)

    let codeFont = NSFont(name: fontName, size: fontSize) ?? NSFont.monospacedSystemFont(ofSize: fontSize, weight: .regular)
    mutableAttr.addAttribute(.font, value: codeFont, range: range)

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 4
    mutableAttr.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)

    let outerPadding: CGFloat = 60
    let internalPadding: CGFloat = 30
    let headerHeight: CGFloat = 40
    let cornerRadius: CGFloat = 16

    let cardWidth = width - (outerPadding * 2)
    let textWidth = cardWidth - (internalPadding * 2)

    let textHeight = estimatedHeight(for: mutableAttr, width: textWidth) + 20

    let cardHeight = textHeight + (internalPadding * 2) + headerHeight
    let totalHeight = cardHeight + (outerPadding * 2)
    let totalSize = CGSize(width: width, height: totalHeight)

    let scale: CGFloat = 2.0
    let bitmapRep = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: Int(totalSize.width * scale),
        pixelsHigh: Int(totalSize.height * scale),
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0,
        bitsPerPixel: 0
    )!

    bitmapRep.size = totalSize

    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmapRep)

    let outerRect = CGRect(origin: .zero, size: totalSize)
    outerBackground.setFill()
    outerRect.fill()

    let outerGradient = NSGradient(starting: .white.withAlphaComponent(0.2), ending: .black.withAlphaComponent(0.2))
    outerGradient?.draw(in: outerRect, angle: -45)

    let context = NSGraphicsContext.current?.cgContext
    context?.saveGState()

    let shadow = NSShadow()
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.5)
    shadow.shadowBlurRadius = 25
    shadow.shadowOffset = NSSize(width: 0, height: -12)
    shadow.set()

    let cardRect = CGRect(x: outerPadding, y: outerPadding, width: cardWidth, height: cardHeight)
    let cardPath = NSBezierPath(roundedRect: cardRect, xRadius: cornerRadius, yRadius: cornerRadius)
    editorBackground.setFill()
    cardPath.fill()

    context?.restoreGState()

    let headerRect = CGRect(x: cardRect.minX, y: cardRect.maxY - headerHeight, width: cardWidth, height: headerHeight)
    let headerPath = NSBezierPath(roundedRect: headerRect, xRadius: cornerRadius, yRadius: cornerRadius)
    editorBackground.darker(by: 0.05).setFill()
    headerPath.fill()

    let dotY = headerRect.midY - 5
    let dotSpacing: CGFloat = 18
    let firstDotX = headerRect.minX + 20
    let colors: [NSColor] = [.systemRed, .systemYellow, .systemGreen]

    for (i, color) in colors.enumerated() {
        let dotRect = CGRect(x: firstDotX + CGFloat(i) * dotSpacing, y: dotY, width: 10, height: 10)
        color.withAlphaComponent(0.8).setFill()
        NSBezierPath(ovalIn: dotRect).fill()
    }

    let textRect = CGRect(
        x: cardRect.minX + internalPadding,
        y: cardRect.minY + internalPadding,
        width: textWidth,
        height: textHeight
    )

    mutableAttr.draw(in: textRect)

    let watermark = "{} snippet"
    let watermarkAttrs: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: 14, weight: .bold),
        .foregroundColor: NSColor.white.withAlphaComponent(0.3)
    ]
    let watermarkSize = watermark.size(withAttributes: watermarkAttrs)
    let watermarkRect = CGRect(
        x: totalSize.width - watermarkSize.width - 25,
        y: 20,
        width: watermarkSize.width,
        height: watermarkSize.height
    )
    watermark.draw(in: watermarkRect, withAttributes: watermarkAttrs)

    NSGraphicsContext.restoreGraphicsState()

    let finalImage = NSImage(size: totalSize)
    finalImage.addRepresentation(bitmapRep)

    NSPasteboard.general.clearContents()
    NSPasteboard.general.writeObjects([finalImage])
}

func estimatedHeight(for attributedString: NSAttributedString, width: CGFloat) -> CGFloat {
    let textStorage = NSTextStorage(attributedString: attributedString)
    let layoutManager = NSLayoutManager()
    let container = NSTextContainer(size: CGSize(width: width, height: .greatestFiniteMagnitude))
    layoutManager.addTextContainer(container)
    textStorage.addLayoutManager(layoutManager)

    layoutManager.ensureLayout(for: container)
    return layoutManager.usedRect(for: container).height
}

extension NSColor {
    func darker(by amount: CGFloat) -> NSColor {
        guard let rgbColor = usingColorSpace(.deviceRGB) else { return self }
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        rgbColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        return NSColor(calibratedRed: max(r - amount, 0), green: max(g - amount, 0), blue: max(b - amount, 0), alpha: a)
    }
}
