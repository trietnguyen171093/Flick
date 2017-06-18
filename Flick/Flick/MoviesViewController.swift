//
//  MoviesViewController.swift
//  Flick
//
//  Created by Triet on 6/17/17.
//  Copyright © 2017 Triet. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
    var selectedUrl = ""
    var selectedOverview = ""
  
    var movies = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      tableView.delegate = self
      tableView.dataSource = self
      
      networkFetch();
    }

  
    func networkFetch()
    {
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
                              
                              self.movies = responseDictionary["results"] as! [NSDictionary]
                              print("response: \(self.movies)")
                              self.tableView.reloadData()
                            }
                          }
        })
      task.resume()
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

        nextVC.overview = (movies[(ip?.row)!]["overview"] as? String)!
    }
  

}
