//
//  CounterViewModel.swift
//  ClassKitCounter
//
//  Created by Darkhan Serkeshev on 07.10.2024.
//

import Foundation

// MARK: - ContentViewModel

final public class ContentViewModel: ObservableObject {
  @Published
  private(set) var count: Int = 0
  
  public func increment() {
    count += 1
  }
  
  public func reset() {
    count = 0
  }
}
