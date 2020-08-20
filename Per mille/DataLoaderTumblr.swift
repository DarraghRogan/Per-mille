//
//  DataLoader.swift
//  Per mille
//
//  Created by Darragh Rogan on 08/06/2020.
//  Copyright © 2020 Darragh Rogan. All rights reserved.
//

import Foundation

// define the strucutre of the instagram JSON that will be decoded - came from https://app.quicktype.io

struct TumblrDataStructure: Codable {
    var meta: TumblrMeta?
    var response: TumblrResponse?
}


struct TumblrMeta: Codable {
    var status: Int
    var msg: String
}


struct TumblrResponse: Codable {
    var blog: TumblrResponseBlog
    var posts: [TumblrPost]
    var totalPosts: Int
    var links: TumblrLinks

    enum CodingKeys: String, CodingKey {
        case blog
        case posts
        case totalPosts = "total_posts"
        case links = "_links"
    }
}


struct TumblrResponseBlog: Codable {
    var ask, askAnon: Bool
    var askPageTitle: String
    var asksAllowMedia: Bool
    var avatar: [TumblrAvatar]
    var canChat, canSubscribe: Bool
    var blogDescription: String
    var isNsfw: Bool
    var name: String
    var posts: Int
    var shareLikes, subscribed: Bool
    var theme: TumblrTheme
    var title: String
    var totalPosts, updated: Int
    var url: String
    var uuid: String
    var isOptoutAds: Bool

    enum CodingKeys: String, CodingKey {
        case ask
        case askAnon = "ask_anon"
        case askPageTitle = "ask_page_title"
        case asksAllowMedia = "asks_allow_media"
        case avatar
        case canChat = "can_chat"
        case canSubscribe = "can_subscribe"
        case blogDescription = "description"
        case isNsfw = "is_nsfw"
        case name, posts
        case shareLikes = "share_likes"
        case subscribed, theme, title
        case totalPosts = "total_posts"
        case updated, url, uuid
        case isOptoutAds = "is_optout_ads"
    }
}


struct TumblrAvatar: Codable {
    var width, height: Int
    var url: String
}


struct TumblrTheme: Codable {
    var headerFullWidth, headerFullHeight: Int
    var avatarShape, backgroundColor, bodyFont, headerBounds: String
    var headerImage, headerImageFocused: String
    var headerImagePoster: String
    var headerImageScaled: String
    var headerStretch: Bool
    var linkColor: String
    var showAvatar, showDescription, showHeaderImage, showTitle: Bool
    var titleColor, titleFont, titleFontWeight: String

    enum CodingKeys: String, CodingKey {
        case headerFullWidth = "header_full_width"
        case headerFullHeight = "header_full_height"
        case avatarShape = "avatar_shape"
        case backgroundColor = "background_color"
        case bodyFont = "body_font"
        case headerBounds = "header_bounds"
        case headerImage = "header_image"
        case headerImageFocused = "header_image_focused"
        case headerImagePoster = "header_image_poster"
        case headerImageScaled = "header_image_scaled"
        case headerStretch = "header_stretch"
        case linkColor = "link_color"
        case showAvatar = "show_avatar"
        case showDescription = "show_description"
        case showHeaderImage = "show_header_image"
        case showTitle = "show_title"
        case titleColor = "title_color"
        case titleFont = "title_font"
        case titleFontWeight = "title_font_weight"
    }
}


struct TumblrLinks: Codable {
    var next: TumblrNext
}


struct TumblrNext: Codable {
    var href, method: String
    var queryParams: TumblrQueryParams

    enum CodingKeys: String, CodingKey {
        case href, method
        case queryParams = "query_params"
    }
}


struct TumblrQueryParams: Codable {
    var limit, offset, pageNumber: String

    enum CodingKeys: String, CodingKey {
        case limit, offset
        case pageNumber = "page_number"
    }
}


struct TumblrPost: Codable {
//    var type, blogName: String
////    var blog: TumblrPostBlog
//    var id: Double
//    var idString: String
//    var postURL: String
//    var slug, date: String
//    var timestamp: Int
//    var state, format, reblogKey: String
////  var tags: [String]
//    var shortURL: String
//    var summary: String
//    var shouldOpenInLegacy: Bool
////    var recommendedSource, recommendedColor: TumblrJSONNull?
    var noteCount: Int
//    var caption: String
////    var reblog: TumblrReblog
////    var trail: [TumblrJSONAny]
//    var imagePermalink: String
////    var photos: [TumblrPhoto]
//    var canLike, canReblog, canSendInMessage, canReply: Bool
//    var displayAvatar: Bool
//
    enum CodingKeys: String, CodingKey {
//        case type
//        case blogName = "blog_name"
//        case blog
////        case id
//        case idString = "id_string"
//        case postURL = "post_url"
//        case slug, date, timestamp, state, format
//        case reblogKey = "reblog_key"
////        case tags
//        case shortURL = "short_url"
//        case summary
//        case shouldOpenInLegacy = "should_open_in_legacy"
////        case recommendedSource = "recommended_source"
////        case recommendedColor = "recommended_color"
        case noteCount = "note_count"
//        case caption
////        case reblog, trail
//        case imagePermalink = "image_permalink"
//        case photos
//        case canLike = "can_like"
//        case canReblog = "can_reblog"
//        case canSendInMessage = "can_send_in_message"
//        case canReply = "can_reply"
//        case displayAvatar = "display_avatar"
    }
}


struct TumblrPostBlog: Codable {
    var name, title, blogDescription: String
    var url: String
    var uuid: String
    var updated: Int

    enum CodingKeys: String, CodingKey {
        case name, title
        case blogDescription = "description"
        case url, uuid, updated
    }
}


struct TumblrPhoto: Codable {
    var caption: String
    var originalSize: TumblrAvatar
    var altSizes: [TumblrAvatar]

    enum CodingKeys: String, CodingKey {
        case caption
        case originalSize = "original_size"
        case altSizes = "alt_sizes"
    }
}

struct TumblrReblog: Codable {
    var comment, treeHTML: String

    enum CodingKeys: String, CodingKey {
        case comment
        case treeHTML = "tree_html"
    }
}






// define an instance of the  data that can be filled by the data loader and read by the menu
var tumblrData = TumblrDataStructure()




 public class DataLoaderTumblr {
    
    func loadTumblrData() {

        let headers = [
            "Accept": "application/json"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.tumblr.com/v2/blog/\(AppDelegate().defaults.object(forKey:"TumblrBlogIdentifier") as? String ?? String())/posts?api_key=\(APIKeyTumblr)&limit=1")! as URL,
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
//                print("Received from the Tumblr API")
//                if let data = data,
//                    let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                    print(urlContent)
//                } else {
//                    print("error with printing string encoded data")
//                }
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    let dataFromTumblr = try decoder.decode(TumblrDataStructure.self, from: data!)
                    tumblrData = dataFromTumblr
//                    print(tumblrData.response?.blog.title)
//                    print(tumblrData.response?.blog.posts)
//                    print(tumblrData.response?.posts[0].noteCount)
                }
                catch {
                    print("Error in Tumblr JSON parsing")
//                    print(youTubeData)
                }
            }
        })

        dataTask.resume()
    }
}
