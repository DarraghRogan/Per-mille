//
//  NewsFeed.swift
//  CreatorMenu
//
//  Created by Darragh Rogan on 07/06/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

struct NewsFeed: Codable{
    var status: String = ""
    var totalResults: Int = 0
    var articles:[Article]?
}
