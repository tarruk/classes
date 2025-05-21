//
//  Class.swift
//  ClassesApp
//
//  Created by Tarek Radovan on 21/05/2025.
//

struct Class: Decodable {
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
