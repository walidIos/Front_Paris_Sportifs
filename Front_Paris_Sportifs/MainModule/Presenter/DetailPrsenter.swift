//
//  DetailPrsenter.swift
//  Front_Paris_Sportifs
//
//  Created by walid on 23/9/2022.
//

import Foundation
protocol DetailViewProtocol : class {
    func setDetailTeam(team : Team)
}

protocol DeatailViewPresenterProtocol : class {
    init(view: DetailViewProtocol , networkService: HomeNetworkServiceProtocol , team : Team)
    func setDeatilTeam()
}
class DeatailViewPresenterProtocolImp : DeatailViewPresenterProtocol {
    weak var view : DetailViewProtocol?
    let homeNetworkService : HomeNetworkServiceProtocol!
    var team: Team?
    required init(view: DetailViewProtocol, networkService: HomeNetworkServiceProtocol, team: Team) {
        self.homeNetworkService = networkService
        self.view = view
        self.team = team
    }
    public func setDeatilTeam(){
        self.view?.setDetailTeam(team: team!)
    }
    
    
}
