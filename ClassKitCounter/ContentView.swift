//
//  CounterView.swift
//  ClassKitCounter
//
//  Created by Darkhan Serkeshev on 07.10.2024.
//

import SwiftUI

// MARK: - CounterView

public struct CounterView: View {
  @State
  private var count = 0
  
  public var body: some View {
    content
  }
}

// MARK: - Content

extension CounterView {
  private var content: some View {
    VStack {
      counterText
      buttons
    }
  }
  
  private var counterText: some View {
    Text("\(count)")
      .font(.system(size: 80))
      .foregroundStyle(.gray)
  }
  
  private var buttons: some View {
    HStack(alignment: .center, spacing: 16) {
      resetButton
      incrementButton
    }
  }
  
  private var resetButton: some View {
    Button(action: {
      count = 0
    }) {
      Text(Localization.resetButtonTitle.rawValue)
        .font(.title)
        .foregroundStyle(.gray)
    }
  }
  
  private var incrementButton: some View {
    Button(action: {
      count += 1
    }) {
      Image(systemName: "plus.circle")
        .font(.largeTitle)
    }
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
