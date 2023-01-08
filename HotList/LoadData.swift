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



class LoadData{
    var hotList: [Result] = []
    func getUrl(_ mediaType: String, _ feed: String, _ type: String) -> URL?{
        print("getting url")
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/\(mediaType)/\(feed)/10/\(type).json"
        
        let url = URL(string: urlString)
        return url
    }
    
    func loadData(mediaType: String, feed: String, type: String, completion: @escaping () -> Void){
        
        let url = getUrl(mediaType, feed, type)
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
                completion()
//                vc.tableView.reloadData()
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
