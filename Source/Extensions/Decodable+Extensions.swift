//
//  Decodable+Extensions.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 9.07.22.
//

import Foundation

struct Skippable: Decodable { }

extension UnkeyedDecodingContainer {
    
  public mutating func skip() throws {
      _ = try decode(Skippable.self)
  }
}
