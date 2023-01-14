//
//  LoadData.swift
//  HotList
//
//  Created by NAHØM on 09/01/2023.
//

import UIKit

enum MediaType: String{
    case Music = "music"
    case Podcasts = "podcasts"
    case Apps = "apps"
    case Books = "books"
    case Audiobooks = "audio-books"
}


enum Music: String{
    case Albums = "albums"
    case MusicVideos = "music-videos"
    case Playlists = "playlists"
    case Songs = "songs"
}
enum Podcasts: String{
    case Podcasts = "podcasts"
    case PodcastEpisodes = "podcast-episodes"
    case PodcastChannels = "podcast-channels"
}



class LoadData: UIViewController{
    var hotList: [Result] = []
    var isLoading = true
    var loadSuccess = false
    var dataTask: URLSessionDataTask?
    
    func getUrl(_ mediaType: String, _ feed: String, _ type: String) -> URL?{
        print("getting url")
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/\(mediaType)/\(feed)/10/\(type).json"
        
        let url = URL(string: urlString)
        return url
    }
    
    func loadData(on vc: UIViewController, mediaType: String, feed: String, type: String, completion: @escaping () -> Void){
        
        let url = getUrl(mediaType, feed, type)
        print("loading data")
        let session = URLSession.shared
        dataTask = session.dataTask(with: url!) { data, response, error in
            print("inside session")
            if let error = error{
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.showErrorAlert(error, on: vc)
                }
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode != 200{
                print("Status Code - \(response.statusCode)")
                return
            }
            else{
                DispatchQueue.main.async {
                    print("outside session")
                    self.hotList = self.parse(data: data!)
                    self.loadSuccess = true
                    completion()
                }
            }
        }
        dataTask?.resume()
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
    
    func showErrorAlert(_ error: Error, on vc: UIViewController){
        let alert = UIAlertController(title: "Error", message: "Connect to the Internet", preferredStyle: .alert)
        alert.message = error.localizedDescription
        let action1 = UIAlertAction(title: "Try Again", style: .default)
        alert.addAction(action1)
        
        let action2 = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(action2)
        vc.present(alert, animated: true)
    }
}
