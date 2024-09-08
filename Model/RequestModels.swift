//
//  RequestModels.swift
//  gratify
//
//  Created by Daniel Kim on 4/22/24.
//

import Foundation

import Foundation

struct GPTChatPayload: Encodable {
    let model: String
    let messages: [GPTMessage]
    let functions: [GPTFunction]
}

struct GPTMessage: Encodable {
    let role: String // system/user
    let content: String // message
}

struct GPTFunction: Encodable {
    let name: String
    let description: String
    let parameters: GPTFunctionParam
}
    
struct GPTFunctionParam: Encodable {
    let type: String
    let properties: [String : GPTFunctionProperty]
    let required: [String]?
}

struct GPTFunctionProperty: Encodable {
    let type: String
    let description: String
    let items: GPTFunctionPropertyItem?
    
    init(type: String, description: String, items: GPTFunctionPropertyItem? = nil) {
        self.type = type
        self.description = description
        self.items = items
    }
}

struct GPTFunctionPropertyItem: Encodable {
    let type: String
    let description: String
}
