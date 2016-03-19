//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by The Boss on 2/29/16.
//  Copyright © 2016 The Boss. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "eKOr7ImVu6ggG12CaFM0usMPr", consumerSecret: "FhT39xvqFDg8TCpyIXSzyd68Dhtb8CA3z1CJVwzib5RN46hc5Z")

    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress:  nil, success:  { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            print("THIS IS MY HOME TIME LINE \n\n")
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
        })
    }
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterdemo://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(url!)
            }) {(error: NSError!) -> Void in print("error : \(error.localizedDescription)")
                self.loginFailure?(error)
        }

    }
    
    func handleOpenUrl(url:NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success:{(accessToken:BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({(user:User) -> () in
                    User.currentUser = user
                    self.loginSuccess?()
                
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
            
            }) {(error: NSError!) -> () in
                    print(error.localizedDescription)
                self.loginFailure?(error)
            }

    }
    
    func logout()
    {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName("UserDidLogout", object: nil)
    }
    func currentAccount(success: (User) -> (), failure: (NSError) ->())
    {
        
        GET("1.1/account/verify_credentials.json", parameters: nil, progress:  nil, success:  { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
           
            
            success(user)
           
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
        
                failure(error)
        })

    }
    
}
