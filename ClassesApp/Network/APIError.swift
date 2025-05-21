//
//  APIError.swift
//  ClassesApp
//
//  Created by Tarek Radovan on 21/05/2025.
//

import Foundation

/// Represents common API-level errors thrown by the `APIClient`.
///
/// This enum handles validation, encoding/decoding, and basic HTTP error codes.
///
/// **Potential Improvements:**
/// - Add a `.serverError(CustomError)` case to decode backend-specific error objects for more meaningful feedback.
/// - Include support for networking layer retries or recovery actions.
/// - Separate error domains (e.g., transport vs. decoding vs. server) more explicitly.
enum APIError: Error {
  
  /// URL creation failed or the path is malformed.
  case invalidURL
  
  /// A request-level failure (e.g., connectivity issue, timeouts).
  case requestFailed(Error)
  
  /// Response received was not a valid `HTTPURLResponse`.
  case invalidResponse
  
  /// Received HTTP status code outside the success range (200–299).
  case statusCode(Int)
  
  /// Failed to decode the response from the server.
  case decodingFailed(Error)
  
  /// Failed to encode the request body into JSON.
  case encodingFailed(Error)

  /// Human-readable error messages, useful for debugging or UI feedback.
  var message: String {
    switch self {
    case .invalidURL:
      return "The URL is invalid or malformed."
      
    case .requestFailed(let error):
      return "The request could not be completed: \(error.localizedDescription)"
      
    case .invalidResponse:
      return "The server response was invalid."
      
    case .statusCode(let code):
      switch code {
      case 400: return "Bad request (400)."
      case 401: return "Unauthorized access (401)."
      case 403: return "Forbidden request (403)."
      case 404: return "Resource not found (404)."
      case 500: return "Internal server error (500)."
      default:  return "Unexpected HTTP error: \(code)."
      }
      
    case .decodingFailed(let error):
      return "Failed to decode the server response: \(error.localizedDescription)"
      
    case .encodingFailed(let error):
      return "Failed to encode the request body: \(error.localizedDescription)"
    }
  }
}
