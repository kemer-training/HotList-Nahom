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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = UIEdgeInsets(top: 88, left: 0, bottom: 0, right: 0)
        
        let cellNib = UINib(nibName: "HotListCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "HotListCell")
        
        loadData()
    }
    
    func getUrl() -> URL?{
        print("getting url")
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/10/albums.json"
        
        let url = URL(string: urlString)
        return url
    }
    
    func loadData() {
        let url = getUrl()
        print("loading data")
        let session = URLSession.shared
        let datatask = session.dataTask(with: url!) { data, response, error in
            print("inside session")
            if let error = error{
                print("error")
                print(error.localizedDescription)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else { return }
            print("status code 200")
            DispatchQueue.main.async {
                print("outside session")
                self.hotList = self.parse(data: data)
                self.tableView.reloadData()
            }
            
        }
        datatask.resume()
    }
    func parse(data: Data) -> [Result]{
        print("parsing data")
        do{
            let decoder = JSONDecoder()
            let list = try decoder.decode(Welcome.self, from: data)
            return list.feed.results
        } catch {
            print("JSON Error -> \(error)")
            
            return []
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


