//
//  Classes.swift
//  ClassesApp
//
//  Created by Tarek Radovan on 21/05/2025.
//

struct Classes {}

extension Classes {
  struct GetAll: Endpoint {
    typealias Response = [Course]
    
    var method: HTTPMethod { .get }
    var path: String { "classes" }
    var parameters: [String : Any?]? { nil }
  }

  struct GetFavs: Endpoint {
    typealias Response = [String]
    var method: HTTPMethod { .get }
    var path: String { "saved_classes" }
    var parameters: [String : Any?]? { nil }
  }

  struct DeleteFromFavorites: Endpoint {
    typealias Response = EmptyResponse
    
    let slug: String
    
    var method: HTTPMethod { .delete }
    var path: String { "classes" }
    var parameters: [String : Any?]? {
      [ "slug": slug ]
    }
  }

  struct AddToFavorites: Endpoint {
    typealias Response = EmptyResponse
    let slug: String

    var method: HTTPMethod { .post }
    var path: String { "classes" }
    var parameters: [String: Any?]? {
      [ "slug": slug ]
    }
  }
}
