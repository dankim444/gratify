//
//  ResponseModels.swift
//  gratify
//
//  Created by Daniel Kim on 4/22/24.
//

import Foundation

struct GPTResponse: Decodable {
    let choices: [GPTCompletion]
}

struct GPTCompletion: Decodable {
    let message: GPTResponseMessage
}

struct GPTResponseMessage: Decodable {
    let functionCall: GPTFunctionCall
    
    enum CodingKeys: String, CodingKey {
        case functionCall = "function_call"
    }
}

struct GPTFunctionCall: Decodable {
    let name: String
    let arguments: String
}

struct SummaryResponse: Decodable {
    let overallMood: Int
    let overallRating: Int
    let top5MindfulStuff: [String]
    let homePageNumber: Int
    let recap: String
    
    enum CodingKeys: String, CodingKey {
        case overallMood = "overall mood"
        case overallRating = "overall rating"
        case top5MindfulStuff = "top 5 mindful things"
        case homePageNumber = "random number"
        case recap = "recap"
    }
}

