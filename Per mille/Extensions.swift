//
//  Extensions.swift
//  RegexMania
//
//  Created by Alex Nagy on 12/02/2019.
//  Copyright © 2019 Alex Nagy. All rights reserved.
//

import Foundation

// more info here https://emailregex.com/regular-expressions-cheat-sheet/ & here:
// https://stackoverflow.com/questions/13476060/validating-youtube-url-using-regex/41988283#41988283
// https://stackoverflow.com/questions/8650007/regular-expression-for-twitter-username
// https://sproutsocial.com/insights/social-media-character-counter/#instagram
// https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjt04_w4-HqAhWUUhUIHY4SDq04ChC3AjAAegQIChAB&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DDiG4GXPvY2Q&usg=AOvVaw0yEan6xYrUXbc7qhbqkbx1

extension String {
    
    enum ValidityType {
        case youTubeChannelID
        case instagramUsername
        case tikTokUsername
        case tumblrBlogIdentifier
        case twitterHandle
//        case age
//        case email
//        case password
//        case website
    }
    
    enum Regex: String {
        case youTubeChannelID = "[-_A-Za-z0-9]{23,23}[AQgw]"
        case instagramUsername = "[a-zA-Z0-9_]{1,30}"
        case tikTokUsername = "[a-zA-Z0-9_]{1,24}"
        case tumblrBlogIdentifier = "[a-z0-9]+(.)[a-z0-9]+(.)[a-z0-9]{2,4}"
        case twitterHandle = "[a-zA-Z0-9_]{1,15}"
//        case age = "[0-9]{2,2}"
//        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        case password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{6,25}"
//        case website = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?" // any site url
//        case website = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.(org|com)(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?" // any site url with .com or .org and subpages
//        case website = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.(org|com)" // any site url with .com or .org and NO subpages
//        case website = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.org" // any site url with only .org and NO subpages
    }
    
    func isValid(_ validityType: ValidityType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType {
        case .youTubeChannelID:
            regex = Regex.youTubeChannelID.rawValue
        case .instagramUsername:
                regex = Regex.instagramUsername.rawValue
        case .tikTokUsername:
                regex = Regex.tikTokUsername.rawValue
        case .tumblrBlogIdentifier:
                regex = Regex.tumblrBlogIdentifier.rawValue
        case .twitterHandle:
                regex = Regex.twitterHandle.rawValue
//        case .age:
//            regex = Regex.age.rawValue
//        case .email:
//            regex = Regex.email.rawValue
//        case .password:
//            regex = Regex.password.rawValue
//        case .website:
//            regex = Regex.website.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
    
}
