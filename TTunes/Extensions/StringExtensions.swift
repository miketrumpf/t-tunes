//
//  StringExtensions.swift
//  TTunes
//
//  Created by Mike on 9/28/17.
//

import Foundation

extension String {
  func trim() -> String {
    return self.trimmingCharacters(in: CharacterSet.newlines)
  }
}
