//
//  BlockchainProjects.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 19/05/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import Foundation

struct BlcokchainProjectInfo: Codable {
    var title: String
    var detailsLink: String
    var description: String?
}



struct BlockchainProjects: Codable {
    var results: [BlcokchainProjectInfo]
    var cursor: String?
}


class Student: NSObject {

    var name: String? {
        didSet {
            print("调用了didSet方法")
        }
    }

    override init() {

    }
    init(name: String) {
        self.name = name
    }

    func testDidSet() {
        name = "Ocean"
    }
}
