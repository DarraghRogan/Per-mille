//
//  DataLoader.swift
//  CreatorMenu
//
//  Created by Darragh Rogan on 08/06/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

public class DataLoader {
    
    @Published var newsData = NewsFeed()
    
    init(){
        loadNews()
    }
    
    func loadNews() {
        
        //hit the API
            let urlString = "https://newsapi.org/v2/everything?q=ireland&apiKey=c594b867c99143179c9346a97171b22a"
            let url = URL(string: urlString)
            guard url != nil else {
                return
            }
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url!) { (data, response, error) in
                //check for errors
                if error == nil && data != nil {
                    //Parse JSON
                    let decoder = JSONDecoder()
                    do {
                        let dataFromNewsFeed = try decoder.decode(NewsFeed.self, from: data!)
//                       print(dataFromNewsFeed)
                        self.newsData = dataFromNewsFeed
                        print(self.newsData)
                    }
                    catch {
                        print("Error in JSON parsing")
                    }
            }
        }
            //Make the API Call
                dataTask.resume()

    }
    
}
