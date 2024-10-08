//
//  CounterView.swift
//  ClassKitCounter
//
//  Created by Darkhan Serkeshev on 07.10.2024.
//

import SwiftUI

// MARK: - CounterView

public struct CounterView: View {
  @ObservedObject
  private var viewModel = ContentViewModel()
  
  public var body: some View {
    content
  }
}

// MARK: - Content

extension CounterView {
  private var content: some View {
    ZStack {
      CircleView(progress: viewModel.circleFillPercentage)
      VStack {
        counterText
          .padding(.bottom, 4)
        buttons
      }
    }
  }
  
  private var counterText: some View {
    RollingNumberText(font: .system(size: 80),
                      weight: .light,
                      value: viewModel.count,
                      textColor: .gray)
  }
  
  private var buttons: some View {
    HStack(alignment: .center, spacing: 16) {
      resetButton
      incrementButton
    }
  }
  
  private var resetButton: some View {
    Button(action: {
      viewModel.reset()
    }) {
      Text(Localization.resetButtonTitle.rawValue)
        .font(.title)
        .foregroundStyle(.gray)
    }
    .sensoryFeedback(
      .impact(
        weight: .heavy,
        intensity: 1
      ),
      trigger: viewModel.count
    )
  }
  
  private var incrementButton: some View {
    Button(action: {
      viewModel.increment()
    }) {
      Image(systemName: "plus.circle")
        .font(.largeTitle)
    }
    .sensoryFeedback(
      .impact(
        flexibility: .soft,
        intensity: 0.5
      ),
      trigger: viewModel.count
    )
  }
}

// MARK: - Localization

extension CounterView {
  private enum Localization: String {
    case resetButtonTitle = "Сброс"
  }
}

struct CounterView_Previews: PreviewProvider {
  static var previews: some View {
    CounterView()
  }
}
