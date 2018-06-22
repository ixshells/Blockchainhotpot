//
//  KnowledgebaseDetails.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 02/05/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import Foundation

struct KnowledgeInfo: Codable {
    var title: String
    var detailsUrl: String?
}

struct Knowledges: Codable {
    var results: [KnowledgeInfo]
}
