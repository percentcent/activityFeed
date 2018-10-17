//
//  UpdateActivityFeed.swift
//  activityFeed
//
//  Created by peishan lee on 17/10/18.
//  Copyright © 2018 The University of Melbourne. All rights reserved.
//

import UIKit
import Alamofire

class UpdateActivityFeed{
    //MARK : properties
    var ActivityFeedsList = [ActivityFeed]()
    var ActivityFeedsJson : [[String: Any]] = [[String: Any]]()
    
    func getActivityFeed(YouOrFollowing : Bool){
        var urlString : String = "http://localhost:3004/activity"
        let postParameters = [
            "myUserName" : "abcd"
        ]
        
        if YouOrFollowing{
            urlString += "You"
        }
        else{
            urlString += "Following"
        }
        
        Alamofire.request(urlString, method: .post, parameters: postParameters as Parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseActivities = responseValue["data"] as! [[String: Any]]? {
                    self.ActivityFeedsJson = responseActivities
                    self.loadSuggestedFromJSON(JSON: self.ActivityFeedsJson)
                    //print(self.ActivityFeedsList[0].detail)
                    print(self.ActivityFeedsJson)
                }
            }
        }
        
    }
    
    //MARK : private func
    func loadSuggestedFromJSON(JSON : [[String: Any]]){
        ActivityFeedsList = []
        if JSON.count > 0{
            let maxCount : Int = JSON.count - 1
            for i in 0...maxCount{
                let activity_info = JSON[i]
                
                guard let activity_i = ActivityFeed(userImageUrl: (activity_info["userImageUrl"] as? String) ?? "", likeOrStartFollwing: (activity_info["likeOrStartFollwing"] as? Bool)!, userName: (activity_info["userName"] as? String) ?? "", nextUserName: (activity_info["nextUserName"] as? String) ?? "", postImageUrl: (activity_info["postImageUrl"] as? String) ?? "",activityTime: (activity_info["activityTime"] as? String) ?? "", youOrFollowing: (activity_info["youOrFollowing"] as? Bool)!) else {
                    fatalError("Unable to instantiate activityFeed")
                }
                
                activity_i.generateDetail()
                
                 self.ActivityFeedsList += [activity_i]
            }
        }
    }

}

