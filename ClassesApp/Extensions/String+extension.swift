//
//  String+extension.swift
//  ClassesApp
//
//  Created by Tarek Radovan on 21/05/2025.
//

import Foundation

extension String {
  var localized: String {
    NSLocalizedString(self, comment: "")
  }
}
