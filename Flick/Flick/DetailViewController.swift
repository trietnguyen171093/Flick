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
    var imgUrl = ""
    var overview = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      posterImage.setImageWith(URL(string: imgUrl)!)
      overviewLabel.text = overview
      
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
