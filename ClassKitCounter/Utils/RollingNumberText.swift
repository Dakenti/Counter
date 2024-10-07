//
//  RollingNumberText.swift
//  ClassKitCounter
//
//  Created by Darkhan Serkeshev on 07.10.2024.
//

import SwiftUI

// MARK: - RollingNumberText

public struct RollingNumberText: View {
  private let formatter: NumberFormatter
  private let font: Font
  private let weight: Font.Weight
  private var value: Int
  private var textColor: Color
  
  @State
  private var animationRange: [Int] = []
  
  public init(
    font: Font = .largeTitle,
    weight: Font.Weight = .regular,
    value: Int,
    textColor: Color
  ) {
    self.font = font
    self.weight = weight
    self.value = value
    self.textColor = textColor
    self.formatter = NumberFormatter()
  }
  
  public var body: some View {
    HStack(spacing: 0) {
      ForEach(animationRange.indices, id: \.self) { index in
        Text("0")
          .font(font)
          .fontWeight(weight)
          .opacity(0)
          .overlay {
            GeometryReader { proxy in
              let size = proxy.size
              
              VStack(spacing: 0) {
                ForEach(0...9, id: \.self) { number in
                  Text("\(number)")
                    .font(font)
                    .fontWeight(weight)
                    .frame(width: size.width,
                           height: size.height,
                           alignment: .center)
                    .foregroundColor(textColor)
                }
              }
              .offset(y: settingOffset(at: index, height: size.height))
            }
            .clipped()
          }
      }
    }
    .onAppear {
      let stringValue = string(from: value)
      animationRange = Array(repeating: 0, count: stringValue.count)
      settingAnimationRange(stringValue, isAnimate: false)
    }
    .onChange(of: value) { newValue in
      let stringValue = string(from: newValue)
      resizeAnimationRange(to: stringValue.count, duration: 0.05)
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
        settingAnimationRange(stringValue, isAnimate: true)
      }
    }
  }
}

// MARK: - Private Methods

extension RollingNumberText {
  private func resizeAnimationRange(to count: Int, duration: TimeInterval){
    let extra = count - animationRange.count
    
    if extra > 0 {
      for _ in 0 ..< extra {
        withAnimation(.easeIn(duration: duration)) {
          animationRange.append(0)
        }
      }
    } else {
      for _ in 0 ..< (-extra) {
        withAnimation(.easeIn(duration: duration)) {
          _ = animationRange.removeLast()
        }
      }
    }
  }
  
  private func settingAnimationRange(_ string: String, isAnimate: Bool) {
    for (index, value) in string.enumerated() {
      if isAnimate {
        var fraction = Double(index) * 0.15
        fraction = (fraction > 0.5 ? 0.5 : fraction)
        
        withAnimation(.interactiveSpring(response: 0.45,
                                         dampingFraction: 1 + fraction,
                                         blendDuration: 1 + fraction)) {
          animationRange.set(value, index: index)
        }
      } else {
        animationRange.set(value, index: index)
      }
    }
  }
  
  private func settingOffset(at index: Int, height: CGFloat) -> CGFloat {
    return -CGFloat(animationRange[index]) * height
  }
  
  private func string(from newValue: Int) -> String {
    var stringValue = "\(newValue)"
    
    if let number = Int(stringValue) {
      if let formatted = formatter.string(from: number as NSNumber) {
        stringValue = formatted
      }
    }
    
    return stringValue
  }
}
