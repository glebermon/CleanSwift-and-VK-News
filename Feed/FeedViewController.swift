//
//  FeedViewController.swift
//  CreatingViews
//
//  Created by Глеб on 12.10.2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
        
    private var fetcher : DataFetcher = NetworkDataFetcher(networking: NetworkService())

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
//        fetcher.getFeed { (feedResponse) in
//            guard let feedResponse = feedResponse else { return }
//            feedResponse.items.map { (feedItem) in
//                print(feedItem.date)
//            }
//        }
//
    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
