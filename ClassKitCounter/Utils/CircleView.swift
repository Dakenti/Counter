//
//  CircleView.swift
//  ClassKitCounter
//
//  Created by Darkhan Serkeshev on 07.10.2024.
//

import SwiftUI

public struct CircleView: View {
  public var progress: Double
  public var ringRadius: Double = UIScreen.main.bounds.width / 2 - 24.0
  public var thickness: CGFloat = 20.0
  public var startColor = Color(red: 0.784, green: 0.659, blue: 0.941)
  public var endColor = Color(red: 0.278, green: 0.129, blue: 0.620)
  
  public var body: some View {
    content
  }
}

// MARK: - Content

extension CircleView {
  private var content: some View {
    ZStack {
      baseCircle
      outerCircle
      innerCircle
      progressCircle
      progressCircleTip
    }
  }
  
  private var baseCircle: some View {
    Circle()
      .stroke(startColor.opacity(0.15), lineWidth: thickness)
      .frame(width:CGFloat(ringRadius) * 2.0)
  }
  
  private var outerCircle: some View {
    Circle()
      .stroke(Color(.systemGray2), lineWidth: 1.0)
      .frame(width:(CGFloat(ringRadius) * 2.0) + thickness)
  }
  
  private var innerCircle: some View {
    Circle()
      .stroke(Color(.systemGray2), lineWidth: 1.0)
      .frame(width:(CGFloat(ringRadius) * 2.0) - thickness)
  }
  
  private var progressCircle: some View {
    Circle()
      .trim(from: 0, to: CGFloat(self.progress))
      .stroke(
        activityAngularGradient,
        style: StrokeStyle(lineWidth: thickness, lineCap: .round))
      .rotationEffect(Angle(degrees: -90))
      .frame(width:CGFloat(ringRadius) * 2.0)
  }
  
  private var progressCircleTip: some View {
    CircleViewTip(progress: progress,
                  ringRadius: Double(ringRadius))
    .fill(progress > 0.95 ? endColor : .clear)
    .frame(width:thickness, height:thickness)
    .shadow(
      color: progress > 0.95 ? .black.opacity(0.3) : .clear,
      radius: 2.5,
      x: ringTipShadowOffset.x,
      y: ringTipShadowOffset.y
    )
  }
  
  private var activityAngularGradient: AngularGradient {
    AngularGradient(
      gradient: Gradient(colors: [startColor, endColor]),
      center: .center,
      startAngle: .degrees(0),
      endAngle: .degrees(360.0 * progress)
    )
  }
}

// MARK: - Private Methods

extension CircleView {
  private var ringTipShadowOffset: CGPoint {
    let ringTipPosition = tipPosition(progress: progress, radius: ringRadius)
    let shadowPosition = tipPosition(progress: progress + 0.0075, radius: ringRadius)
    return CGPoint(
      x: shadowPosition.x - ringTipPosition.x,
      y: shadowPosition.y - ringTipPosition.y
    )
  }
  
  private func tipPosition(
    progress:Double,
    radius:Double
  ) -> CGPoint {
    let progressAngle = Angle(degrees: (360.0 * progress) - 90.0)
    return CGPoint(
      x: radius * cos(
        progressAngle.radians
      ),
      y: radius * sin(progressAngle.radians)
    )
  }
}
