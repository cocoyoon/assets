//
//  user.swift
//  gotcha
//
//  Created by SoYoun Jeong on 2022/10/23.
//

import Foundation

/*
 
User model
 - nick: Nickname for GOTCHA
 - profilePic: Profile pictur URL
 - Favorites: Favorite brand, tags...
 */

struct User {
    
    var nick: String?
    var profilePicURL: String?
    var favorites: [String]
    
    func setData(nick: String?, profilePicURL: String?, favorites: [String]) -> [String: Any] {
        
        var dict: [String: Any] = [String: Any]()
        
        if let nick = nick {
            dict.updateValue(nick, forKey: "nick")
        } else {
            dict.updateValue("", forKey: "nick")
        }
        
        if let profilePicURL = profilePicURL {
            dict.updateValue(profilePicURL, forKey: "profilePicURL")
        } else {
            dict.updateValue("", forKey: "profilePicURL")
        }
        
        if favorites.isEmpty {
            dict.updateValue([""], forKey: "favorites")
        } else {
            dict.updateValue(favorites, forKey: "favorites")
        }
        
        return dict
    }
}
