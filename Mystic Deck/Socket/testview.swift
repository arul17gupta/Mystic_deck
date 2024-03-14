import SwiftUI

struct TestView: View {
    @State private var responseData: String = "No response yet"
    
    var body: some View {
        VStack {
            Text(responseData)
            
                .padding()
            
            Button("Call API") {
                callAPI(endpoint: "/create_room", method: "POST", formData: ["creator_id": "123", "room_id": "456"])

            }
            .padding()
            
            Button("Call Socket") {
                DataSocketManager.shared.establishSocketConnection()

            }
            .padding()
        }
    }
    
    func callAPI(endpoint: String, method: String, formData: [String: String] = [:]) {
        // Construct the full URL using the base URL and the endpoint
        guard let baseURL = URL(string: "http://127.0.0.1:5000") else {
            print("Invalid base URL")
            return
        }
        
        guard let url = URL(string: endpoint, relativeTo: baseURL) else {
            print("Invalid endpoint URL")
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
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                // Handle successful response
                if let responseString = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.responseData = responseString
                    }
                }
            } else {
                // Handle unsuccessful response
                print("HTTP Response Error: \(response.debugDescription)")
            }
        }.resume()
    }

}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

