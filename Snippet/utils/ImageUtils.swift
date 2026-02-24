import AppKit
import SwiftUI

func copyPrettyCodePNGToClipboard(
    _ attributedString: AttributedString,
    width: CGFloat = 720
) {
    let nsAttr = NSAttributedString(attributedString)

    let padding: CGFloat = 20
    let headerHeight: CGFloat = 32

    // Auto-height na podstawie treści
    let textWidth = width - padding * 2
    let textHeight = estimatedHeight(for: nsAttr, width: textWidth)
    let height = textHeight + padding * 2 + headerHeight

    let size = CGSize(width: width, height: height)
    let image = NSImage(size: size)
    image.lockFocus()

    // 🌫 Tło z cieniem
    let cardRect = CGRect(origin: .zero, size: size)
    let shadow = NSShadow()
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.35)
    shadow.shadowBlurRadius = 20
    shadow.shadowOffset = NSSize(width: 0, height: -6)
    shadow.set()

    let cardPath = NSBezierPath(roundedRect: cardRect, xRadius: 14, yRadius: 14)
    NSColor(calibratedWhite: 0.08, alpha: 1).setFill() // ciemny, "premium" background
    cardPath.fill()

    shadow.set() // reset

    // 🧱 Header jak okienko macOS
    let headerRect = CGRect(x: 0, y: height - headerHeight, width: width, height: headerHeight)
    let headerPath = NSBezierPath(roundedRect: headerRect, xRadius: 14, yRadius: 14)
    NSColor(calibratedWhite: 0.12, alpha: 1).setFill()
    headerPath.fill()

    // 🔴🟡🟢 kropki okienka
    let dotsY = headerRect.midY - 4
    let dotX: CGFloat = 14
    let spacing: CGFloat = 10

    NSColor.systemRed.withAlphaComponent(0.8).setFill()
    NSBezierPath(ovalIn: CGRect(x: dotX, y: dotsY, width: 8, height: 8)).fill()

    NSColor.systemYellow.withAlphaComponent(0.8).setFill()
    NSBezierPath(ovalIn: CGRect(x: dotX + spacing, y: dotsY, width: 8, height: 8)).fill()

    NSColor.systemGreen.withAlphaComponent(0.8).setFill()
    NSBezierPath(ovalIn: CGRect(x: dotX + spacing * 2, y: dotsY, width: 8, height: 8)).fill()

    // 🧾 Tekst
    let textRect = CGRect(
        x: padding,
        y: padding,
        width: width - padding * 2,
        height: height - padding * 2 - headerHeight
    )
    nsAttr.draw(in: textRect)

    image.unlockFocus()

    NSPasteboard.general.clearContents()
    NSPasteboard.general.writeObjects([image])
}

func estimatedHeight(for attributedString: NSAttributedString, width: CGFloat) -> CGFloat {
    let textStorage = NSTextStorage(attributedString: attributedString)
    let layoutManager = NSLayoutManager()
    let container = NSTextContainer(size: CGSize(width: width, height: .greatestFiniteMagnitude))

    layoutManager.addTextContainer(container)
    textStorage.addLayoutManager(layoutManager)

    layoutManager.glyphRange(for: container)
    return layoutManager.usedRect(for: container).height
}
