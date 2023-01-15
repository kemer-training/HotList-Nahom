//
//  AppsViewController.swift
//  HotList
//
//  Created by NAHØM on 05/01/2023.
//

import UIKit

class AppsViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    var hotList: [Result] = []
    var dataLoader = LoadData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        
        let cellNib = UINib(nibName: "HotListCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "HotListCell")
        
        let loadingCellNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(loadingCellNib, forCellReuseIdentifier: "LoadingCell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !hotList.isEmpty { return }
        
        dataLoader.loadData(on: self, mediaType: MediaType.Apps.rawValue, feed: "top-free") {
            self.dataLoader.isLoading = false
            self.hotList = self.dataLoader.hotList
            self.tableView.reloadData()
        }
    }
    
}

extension AppsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataLoader.isLoading ? 1 : hotList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var spinner: UIActivityIndicatorView?
        if dataLoader.isLoading{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell")
            spinner = cell?.viewWithTag(200) as? UIActivityIndicatorView
            spinner?.startAnimating()
            return cell!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotListCell", for: indexPath) as! HotListTableViewCell
        
        cell.nameLabel.text = hotList[indexPath.row].name
        cell.artistNameLabel.text = hotList[indexPath.row].artistName
        cell.artworkImageView.loadImage(url: hotList[indexPath.row].artworkUrl100!)
        return cell
    }
}
