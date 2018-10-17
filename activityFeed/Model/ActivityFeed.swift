//
//  ActivityFeed.swift
//  activityFeed
//
//  Created by peishan lee on 17/10/18.
//  Copyright © 2018 The University of Melbourne. All rights reserved.
//

import UIKit

class ActivityFeed{
    
    //MARK: Properties
    var userImageUrl : String?
    var likeOrStartFollwing : Bool
    var userName : String
    var nextUserName : String
    var postImageUrl : String?
    var activityTime : String
    var detail : String = ""
    var youOrFollowing : Bool
    
    init?(userImageUrl : String, likeOrStartFollwing : Bool, userName : String, nextUserName : String, postImageUrl : String?, activityTime : String, youOrFollowing : Bool) {
        
        // The name must not be empty, name refers to unique username
        guard !userName.isEmpty else {
            return nil
        }
        // The nextUserName must not be empty, intro refers to customised name
        guard !nextUserName.isEmpty else {
            return nil
        }
        //activityTime
        guard !activityTime.isEmpty else {
            return nil
        }
        //likeOrStartFollwing
        
        //initialize
        self.activityTime = activityTime
        self.userImageUrl = userImageUrl
        self.likeOrStartFollwing = likeOrStartFollwing
        self.userName = userName
        self.nextUserName = nextUserName
        self.postImageUrl = postImageUrl
        self.youOrFollowing = youOrFollowing
        
    }
    
    func generateDetail(){
        if youOrFollowing{
            if likeOrStartFollwing {
                self.detail = userName + " liked your post. " + activityTime
            }
            else{
                self.detail = userName + " started following you. " + activityTime
            }
        }
        else{
            if likeOrStartFollwing {
                self.detail = userName + " liked " + nextUserName + "'s post. " + activityTime
            }
            else{
                self.detail = userName + " started following " + nextUserName + ". " + activityTime
            }
        }
    }
}
