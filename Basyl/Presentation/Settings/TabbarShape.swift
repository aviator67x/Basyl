//
//  TabbarShape.swift
//  Basyl
//
//  Created by Andrew Kasilov on 22.05.2024.
//

import Foundation
import SwiftUI

struct TabBarShape: Shape {
    let multiplier: CGFloat
    let corner: CGFloat
    let buttonRadius: CGFloat
    let distance: CGFloat
    let offsetVertical: CGFloat
    var insetRadius: CGFloat {
        (buttonRadius + distance) * multiplier
    }

    var cornerRadius: CGFloat {
        corner * multiplier
    }

    var angle: CGFloat {
        let sin = offsetVertical / (buttonRadius + distance)
        return asin(sin)
    }

    var centralCurvsRadius: CGFloat {
        insetRadius * offsetVertical * multiplier / (insetRadius - offsetVertical)
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Start just below the top-left corner
        var x = rect.minX
        var y = rect.minY + cornerRadius
        path.move(to: CGPoint(x: x, y: y))

        // Add the rounded corner on the top-left corner
        x += cornerRadius
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: cornerRadius,
            startAngle: .degrees(180),
            endAngle: .degrees(270),
            clockwise: false
        )
        // Begin inset in middle, cutting into shape
        let offsetX = (insetRadius + centralCurvsRadius) * cos(angle)
        let turnAngle = 90 - angle * 180 / .pi//90 - angle * 180 / .pi
        x = rect.midX - offsetX
        y = rect.minY - centralCurvsRadius//+ centralCurvsRadius
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: centralCurvsRadius,
            startAngle: .degrees(90),//(270),
            endAngle: .degrees(90 - turnAngle),//(270 + turnAngle),
            clockwise: true//false
        )
        // Add a half-circle to fit the button
        x = rect.midX
        y = -rect.minY//rect.minY
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: insetRadius,
            startAngle: .radians(.pi - angle),
            endAngle: .radians(angle),
            clockwise: false//true
        )
        // Finish inset in middle, cutting into shape
        x = rect.midX + offsetX
        y = rect.minY - centralCurvsRadius//+ centralCurvsRadius
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: centralCurvsRadius,
            startAngle: .degrees(90 + turnAngle),//(270 - turnAngle),
            endAngle: .degrees(90),//(270),
            clockwise: true//false
        )
        // Top-right corner
        x = rect.maxX - cornerRadius
        y = rect.minY + cornerRadius
        path.addArc(
            center: CGPoint(x: x, y: y),
            radius: cornerRadius,
            startAngle: .degrees(270),
            endAngle: .degrees(0),
            clockwise: false
        )
        // Bottom-right corner
        x = rect.maxX
        y = rect.maxY // - cornerRadius
        path.addLine(to: CGPoint(x: x, y: y))

        // Bottom-left corner
        x = rect.minX
        y = rect.maxY // - cornerRadius
        path.addLine(to: CGPoint(x: x, y: y))

        path.closeSubpath()
        return path
    }
}
