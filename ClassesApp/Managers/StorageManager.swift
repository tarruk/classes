//
//  StorageManager.swift
//  ClassesApp
//
//  Created by Tarek Radovan on 21/05/2025.
//

import Foundation

final class StorageManager {
  
  static func save<T: Codable>(_ object: T, forKey key: String) {
    do {
      let data = try JSONEncoder().encode(object)
      UserDefaults.standard.set(data, forKey: key)
    } catch {
      print("Failed to save object to UserDefaults:", error)
    }
  }

  static func load<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
    guard let data = UserDefaults.standard.data(forKey: key) else {
      return nil
    }
    do {
      let object = try JSONDecoder().decode(type, from: data)
      return object
    } catch {
      print("Failed to load object from UserDefaults:", error)
      return nil
    }
  }
}
