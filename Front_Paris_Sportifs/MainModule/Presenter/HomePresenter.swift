//
//  HomePresenter.swift
//  Front_Paris_Sportifs
//
//  Created by walid on 22/9/2022.
//

import Foundation
protocol MainHome : class {
    func succes()
    func Failure(error : Error)
    func textchanged()
    func detailTeam()
}
protocol HomePresenterProtocol {
    init(view : MainHome , homeNtworkService : HomeNetworkServiceProtocol)
    var listLeague : [League]? { get set }
    var listTeam: [Team]? { get set }
    var ListDetailTeam: [Team]? { get set }
    func getLeague()
    func getTeams(searchText: String)
    func getDetailTeam(strTeam : String)
}
class HomePresenterImp : HomePresenterProtocol {
    var ListDetailTeam: [Team]?
    var listLeague: [League]?
    var listTeam: [Team]?
    var timesTapped = 0
    weak var view : MainHome?
    let homeNetworkService : HomeNetworkServiceProtocol!
    required init(view: MainHome, homeNtworkService: HomeNetworkServiceProtocol) {
        self.view = view
        self.homeNetworkService = homeNtworkService
        getLeague()
        
    }
    func getLeague() {
        homeNetworkService.getLeague { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let league):
                self.listLeague = league
                //self.view?.succes()
            case .failure(let error):
                self.view?.Failure(error: error)
            }
        }
    }
    func getTeams(searchText : String){
        homeNetworkService.getTeamsOfLeague(searchText) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let team):
                self.listTeam = team
                self.view?.textchanged()
            case .failure(let error):
                self.view?.Failure(error: error)
            }
        }
    }
    func getDetailTeam(strTeam : String){
        homeNetworkService.getDetailTeam(strTeam) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let team):
                self.ListDetailTeam = team
                self.view?.detailTeam()
            case .failure(let error):
                self.view?.Failure(error: error)
            }
        }
    }
}
