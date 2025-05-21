//
//  Endpoint.swift
//  ClassesApp
//
//  Created by Tarek Radovan on 21/05/2025.
//

/// A protocol that represents an API endpoint definition.
///
/// Types conforming to this protocol define how a specific API request should be built,
/// including the HTTP method, path, and parameters. The expected response type must conform to `Decodable`.
///
/// 🔧 **Future Improvements:**
/// - Add support for custom headers, e.g., for access tokens or content-type overrides.
/// - Allow optional configuration for timeout, caching policy, or other `URLRequest` properties.
protocol Endpoint {

  /// The type expected to be returned from the request, which must conform to `Decodable`.
  associatedtype Response: Decodable

  /// The HTTP method to use (e.g., `.get`, `.post`, `.delete`, `.put`).
  var method: HTTPMethod { get }

  /// The relative path to be appended to the base URL (e.g., `"classes"` or `"saved_classes"`).
  var path: String { get }

  /// Optional request parameters.
  ///
  /// For GET/DELETE requests, these are added as query parameters.
  /// For POST/PUT requests, these are encoded as a JSON body.
  var parameters: [String: Any?]? { get }
}
