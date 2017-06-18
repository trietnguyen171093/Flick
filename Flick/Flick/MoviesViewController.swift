//
//  MoviesViewController.swift
//  Flick
//
//  Created by Triet on 6/17/17.
//  Copyright © 2017 Triet. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
    var selectedUrl = ""
    var selectedOverview = ""
  
    var movies = [NSDictionary]()
    let refreshControl = UIRefreshControl()
    var  errView: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      tableView.delegate = self
      tableView.dataSource = self
      
      networkFetch();
      // Adding Pulling refresh
      
      refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
      refreshControl.addTarget(self, action: #selector(MoviesViewController.fetchList), for: UIControlEvents.valueChanged)
      tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
      func fetchList() {
      // Code to refresh table view
      refreshControl.beginRefreshing()
      networkFetch()
      refreshControl.endRefreshing()
    }
    func networkFetch()
    {
      if isInternetAvailable(){
        // Hide the UIView if network is connected
        errView?.isHidden = true
        
        // Display HUD right before the request is made
        let spinAnimation = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinAnimation.labelText = "Loading"
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "http://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = URLRequest(
          url: url!,
          cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
          timeoutInterval: 100)
        let session = URLSession(
          configuration: URLSessionConfiguration.default,
          delegate: nil,
          delegateQueue: OperationQueue.main
        )
        let task: URLSessionDataTask =
          session.dataTask(with: request,
                           completionHandler: { (dataOrNil, response, error) in
                            if let data = dataOrNil {
                              if let responseDictionary = try! JSONSerialization.jsonObject(
                                with: data, options:[]) as? NSDictionary {
                                // Stop show animation
                                MBProgressHUD.hide(for: self.view, animated: true)
                                self.movies = responseDictionary["results"] as! [NSDictionary]
                                print("response: \(self.movies)")
                                self.tableView.reloadData()
                              }
                            }
          })
        task.resume()
      }
      else{
        // debug print
        print("Network error")
        let errorViewFrame : CGRect = CGRect(x: 0, y: 500, width: 360, height: 40)
        errView = UIView(frame: errorViewFrame)
        errView?.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        
        let errLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (errView?.frame.width)!, height: (errView?.frame.height)!))
        errLabel.textColor = UIColor.white
        errLabel.textAlignment = .center
        errLabel.text = "Network Error!"
        errLabel.isHighlighted = true
        errView?.addSubview(errLabel)
        
        self.view.addSubview(errView!)
        errView?.isHidden = false
      }
      
    }
  
  // This func check network avaiable or not
    func isInternetAvailable() -> Bool
    {
      var zeroAddress = sockaddr_in()
      zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
      zeroAddress.sin_family = sa_family_t(AF_INET)
      
      let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
          SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
      }
      
      var flags = SCNetworkReachabilityFlags()
      if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
      }
      let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
      let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
      return (isReachable && !needsConnection)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
      return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//      let cell = UITableViewCell()
//      
//      cell.textLabel?.text = movies[indexPath.row]["title"] as? String
        
      let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieCell
      
      
      cell.titleLabel.text = movies[indexPath.row]["title"] as? String
      cell.overviewLabel.text = movies[indexPath.row]["overview"] as? String
      
      let imgUrl = posterBaseUrl + (movies[indexPath.row]["poster_path"] as! String)
      cell.posterImage.setImageWith(NSURL(string: imgUrl) as! URL)
      

      return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      
        let nextVC = segue.destination as! DetailViewController
        let ip = tableView.indexPathForSelectedRow
        
        nextVC.imgUrl = posterBaseUrl + (movies[(ip?.row)!]["poster_path"] as! String)

        nextVC.overText = (movies[(ip?.row)!]["overview"] as? String)!
        nextVC.titleText = (movies[(ip?.row)!]["title"] as? String)!
    }
  

}
