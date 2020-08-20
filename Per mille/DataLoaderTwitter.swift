//
//  DataLoader.swift
//  Per mille
//
//  Created by Darragh Rogan on 08/06/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io

//struct TwitterDataStructure: Codable {
//    var screen_name: String = ""
////    var userID: String
////    var lastupdate: String
//    var followers: String = ""
////    var country, gender: String
////    var profiles: [String]
////    var peergroups: [Peergroup]
//
// //   enum CodingKeys: String, CodingKey {
// //       case screenName
// //       case userID
// //       case lastupdate, followers, country, gender, profiles, peergroups
// //   }
//}
//
//struct Peergroup: Codable {
//    var topic, region, rank: String
//}


// User's Twitter v2 API
struct TwitterDataStructure: Codable {
    var data: [Datum]?
    var includes: Includes?
}

// MARK: - Datum
struct Datum: Codable {
    var publicMetrics: DatumPublicMetrics
    var id: String
    var pinnedTweetID: String?
    var name: String
    var username: String

    enum CodingKeys: String, CodingKey {
        case publicMetrics = "public_metrics"
        case id
        case pinnedTweetID = "pinned_tweet_id"
        case name, username
    }
}

// MARK: - DatumPublicMetrics
struct DatumPublicMetrics: Codable {
    var followersCount, followingCount, tweetCount, listedCount: Int

    enum CodingKeys: String, CodingKey {
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case tweetCount = "tweet_count"
        case listedCount = "listed_count"
    }
}

// MARK: - Includes
struct Includes: Codable {
    var tweets: [Tweet]
}

// MARK: - Tweet
struct Tweet: Codable {
    var id: String
    var publicMetrics: TweetPublicMetrics
    var text, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case publicMetrics = "public_metrics"
        case text
        case createdAt = "created_at"
    }
}

// MARK: - TweetPublicMetrics
struct TweetPublicMetrics: Codable {
    var retweetCount, replyCount, likeCount, quoteCount: Int?

    enum CodingKeys: String, CodingKey {
        case retweetCount = "retweet_count"
        case replyCount = "reply_count"
        case likeCount = "like_count"
        case quoteCount = "quote_count"
    }
}




// define an instance of the twwitter data that can be filled by the data loader and read by the menu
var twitterData = TwitterDataStructure()

 public class DataLoaderTwitter {
    
//    init(){
//       loadTwitterData()
//    }
    
    func loadTwitterData() {

//        let headers = [
//            "x-rapidapi-host": "peerreach-peerreach-subscription.p.rapidapi.com",
//            "x-rapidapi-key": "\(APIKeyRapidAPI)"
//        ]
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://peerreach-peerreach-subscription.p.rapidapi.com/user/lookup.json?screen_name=\(AppDelegate().defaults.object(forKey:"TwitterHandle") as? String ?? String())")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                                timeoutInterval: 10.0)
        
        let headers = [
            "Authorization": "Bearer \(APIKeyTwitter)",
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.twitter.com/2/users/by?usernames=\(AppDelegate().defaults.object(forKey:"TwitterHandle") as? String ?? String())&user.fields=public_metrics&expansions=pinned_tweet_id&tweet.fields=created_at,public_metrics")! as URL,
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
//                print("Received from the Twitter API")
//                if let data = data,
//                    let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromTwitter = try decoder.decode(TwitterDataStructure.self, from: data!)
                    twitterData = dataFromTwitter
//                    print(twitterData.data?[0].username)
//                    print(twitterData.data?[0].publicMetrics.followersCount)

                }
                catch {
                    print("Error in Twitter JSON parsing")
//                    print(twitterData)
                }
            }
        })

        dataTask.resume()
    }
 }
