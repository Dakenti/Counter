//
//  Array + Character.swift
//  ClassKitCounter
//
//  Created by Darkhan Serkeshev on 07.10.2024.
//

import Foundation

extension Array where Element == Int {
  mutating func set(_ value: Character, index: Int) {
    if let number = Int(String(value)) {
      self[index] = number
    }
  }
}
