//
//  DataLoader.swift
//  CreatorMenu
//
//  Created by Darragh Rogan on 08/06/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the JSON that will be decoded - came from https://app.quicktype.io

struct TwitterDataStructure: Codable {
    var screen_name: String = ""
//    var userID: String
//    var lastupdate: String
    var followers: String = ""
//    var country, gender: String
//    var profiles: [String]
//    var peergroups: [Peergroup]

 //   enum CodingKeys: String, CodingKey {
 //       case screenName
 //       case userID
 //       case lastupdate, followers, country, gender, profiles, peergroups
 //   }
}

struct Peergroup: Codable {
    var topic, region, rank: String
}

// define an instance of the twwitter data that can be filled by the data loader and read by the menu
var twitterData = TwitterDataStructure()

 public class DataLoaderTwitter {
    
//    init(){
//       loadTwitterData()
//    }
    
    func loadTwitterData() {

        let headers = [
            "x-rapidapi-host": "peerreach-peerreach-subscription.p.rapidapi.com",
            "x-rapidapi-key": "\(APIKeyRapidAPI)"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://peerreach-peerreach-subscription.p.rapidapi.com/user/lookup.json?screen_name=\(AppDelegate().defaults.object(forKey:"TwitterHandle") as? String ?? String())")! as URL,
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
                print("Hit the Twitter API")
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
//                    print(twitterData.screen_name)
//                    print(twitterData.followers)

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
