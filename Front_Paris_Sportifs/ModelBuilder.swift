//
//  ModelBuilder.swift
//  Front_Paris_Sportifs
//
//  Created by walid on 22/9/2022.
//

import Foundation
import UIKit
protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailModule(team : Team) -> UIViewController
}
class MainBuilder : Builder {
    static func createDetailModule(team: Team) -> UIViewController {
            let view = DetailViewController()
            let networkService = HomeNetworkServiceImp()
            let presenter = DeatailViewPresenterProtocolImp(view: view, networkService: networkService, team: team)
            view.presenter = presenter
            return view
    }
    
  
    
    static func createMainModule() -> UIViewController {
        let HomeViewController = HomeViewController()
        let networkService = HomeNetworkServiceImp()
        let presenter = HomePresenterImp(view: HomeViewController, homeNtworkService: networkService)
        HomeViewController.homePresenter = presenter
        return HomeViewController
    }
    
    
}
