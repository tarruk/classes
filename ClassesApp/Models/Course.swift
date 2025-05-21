//
//  Class.swift
//  ClassesApp
//
//  Created by Tarek Radovan on 21/05/2025.
//

import Foundation

struct Course: Identifiable, Equatable, Decodable {
  let id: UUID = UUID()
  let title: String
  let slug: String
  let imageURL: String
  var favorite: Bool = false
  
  enum CodingKeys: String, CodingKey {
    case title
    case slug
    case imageURL = "image_url"
  }
}

extension Course {
  static let mock = Course(
    title: "A Title",
    slug: "A Slug",
    imageURL: "https://www.masterclass.com/image/url"
  )
}
