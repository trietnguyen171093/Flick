//
//  DetailViewController.swift
//  Flick
//
//  Created by Triet on 6/17/17.
//  Copyright © 2017 Triet. All rights reserved.
//

import UIKit
import AFNetworking

class DetailViewController: UIViewController {

  @IBOutlet weak var posterImage: UIImageView!
  @IBOutlet weak var overviewLabel: UILabel!
  @IBOutlet weak var titleView: UILabel!
  @IBOutlet weak var extendScrollView: UIScrollView!
    var imgUrl = ""
    var overText = ""
    var titleText = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     
      
      posterImage.setImageWith(URL(string: imgUrl)!)
      overviewLabel.text = overText
      overviewLabel.backgroundColor = UIColor(red : 0.2, green: 0.2, blue: 0.2, alpha: 0.8)
      overviewLabel.sizeToFit()
      
      titleView.text = titleText
      titleView.backgroundColor = UIColor(red : 0.2, green: 0.2, blue: 0.2, alpha: 0.8)
      titleView.textColor = UIColor(red : 1, green: 0, blue: 0, alpha: 1)
      
      let bounceWidth = extendScrollView.bounds.width
      let bounceHeight = extendScrollView.bounds.height + 50
      extendScrollView.contentSize = CGSize(width: bounceWidth, height: bounceHeight)
      //      extendScrollView.backgroundColor = UIColor(red : 0.2, green: 0.2, blue: 0.2, alpha: 0.8)
      extendScrollView.sizeToFit()

      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
