//
//  CourseFilter.swift
//  ClassesApp
//
//  Created by Tarek Radovan on 21/05/2025.
//

enum CourseFilter: CaseIterable, Identifiable {
  case all
  case favorites

  var title: String {
    switch self {
    case .all:
      return "all".localized
    case .favorites:
      return "favorites".localized
    }
  }
  
  var id: String { title }
}
