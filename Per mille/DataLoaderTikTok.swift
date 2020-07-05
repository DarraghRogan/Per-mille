//
//  DataLoader.swift
//  Per mille
//
//  Created by Darragh Rogan on 08/06/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io

struct TikTokDataStructure: Codable {
    var data: DataClass?
    var success: Bool = false
}

struct DataClass: Codable {
   var statusCode: Int
    var userInfo: UserInfo?
}
//
struct UserInfo: Codable {
//   var shareMeta: [ShareMeta]?
    var stats: Stats?
    var user: User?
}

//struct ShareMeta: Codable {
//    var desc: String = ""
//    var title: String = ""
//}

struct Stats: Codable {
//    var diggCount: Int = 0
    var followerCount: Int = 0
//    var followingCount: Int = 0
//    var heart: Int = 0
    var heartCount: Int = 0
//    var videoCount: Int = 0
}

struct User: Codable {
//    var avatarLarger: String = ""
//    var avatarMedium: String = ""
//    var avatarThumb: String = ""
//    var bioLink: [BioLink]?
//    var id: String = ""
//    var nickname: String = ""
//    var openFavorite: Bool = false
//    var relation: Int = 0
//    var secUid: String = ""
//    var secret: Bool = false
//    var signature: String = ""
    var uniqueID: String = ""
//    var verified: Bool = false

    enum CodingKeys: String, CodingKey {
//        case avatarLarger, avatarMedium, avatarThumb, bioLink, id, nickname, openFavorite, relation, secUid, secret, signature
        case uniqueID = "uniqueId"
 //       case verified
    }
}

//struct BioLink: Codable {
//    var link: String = ""
//    var risk: Int = 0
//}

// define an instance of the twwitter data that can be filled by the data loader and read by the menu
var tikTokData = TikTokDataStructure()

 public class DataLoaderTikTok {
    
    func loadTikTokData() {

        let headers = [
            "x-rapidapi-host": "tiktok2.p.rapidapi.com",
            "x-rapidapi-key": "\(APIKeyRapidAPI)"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://tiktok2.p.rapidapi.com/user/object/full?username=\(AppDelegate().defaults.object(forKey:"TikTokUsername") as? String ?? String())")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 62.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
//                print("Received from the TikTok API")
//                if let data = data,
//                    let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
                
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromTikTok = try decoder.decode(TikTokDataStructure.self, from: data!)
                    tikTokData = dataFromTikTok
//                    print(data)
//                    print(twitterData.followers)

                }
                catch {
                    print("Error in TikTok JSON parsing")
//                    print(twitterData)
                }
            }
        })

        dataTask.resume()
    }
 }
