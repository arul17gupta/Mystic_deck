//
//  api.swift
//  Mystic Deck
//
//  Created by user1 on 25/02/24.
//
import Foundation

func callAPI(endpoint: String, method: String, formData: [String: String] = [:], completion: @escaping (String?) -> Void) {
    // Construct the full URL using the base URL and the endpoint
    guard let baseURL = URL(string: "https://1a02-2409-408d-493-9c45-f4e8-94d8-cd0-4663.ngrok-free.app/") else {
        print("Invalid base URL")
        completion(nil)
        return
    }
    
    guard let url = URL(string: endpoint, relativeTo: baseURL) else {
        print("Invalid endpoint URL")
        completion(nil)
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.uppercased() // Convert method to uppercase
    
    if method.uppercased() == "POST" {
        // Encode the form data if it's a POST request
        request.httpBody = formData
            .map { key, value in "\(key)=\(value)" }
            .joined(separator: "&")
            .data(using: .utf8)
        
        // Set the content type header
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    }

    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print("Error: \(error?.localizedDescription ?? "Unknown error")")
            completion(nil)
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
            // Handle successful response
            if let responseString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    completion(responseString)
                }
            }
        } else {
            // Handle unsuccessful response
            print("HTTP Response Error: \(response.debugDescription)")
            completion(nil)
        }
    }.resume()
}

