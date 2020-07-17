//
//  DataLoader.swift
//  Per mille
//
//  Created by Darragh Rogan on 08/06/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the instagram JSON that will be decoded - came from https://app.quicktype.io and YouTube v3 API

struct YouTubeDataStructureChannels: Codable {
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
//    var customURL: String = ""
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



struct YouTubeDataStructureActivities: Codable {
    var kind: String = ""
    var etag: String = ""
    var items: [ActivitiesItem]?
//    var nextPageToken: String = ""
//    var pageInfo: ActivitiesPageInfo?
}

struct ActivitiesItem: Codable {
    var kind: String = ""
    var etag: String = ""
    var id: String = ""
//    var snippet: ActivitiesSnippet
    var contentDetails: ActivitiesContentDetails
}

struct ActivitiesContentDetails: Codable {
    var upload: ActivitiesUpload
}

struct ActivitiesUpload: Codable {
    var videoID: String = ""

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
    }
}

struct ActivitiesSnippet: Codable {
    var publishedAt: Date
    var channelID, title, snippetDescription: String
    var thumbnails: ActivitiesThumbnails
    var channelTitle: String = ""
    var type: String = ""
    var groupID: String = ""

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle, type
        case groupID = "groupId"
    }
}

struct ActivitiesThumbnails: Codable {
    var thumbnailsDefault, medium, high, standard: ActivitiesDefault
    var maxres: ActivitiesDefault

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard, maxres
    }
}

struct ActivitiesDefault: Codable {
    var url: String
    var width, height: Int
}

struct ActivitiesPageInfo: Codable {
    var totalResults, resultsPerPage: Int
}







struct YouTubeDataStructureVideos: Codable {
    var kind: String? = ""
//    var etag: String?
    var items: [VideosItem]?
    var pageInfo: VideosPageInfo?
}

struct VideosItem: Codable {
//    var kind, etag, id: String
//    var snippet: Snippet
//    var contentDetails: ContentDetails
    var statistics: VideosStatistics
}

//struct ContentDetails: Codable {
//    var duration, dimension, definition, caption: String
//    var licensedContent: Bool
//    var contentRating: ContentRating
//    var projection: String
//}

//struct ContentRating: Codable {
//}

//struct Snippet: Codable {
//    var publishedAt: Date
//    var channelID, title, snippetDescription: String
//    var thumbnails: Thumbnails
//    var channelTitle: String
//    var tags: [String]
//    var categoryID, liveBroadcastContent: String
//    var localized: Localized
//    var defaultAudioLanguage: String
//
//    enum CodingKeys: String, CodingKey {
//        case publishedAt
//        case channelID = "channelId"
//        case title
//        case snippetDescription = "description"
//        case thumbnails, channelTitle, tags
//        case categoryID = "categoryId"
//        case liveBroadcastContent, localized, defaultAudioLanguage
//    }
//}

//struct Localized: Codable {
//    var title, localizedDescription: String
//
//    enum CodingKeys: String, CodingKey {
//        case title
//        case localizedDescription = "description"
//    }
//}

//struct Thumbnails: Codable {
//    var thumbnailsDefault, medium, high, standard: Default
//    var maxres: Default
//
//    enum CodingKeys: String, CodingKey {
//        case thumbnailsDefault = "default"
//        case medium, high, standard, maxres
//    }
//}

//struct Default: Codable {
//    var url: String
//    var width, height: Int
//}

struct VideosStatistics: Codable {
    var viewCount: String
    var likeCount: String
    var dislikeCount: String
    var favoriteCount: String
    var commentCount: String
}

struct VideosPageInfo: Codable {
//    var totalResults: Int? = 0
    var resultsPerPage: Int? = 0
}







// define an instance of the youtube data that can be filled by the data loader and read by the menu
var youTubeData = YouTubeDataStructureChannels()

var youTubeDataActivities = YouTubeDataStructureActivities()

var youTubeDataVideos = YouTubeDataStructureVideos()


 public class DataLoaderYouTube {
    
//    init(){
//       loadYouTubeData()
//    }
    
    func loadYouTubeDataChannel() {

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
//                print("Received from the YouTube Channels API")
//                if let data = data,
//                    let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromYouTube = try decoder.decode(YouTubeDataStructureChannels.self, from: data!)
                    youTubeData = dataFromYouTube
//                    print(youTubeData)
                }
                catch {
                    print("Error in YouTube Channel JSON parsing")
//                    print(youTubeData)
                }
            }
        })

        dataTask.resume()
    }
    
    
    
    
    func loadYouTubeDataActivities() {

            let headers = [
    //            "Authorization": "Bearer [YOUR_ACCESS_TOKEN]",
                "Accept": "application/json"
            ]

            let request = NSMutableURLRequest(url: NSURL(string: "https://www.googleapis.com/youtube/v3/activities?part=snippet%2CcontentDetails&channelId=\(AppDelegate().defaults.object(forKey:"YouTubeChannelID") as? String ?? String())&key=\(APIKeyYouTube)&maxResults=1")! as URL,
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
//               print("Received from the YouTube Activities API")
//                if let data = data,
//                 let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                  print(urlContent)
//               } else {
//                    print("error with printing string encoded data")
//                }
                    //Parse JSON
                    let decoder = JSONDecoder()
                    do {
                        let dataFromYouTubeActivities = try decoder.decode(YouTubeDataStructureActivities.self, from: data!)
                        youTubeDataActivities = dataFromYouTubeActivities
                    }
                    catch {
                        print("Error in YouTube Activities JSON parsing")
    //                    print(youTubeData)
                    }
                }
            })

            dataTask.resume()
        }
    
    
    func loadYouTubeDataVideos() {

                let headers = [
        //            "Authorization": "Bearer [YOUR_ACCESS_TOKEN]",
                    "Accept": "application/json"
                ]

                let request = NSMutableURLRequest(url: NSURL(string: "https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=\(youTubeDataActivities.items?[0].contentDetails.upload.videoID ?? "")&key=\(APIKeyYouTube)")! as URL,
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
//               print("Received from the YouTube Videos API")
//                if let data = data,
//                 let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                  print(urlContent)
//               } else {
//                    print("error with printing string encoded data")
//                }
                        //Parse JSON
                        let decoder = JSONDecoder()
                        do {
                            let dataFromYouTubeVideos = try decoder.decode(YouTubeDataStructureVideos.self, from: data!)
                            youTubeDataVideos = dataFromYouTubeVideos
//                            print(youTubeDataVideos.items?[0].statistics.viewCount as! String)
                        }
                        catch {
                            print("Error in YouTube Videos JSON parsing")
        //                    print(youTubeData)
                        }
                    }
                })

                dataTask.resume()
            }
    
    
    
    
 }
