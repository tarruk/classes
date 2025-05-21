//
//  APIClient.swift
//  ClassesApp
//
//  Created by Tarek Radovan on 21/05/2025.
//

import Foundation

/// A simple network client for executing HTTP requests.
/// Currently handles basic REST operations with optional parameters and decoding support.
///
/// Improvements that could be made:
/// - Decouple decoding logic from the request method for better testability and separation of concerns.
/// - Extend `APIError` to support backend-specific error responses (e.g. decoding error objects returned by the server).
/// - Support for custom headers, request timeout, retries, or interceptors.
/// - Add generic logging or monitoring (especially for debugging or analytics).
final class APIClient {

  /// Singleton instance for shared usage across the app.
  static let shared = APIClient()
  private init() {}

  /// Executes a request based on the `Endpoint` configuration.
  ///
  /// - Parameter endpoint: An instance conforming to the `Endpoint` protocol, describing method, path, parameters, and response type.
  /// - Returns: The decoded response of type `E.Response`.
  /// - Throws: An `APIError` if the request fails at any stage (invalid URL, encoding, decoding, network issues).
  func request<E: Endpoint>(_ endpoint: E) async throws -> E.Response {
    var urlComponents = URLComponents(string: "\(APIClient.basePath)/\(endpoint.path)")

    if (endpoint.method == .get || endpoint.method == .delete),
       let parameters = endpoint.parameters {
      urlComponents?.queryItems = parameters.compactMap { key, value in
        guard let value = value else { return nil }
        return URLQueryItem(name: key, value: "\(value)")
      }
    }

    guard let url = urlComponents?.url else {
      throw APIError.invalidURL
    }

    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method.rawValue.uppercased()

    if (endpoint.method == .post || endpoint.method == .put),
       let parameters = endpoint.parameters {
      do {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      } catch {
        throw APIError.encodingFailed(error)
      }
    }

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw APIError.invalidResponse
    }
    
    guard (200...299).contains(httpResponse.statusCode) else {
      throw APIError.statusCode(httpResponse.statusCode)
    }

    if data.isEmpty, E.Response.self == EmptyResponse.self {
      return EmptyResponse() as! E.Response
    }

    do {
      return try JSONDecoder().decode(E.Response.self, from: data)
    } catch {
      throw APIError.decodingFailed(error)
    }
  }
}

extension APIClient {
  static var basePath: String {
    "http://localhost:4000"
  }
}
