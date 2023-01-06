//
//  PodcastViewController.swift
//  HotList
//
//  Created by NAHØM on 05/01/2023.
//

import UIKit

class PodcastsViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = UIEdgeInsets(top: 88, left: 0, bottom: 0, right: 0)
    }
    
}

extension PodcastsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath)
        cell.textLabel?.text = "Podcast \(indexPath.row+1)"
        return cell
    }
}
