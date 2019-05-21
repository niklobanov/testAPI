//
//  PostModel.swift
//  TestAPI
//
//  Created by Никита on 19/05/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import Foundation

struct AllPost {
    let status: Int
    let data: [[PostModel]]

    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}

extension AllPost: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decode(Int.self, forKey: .status)
        data = try values.decode([[PostModel]].self, forKey: .data)
    }
}

struct PostModel{
    let id: String
    let body: String
    let da: String
    let dm: String

    enum CodingKeys: String, CodingKey {
        case id
        case body
        case da
        case dm
    }
}

extension PostModel: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        body = try values.decode(String.self, forKey: .body)
        da = try values.decode(String.self, forKey: .da)
        dm = try values.decode(String.self, forKey: .dm)
    }
}
