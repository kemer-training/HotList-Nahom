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
    var dataTask: URLSessionDataTask?
    
    func getUrl(_ mediaType: String, _ feed: String, _ type: String) -> URL?{
        
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/\(mediaType)/\(feed)/10/\(type).json"
        
        let url = URL(string: urlString)
        return url
    }
    
    func loadData(on currentViewController: UIViewController, mediaType: String, feed: String, type: String? = nil, completion: @escaping () -> Void){
        var type = type ?? mediaType
        
        let url = getUrl(mediaType, feed, type)
        let session = URLSession.shared
        
        dataTask = session.dataTask(with: url!) { data, response, error in
            if let error = error{
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.showErrorAlert(error, on: currentViewController)
                }
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode != 200{
                return
            }
            else{
                DispatchQueue.main.async {
                    self.hotList = self.parse(data: data!)
                    completion()
                }
            }
        }
        dataTask?.resume()
    }
    func parse(data: Data) -> [Result]{
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
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Try Again", style: .default)
        alert.addAction(action1)
        
        let action2 = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(action2)
        
        vc.present(alert, animated: true)
    }
}
