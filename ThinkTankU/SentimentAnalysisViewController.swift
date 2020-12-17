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
    }
    

    @IBAction func onAnalyze(_ sender: UIButton) {
        var tweetsFullText = [TweetSentimentClassifierInput]()
        
        let predictionText = self.handleTextField.text!
        swifter.searchTweet(using: predictionText, lang: "en", count: 100, tweetMode: .extended,  success: { (tweetResults, searchMetadata) in
            for c in 0..<100 {
                if tweetResults[c]["retweet_count"].integer ?? 0 > 0 {
                    if let tweet = tweetResults[c]["retweeted_status"]["full_text"].string {
                        let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                        tweetsFullText.append(tweetForClassification)
                    }
                } else {
                     if let tweet = tweetResults[c]["full_text"].string {
                        let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                        tweetsFullText.append(tweetForClassification)
                    }
                }
            }
    
            do {
                let tweetPredictions = try self.sentimentClassifier.predictions(inputs: tweetsFullText)
                
                var sentimentScore = 0
                
                for c in 0..<tweetsFullText.count {
                    print(tweetPredictions[c].label + "\n\n")
                    
                    if tweetPredictions[c].label == "Positive" {
                        sentimentScore += 1
                    }
                    if tweetPredictions[c].label == "Negative" {
                        sentimentScore -= 1
                    }
                }
                
                if sentimentScore > 10 {
                    self.sentimentLabel.text = "Positive"
                } else if sentimentScore < -10 {
                    self.sentimentLabel.text = "Negative"
                } else {
                    self.sentimentLabel.text = "Neutral"
                }
                
            } catch {
                print("There was an error with the sentiment analysis.")
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
