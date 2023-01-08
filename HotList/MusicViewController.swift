//
//  MusicViewController.swift
//  HotList
//
//  Created by NAHØM on 05/01/2023.
//

import UIKit


class MusicViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    var hotList: [Result] = []
    var dataLoader = LoadData()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = UIEdgeInsets(top: 88, left: 0, bottom: 0, right: 0)
        
        let cellNib = UINib(nibName: "HotListCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "HotListCell")
        
        dataLoader.loadData(mediaType: MediaType.Music.rawValue, feed: "most-played", type: Music.Albums.rawValue) {
            self.hotList = self.dataLoader.hotList
            self.tableView.reloadData()
        }
    }
    
    
    
}

extension MusicViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotListCell", for: indexPath) as! HotListTableViewCell

//        cell.nameLabel.text = "Baby"
//        cell.artistNameLabel.text = "JoeBoy"
        cell.nameLabel.text = hotList[indexPath.row].name
        cell.artistNameLabel.text = hotList[indexPath.row].artistName
        
        return cell
    }
}


