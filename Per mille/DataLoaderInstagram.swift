//
//  DataLoader.swift
//  CreatorMenu
//
//  Created by Darragh Rogan on 08/06/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the instagram JSON that will be decoded
struct InstagramDataStructure: Codable{
    var follower: Int = 0
    var average_like: Int = 0
}

// define an instance of the instragram data that can be filled by the data loader and read by the menu
var instagramData = InstagramDataStructure()


 public class DataLoaderInstagram {
    
//    init(){
//       loadInstagramData()
//    }
    
    func loadInstagramData() {

        let headers = [
            "x-rapidapi-host": "easy-instagram-service.p.rapidapi.com",
            "x-rapidapi-key": "\(APIKeyRapidAPI)"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://easy-instagram-service.p.rapidapi.com/username?username=\(AppDelegate().defaults.object(forKey:"InstagramUsername") as? String ?? String())")! as URL,
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
//                print("InstaAPIhit")
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromInstagram = try decoder.decode(InstagramDataStructure.self, from: data!)
                    instagramData = dataFromInstagram
 //                   print(self.instagramData)
 //                   print(instagramData.follower)
//                    AppDelegate.menuRefresh(AppDelegate)
                }
                catch {
                    print("Error in Instagram JSON parsing")
                }
            }
        })

        dataTask.resume()
    }
 }
