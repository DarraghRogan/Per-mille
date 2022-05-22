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
//    var pageInfo: PageInfo?
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

//struct ContentDetails: Codable {
//    var relatedPlaylists: RelatedPlaylists?
//}
//
//struct RelatedPlaylists: Codable {
//    var likes, favorites, uploads, watchHistory: String?
//    var watchLater: String? = ""
//}

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

//struct Thumbnails: Codable {
//    var thumbnailsDefault, medium, high: Default?
//
//    enum CodingKeys: String, CodingKey {
//        case thumbnailsDefault
//        case medium, high
//    }
//}

//struct Default: Codable {
//    var url: String?
//    var width, height: String?
//}

struct Statistics: Codable {
    var viewCount: String? = "0"
    var commentCount: String? = "0"
    var subscriberCount: String? = "0"
    var hiddenSubscriberCount: Bool?
//    var videoCount: Int = 0
}

//struct PageInfo: Codable {
//    var totalResults: Int = 0
//    var resultsPerPage: Int = 0
//}

// MARK: -

struct YouTubeDataStructureSearch: Codable {
//    var kind, etag, nextPageToken, regionCode: String
    var pageInfo: SearchPageInfo?
    var items: [SearchItem]?
   
}

struct SearchItem: Codable {
//    var kind, etag: String
    var id: ID
//    var snippet: Snippet
}

struct ID: Codable {
    var kind: String?
    var videoID: String? = ""

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

//struct Snippet: Codable {
//    var publishedAt: Date
//    var channelID, title, snippetDescription: String
//    var thumbnails: Thumbnails
//    var channelTitle, liveBroadcastContent: String
//    var publishTime: Date
//
//    enum CodingKeys: String, CodingKey {
//        case publishedAt
//        case channelID = "channelId"
//        case title
//        case snippetDescription = "description"
//        case thumbnails, channelTitle, liveBroadcastContent, publishTime
//    }
//}


//struct Thumbnails: Codable {
//    var thumbnailsDefault, medium, high: Default
//
//    enum CodingKeys: String, CodingKey {
//        case thumbnailsDefault = "default"
//        case medium, high
//    }
//}


//struct Default: Codable {
//    var url: String
//    var width, height: Int
//}


struct SearchPageInfo: Codable {
    var totalResults: Int? = 0
    var resultsPerPage: Int? = 0
}


// MARK: -



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
//    var dislikeCount: String
    var favoriteCount: String
    var commentCount: String? =  "0"
}

struct VideosPageInfo: Codable {
//    var totalResults: Int? = 0
    var resultsPerPage: Int? = 0
}







// define an instance of the youtube data that can be filled by the data loader and read by the menu
var youTubeData = YouTubeDataStructureChannels()

var youTubeDataSearch = YouTubeDataStructureSearch()

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
    
//MARK: -
    
    
    func loadYouTubeDataSearch() {

            let headers = [
    //            "Authorization": "Bearer [YOUR_ACCESS_TOKEN]",
                "Accept": "application/json"
            ]

            let request = NSMutableURLRequest(url: NSURL(string: "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=\(AppDelegate().defaults.object(forKey:"YouTubeChannelID") as? String ?? String())&order=date&key=\(APIKeyYouTube)&maxResults=1")! as URL,
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
//               print("Received from the YouTube Search API")
//                if let data = data,
//                 let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                  print(urlContent)
//               } else {
//                    print("error with printing string encoded data")
//                }
                    //Parse JSON
                    let decoder = JSONDecoder()
                    do {
                        let dataFromYouTubeSearch = try decoder.decode(YouTubeDataStructureSearch.self, from: data!)
                        youTubeDataSearch = dataFromYouTubeSearch
                    }
                    catch {
                        print("Error in YouTube Search JSON parsing")
    //                    print(youTubeData)
                    }
                }
            })

            dataTask.resume()
        }
    
    
    func loadYouTubeDataVideos() {
        
        if youTubeData.items?[0].id != nil{

                let headers = [
        //            "Authorization": "Bearer [YOUR_ACCESS_TOKEN]",
                    "Accept": "application/json"
                ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=\(youTubeDataSearch.items?[0].id.videoID ?? "")&key=\(APIKeyYouTube)")! as URL,
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
            else
            {
            }
            
            }
    
    
    
    
 }
