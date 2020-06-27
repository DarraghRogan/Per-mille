//
//  DataLoader.swift
//  CreatorMenu
//
//  Created by Darragh Rogan on 08/06/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the instagram JSON that will be decoded - came from https://app.quicktype.io and YouTube v3 API

struct YouTubeDataStructure: Codable {
    var kind: String = ""
    var etag: String = ""
    var pageInfo: PageInfo?
    var items: [Item]?
}

struct Item: Codable {
    var kind: String = ""
    var etag: String = ""
    var id: String = ""
    var snippet: Snippet
//    var contentDetails: ContentDetails?
    var statistics: Statistics
}

struct ContentDetails: Codable {
    var relatedPlaylists: RelatedPlaylists?
}

struct RelatedPlaylists: Codable {
    var likes, favorites, uploads, watchHistory: String?
    var watchLater: String? = ""
}

struct Snippet: Codable {
    var title: String = ""
//    var snippetDescription,
//    var customURL: String?
//    var publishedAt: Date?
//    var thumbnails: Thumbnails?
//    var localized: Localized?
//    var country: String? = ""

//    enum CodingKeys: String, CodingKey {
//        case title
//        case snippetDescription
//        case customURL
//        case publishedAt, thumbnails, localized, country
//    }
}

struct Localized: Codable {
    var title, localizedDescription: String?

    enum CodingKeys: String, CodingKey {
        case title
        case localizedDescription
    }
}

struct Thumbnails: Codable {
    var thumbnailsDefault, medium, high: Default?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault
        case medium, high
    }
}

struct Default: Codable {
    var url: String?
    var width, height: String?
}

struct Statistics: Codable {
    var viewCount: String
    var commentCount: String
    var subscriberCount: String
    var hiddenSubscriberCount: Bool
//    var videoCount: Int = 0
}

struct PageInfo: Codable {
    var totalResults: Int = 0
    var resultsPerPage: Int = 0
}

// define an instance of the youtube data that can be filled by the data loader and read by the menu
var youTubeData = YouTubeDataStructure()

 public class DataLoaderYouTube {
    
    init(){
       loadYouTubeData()
    }
    
    func loadYouTubeData() {

        let headers = [
//            "Authorization": "Bearer [YOUR_ACCESS_TOKEN]",
            "Accept": "application/json"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://www.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&id=\(AppDelegate().defaults.object(forKey:"YouTubeChannelID") as? String ?? String())&key=\(APIKeyYouTube)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromYouTube = try decoder.decode(YouTubeDataStructure.self, from: data!)
                    youTubeData = dataFromYouTube
//                    print(youTubeData)
                }
                catch {
                    print("Error in YouTube JSON parsing")
//                    print(youTubeData)
                }
            }
        })

        dataTask.resume()
    }
 }
