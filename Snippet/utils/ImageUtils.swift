import AppKit
import SwiftUI

func copyPrettyCodePNGToClipboard(
    _ attributedString: AttributedString,
    width: CGFloat = 900,
    outerBackground: NSColor = .systemPurple, // Kolor ramki zewnętrznej
    editorBackground: NSColor = NSColor(calibratedWhite: 0.1, alpha: 1) // Tło edytora (z motywu)
) {
    let nsAttr = NSAttributedString(attributedString)

    // --- KONFIGURACJA WYMIARÓW ---
    let outerPadding: CGFloat = 60 // Szerokość kolorowej ramki
    let internalPadding: CGFloat = 30 // Margines kodu wewnątrz edytora
    let headerHeight: CGFloat = 40 // Wysokość paska z kropkami
    let cornerRadius: CGFloat = 16

    let cardWidth = width - (outerPadding * 2)
    let textWidth = cardWidth - (internalPadding * 2)
    let textHeight = estimatedHeight(for: nsAttr, width: textWidth)

    let cardHeight = textHeight + (internalPadding * 2) + headerHeight
    let totalHeight = cardHeight + (outerPadding * 2)
    let totalSize = CGSize(width: width, height: totalHeight)

    let image = NSImage(size: totalSize)
    image.lockFocus()

    // 1. TŁO ZEWNĘTRZNE (Ramka)
    let outerRect = CGRect(origin: .zero, size: totalSize)
    outerBackground.setFill()
    outerRect.fill()

    // Opcjonalny gradient na ramce dla głębi
    let outerGradient = NSGradient(starting: .white.withAlphaComponent(0.2), ending: .black.withAlphaComponent(0.2))
    outerGradient?.draw(in: outerRect, angle: -45)

    // 2. CIEŃ KARTY
    let context = NSGraphicsContext.current?.cgContext
    context?.saveGState()

    let shadow = NSShadow()
    shadow.shadowColor = NSColor.black.withAlphaComponent(0.5)
    shadow.shadowBlurRadius = 25
    shadow.shadowOffset = NSSize(width: 0, height: -12)
    shadow.set()

    // 3. TŁO EDYTORA (Karta)
    let cardRect = CGRect(x: outerPadding, y: outerPadding, width: cardWidth, height: cardHeight)
    let cardPath = NSBezierPath(roundedRect: cardRect, xRadius: cornerRadius, yRadius: cornerRadius)

    editorBackground.setFill()
    cardPath.fill()

    context?.restoreGState() // Wyłączamy cień dla elementów wewnątrz

    // 4. PASEK TYTUŁOWY (Lekko ciemniejszy od tła edytora)
    let headerRect = CGRect(x: cardRect.minX, y: cardRect.maxY - headerHeight, width: cardWidth, height: headerHeight)
    let headerPath = NSBezierPath(roundedRect: headerRect, xRadius: cornerRadius, yRadius: cornerRadius) // Zaokrąglamy tylko górę (uproszczenie)

    editorBackground.darker(by: 0.05).setFill()
    headerPath.fill()

    // 5. KROPKI SYSTEMOWE
    let dotY = headerRect.midY - 5
    let dotSpacing: CGFloat = 18
    let firstDotX = headerRect.minX + 20

    let colors: [NSColor] = [.systemRed, .systemYellow, .systemGreen]
    for (i, color) in colors.enumerated() {
        let dotRect = CGRect(x: firstDotX + CGFloat(i) * dotSpacing, y: dotY, width: 10, height: 10)
        color.withAlphaComponent(0.8).setFill()
        NSBezierPath(ovalIn: dotRect).fill()
    }

    // 6. RYSOWANIE KODU
    // Przesuwamy tekst, aby był poniżej paska nagłówka
    let textRect = CGRect(
        x: cardRect.minX + internalPadding,
        y: cardRect.minY + internalPadding,
        width: textWidth,
        height: textHeight
    )

    nsAttr.draw(in: textRect)

    image.unlockFocus()

    // 7. EXPORT DO SCHOWKA
    NSPasteboard.general.clearContents()
    NSPasteboard.general.writeObjects([image])
}

/// Pomocnicze rozszerzenie do przyciemniania koloru tła nagłówka
extension NSColor {
    func darker(by amount: CGFloat) -> NSColor {
        // Konwertujemy kolor do przestrzeni RGB, aby bezpiecznie pobrać składowe
        guard let rgbColor = usingColorSpace(.deviceRGB) else {
            // Jeśli konwersja się nie uda (bardzo rzadkie), zwracamy oryginał
            return self
        }

        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        rgbColor.getRed(&r, green: &g, blue: &b, alpha: &a)

        return NSColor(
            calibratedRed: max(r - amount, 0),
            green: max(g - amount, 0),
            blue: max(b - amount, 0),
            alpha: a
        )
    }
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
