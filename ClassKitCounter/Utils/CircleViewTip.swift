//
//  CircleViewTip.swift
//  ClassKitCounter
//
//  Created by Darkhan Serkeshev on 08.10.2024.
//

import SwiftUI

public struct CircleViewTip: Shape {
  public var progress: Double
  public var ringRadius: Double
  
  public var animatableData: Double {
    get { progress }
    set { progress = newValue }
  }
  
  public func path(in rect: CGRect) -> Path {
    var path = Path()
    if progress > 0.0 {
      path.addEllipse(
        in: CGRect(
          x: position.x,
          y: position.y,
          width: rect.size.width,
          height: rect.size.height
        )
      )
    }
    return path
  }
}

// MARK: - Private Methods

extension CircleViewTip {
  private var position: CGPoint {
    let progressAngle = Angle(degrees: (360.0 * progress) - 90.0)
    return CGPoint(
      x: ringRadius * cos(
        progressAngle.radians
      ),
      y: ringRadius * sin(progressAngle.radians)
    )
  }
}
