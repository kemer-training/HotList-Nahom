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
        
        let hotListCellNib = UINib(nibName: "HotListCell", bundle: nil)
        tableView.register(hotListCellNib, forCellReuseIdentifier: "HotListCell")
        
        let loadingCellNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(loadingCellNib, forCellReuseIdentifier: "LoadingCell")
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if hotList.isEmpty{
            refreshPage(withFeedsOfType: Music.Albums.rawValue)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dataLoader.dataTask?.cancel()
    }
    
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        var type = ""
        switch sender.selectedSegmentIndex{
            case 0: type = Music.Albums.rawValue
            case 1: type = Music.MusicVideos.rawValue
            case 2: type = Music.Playlists.rawValue
            case 3: type = Music.Songs.rawValue
            default: break
        }
        refreshPage(withFeedsOfType: type)
    }
    
    func refreshPage(withFeedsOfType type: String){
        dataLoader.isLoading = true
        tableView.reloadData()
        
        dataLoader.loadData(on: self, mediaType: MediaType.Music.rawValue, feed: "most-played", type: type) {
            self.dataLoader.isLoading = false
            self.hotList = self.dataLoader.hotList
            self.tableView.reloadData()
        }
    }
}

extension MusicViewController: UITableViewDelegate, UITableViewDataSource{
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}


