//
//  ActivityViewController.swift
//  activityFeed
//
//  Created by peishan lee on 17/10/18.
//  Copyright © 2018 The University of Melbourne. All rights reserved.
//


import UIKit
import Kingfisher
import Alamofire
import AlamofireImage

class ActivityViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    //MARK properties
    @IBOutlet weak var activityFeedTableView: UITableView!
    
    @IBOutlet weak var youButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    //var ActivityFeeds = UpdateActivityFeed()
    var ActivityFeeds = [ActivityFeed]()
    var followOrYouStatus : Bool = true
    var FeedsJson : [[String: Any]] = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityFeedTableView.delegate = self
        activityFeedTableView.dataSource = self
        //load sample data
        //loadSampleData()
        followOrYouStatus = true
        updateButtonStyle()
        
        let urlString : String = "http://localhost:3004/activityFollowing"
        let postParameters = [
            "myUserName" : "abcd"
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters: postParameters as Parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseActivities = responseValue["data"] as! [[String: Any]]? {
                    self.FeedsJson = responseActivities
                    self.loadFeedsFromJSON(JSON: self.FeedsJson)
                    self.activityFeedTableView?.reloadData()
                }
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.ActivityFeeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ActivityFeedTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ActivityFeedTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of ActivityFeedTableViewCell.")
        }
        
        let feed = ActivityFeeds[indexPath.row]
        cell.activityFeedDetail.text = feed.detail
        
        let userUrl = URL(string: feed.userImageUrl!)
        let processor = RoundCornerImageProcessor(cornerRadius: 40)
        cell.userImage.kf.setImage(with: userUrl, options: [.processor(processor)])
        //cell.userImage.kf.setImage(with: userUrl)
        
        
        if feed.likeOrStartFollwing{
            cell.postImage.isHidden = false
            let postUrl = URL(string: feed.postImageUrl!)
            cell.postImage.kf.setImage(with: postUrl)
        }
        else{
            cell.postImage.isHidden = true
        }
        //print(feed.detail)
        return cell
    }
    
    //MARK : button func
    
    
    @IBAction func followingUpdate(_ sender: UIButton) {
        
        followOrYouStatus = true
        updateButtonStyle()
        let urlString : String = "http://localhost:3004/activityFollowing"
        let postParameters = [
            "myUserName" : "abcd"
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters: postParameters as Parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseActivities = responseValue["data"] as! [[String: Any]]? {
                    self.FeedsJson = responseActivities
                    self.loadFeedsFromJSON(JSON: self.FeedsJson)
                    self.activityFeedTableView?.reloadData()
                }
            }
        }
    }
    
    @IBAction func youUpdate(_ sender: UIButton) {
        
        
        followOrYouStatus = false
        updateButtonStyle()
        let urlString : String = "http://localhost:3004/activityYou"
        let postParameters = [
            "myUserName" : "abcd"
        ]
        
        
        Alamofire.request(urlString, method: .post, parameters: postParameters as Parameters,encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseActivities = responseValue["data"] as! [[String: Any]]? {
                    self.FeedsJson = responseActivities
                    self.loadFeedsFromJSON(JSON: self.FeedsJson)
                    self.activityFeedTableView?.reloadData()
                }
            }
        }
    }
    
    
    //MARK : private func
    private func loadFeedsFromJSON(JSON : [[String: Any]]){
        ActivityFeeds = []
        if JSON.count > 0{
            let maxCount : Int = JSON.count - 1
            for i in 0...maxCount{
                let activity_info = JSON[i]
                
                guard let activity_i = ActivityFeed(userImageUrl: (activity_info["userImageUrl"] as? String) ?? "", likeOrStartFollwing: (activity_info["likeOrStartFollwing"] as? Bool)!, userName: (activity_info["userName"] as? String) ?? "", nextUserName: (activity_info["nextUserName"] as? String) ?? "", postImageUrl: (activity_info["postImageUrl"] as? String) ?? "",activityTime: (activity_info["activityTime"] as? String) ?? "", youOrFollowing: (activity_info["youOrFollowing"] as? Bool)!) else {
                    fatalError("Unable to instantiate activityFeed")
                }
                
                activity_i.generateDetail()
                
                self.ActivityFeeds += [activity_i]
            }
        }
    }
    
    private func updateButtonStyle(){
        if followOrYouStatus{
            highlightButton(Button: self.followingButton)
            initializeButton(Button: self.youButton)
        }
        else{
            highlightButton(Button: self.youButton)
            initializeButton(Button: self.followingButton)
        }
    }
    private func highlightButton(Button : UIButton){
        Button.backgroundColor = UIColor.gray
        Button.setTitleColor(UIColor.black, for: .normal)
        //need to transition to initial state when suggested users show again?
    }
    
    private func initializeButton(Button : UIButton){
        Button.backgroundColor = UIColor.white
        Button.setTitleColor(UIColor.darkGray, for: .normal)
        
    }
    
    private func loadSampleData()
    {
        ActivityFeeds = []
        guard let feed1 = ActivityFeed(userImageUrl: "https://httpbin.org/image/png", likeOrStartFollwing: true, userName: "test", nextUserName: "test2", postImageUrl: "https://httpbin.org/image/png", activityTime: "1 day", youOrFollowing: false) else {
            fatalError("Unable to instantiate feed1")
        }
        feed1.generateDetail()
        
        ActivityFeeds += [feed1]
        
    }
    
    
}

