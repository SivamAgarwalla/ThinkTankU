//
//  SentimentAnalysisViewController.swift
//  ThinkTankU
//
//  Created by Sivam Agarwalla on 11/27/20.
//  Copyright © 2020 Sivam Agarwalla. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class SentimentAnalysisViewController: UIViewController {
    
    // Move keys to PLIST file
    let swifter = Swifter(consumerKey: "CCJd9Ax6dQzRdVni4whVwS2Gk", consumerSecret: "IeHwd3mK6oWGxfQQW2uwQRFViOW2sXHauCnyQ1pCUzAO2AzP7a")
    let sentimentClassifier = TweetSentimentClassifier()
    @IBOutlet weak var handleTextField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 50, tweetMode: .extended,  success: { (tweetResults, searchMetadata) in
            
            if let tweet = tweetResults[0]["full_text"].string {
                print(tweet)
            }
            
        }) { (error) in
            print("There was an error with the Twitter API, \(error)")
        }
    }
    

    @IBAction func onAnalyze(_ sender: UIButton) {
        swifter.searchTweet(using: "@Apple", lang: "en", count: 1000, tweetMode: .extended,  success: { (tweetResults, searchMetadata) in
            
            if let tweet = tweetResults[0]["full_text"].string {
                print(tweet)
            }
            
        }) { (error) in
            print("There was an error with the Twitter API, \(error)")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
