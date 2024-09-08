//
//  NetworkManager.swift
//  gratify
//
//  Created by Daniel Kim on 4/22/24.
//

import Foundation

enum NetworkError: String, Error {
    case networkError
    case invalidURL
    case decodingError
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

class OpenAIService {
    static let shared = OpenAIService()
    
    private let OpenAIChatEndpoint = "https://api.openai.com/v1/chat/completions"
    
    private init () { }
    
    // configures a URLRequest object by adding headers and encoding the request body with JSON data
    func generateURLRequest(httpMethod: HTTPMethod, message: String) async throws -> URLRequest {
        guard let url = URL(string: OpenAIChatEndpoint) else {
            print("Invalid URL")
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(Secrets.apiKey)", forHTTPHeaderField: "Authorization")
        
        // Body - encodes message based on a set of parameters for GPT to process
        let systemMessage = GPTMessage(role: "assistant", content: "You are a helpful summarizer.")
        let userMessage = GPTMessage(role: "user", content: message)
        
        let overallMood = GPTFunctionProperty(type: "integer", description: "A number between 1 to 10 where a number closer to 1 corresponds to a gratitude that is more focused on experiences, whereas a number closer to 10 corresponds to a gratitude that is more focused on materialistic things.")
        let overallRating = GPTFunctionProperty(type: "integer", description: "A number between 1 and 7, inclusive.")
        let top5MindfulStuff = GPTFunctionProperty(
            type: "array",
            description: "A list of the top 5 things I've been mindful of.",
            items: GPTFunctionPropertyItem(type: "string", description: "A mindful thing.")
        )
        let homePageNumber = GPTFunctionProperty(type: "integer", description: "A random number between 1 and 10")
        let recap = GPTFunctionProperty(type: "string", description: "A brief, thoughtful summary of key things worth highlighting from the user entries.")
        
        let params: [String: GPTFunctionProperty] = [
            "overall mood": overallMood,
            "overall rating": overallRating,
            "top 5 mindful things": top5MindfulStuff,
            "random number": homePageNumber,
            "recap": recap
        ]
        let functionParams = GPTFunctionParam(type: "object", properties: params, required: ["overall mood", "overall rating", "top 5 mindful things", "random number", "recap"])
        let function = GPTFunction(name: "get_summary", description: "Summarize my month or year based on the set of inputs", parameters: functionParams)
        let payload = GPTChatPayload(model: "gpt-3.5-turbo", messages: [systemMessage, userMessage], functions: [function])
        
        // encode the input as json data
        let jsonData = try JSONEncoder().encode(payload)
        
        request.httpBody = jsonData
        
        return request
    }
    
    // performs the API call and parsing of JSON data
    func fetchGPTMessage(message: String) async throws -> SummaryResponse {
        let request = try await generateURLRequest(httpMethod: .post, message: message)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        print(String(data: data, encoding: .utf8)!) // for debugging purposes
        
        let result = try JSONDecoder().decode(GPTResponse.self, from: data) // decode the response
        
        let args = result.choices[0].message.functionCall.arguments
        
        guard let argData = args.data(using: .utf8) else {
            throw NetworkError.invalidURL
        }
        
        let summary = try JSONDecoder().decode(SummaryResponse.self, from: argData) // decode the arguments of the response
        
        print(summary)
        return summary
        
    }
    
}

