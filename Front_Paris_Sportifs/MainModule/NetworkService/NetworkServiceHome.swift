//
//  NetworkServiceHome.swift
//  Front_Paris_Sportifs
//
//  Created by walid on 22/9/2022.
//

import Foundation

protocol HomeNetworkServiceProtocol  {
    func getLeague(completion : @escaping (Result<[League]? ,Error>)-> Void)
    func getTeamsOfLeague(_ name : String ,completion: @escaping (Result<[Team]?, Error>) -> Void)
    func getDetailTeam(_ strTeam : String ,completion: @escaping (Result<[Team]?, Error>) -> Void)
}
class HomeNetworkServiceImp : HomeNetworkServiceProtocol {
    func getLeague(completion: @escaping (Result<[League]?, Error>) -> Void) {
        let urlString = "https://www.thesportsdb.com/api/v1/json/2/all_leagues.php"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    if let jsonString = json["leagues"] as? [[String : Any]] {
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonString, options: [])
                        let obj = try JSONDecoder().decode([League].self, from: jsonData)
                        completion(.success(obj))
                       }
                   }
                
                
            }catch {
                completion(.failure(error))
            }
            
            
        }.resume()
    }
    
    func getTeamsOfLeague(_ name : String ,completion: @escaping (Result<[Team]?, Error>) -> Void){
        let originalString = "https://www.thesportsdb.com/api/v1/json/50130162/search_all_teams.php?l="+name
        var urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: urlString!) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    if let jsonString = json["teams"] as? [[String : Any]] {
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonString, options: [])
                        let obj = try JSONDecoder().decode([Team].self, from: jsonData)
                        completion(.success(obj))
                       }
                   }
                
            }catch {
                completion(.failure(error))
            }
            
            
        }.resume()
    }
    
    func getDetailTeam(_ strTeam : String ,completion: @escaping (Result<[Team]?, Error>) -> Void){
        let originalString = "https://www.thesportsdb.com/api/v1/json/50130162/searchteams.php?t="+strTeam
        var urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: originalString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    if let jsonString = json["teams"] as? [[String : Any]] {
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonString, options: [])
                        let obj = try JSONDecoder().decode([Team].self, from: jsonData)
                        completion(.success(obj))
                       }
                   }
                
            }catch {
                completion(.failure(error))
            }
            
            
        }.resume()
    }
}
