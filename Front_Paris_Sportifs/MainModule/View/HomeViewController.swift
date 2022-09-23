//
//  HomeViewController.swift
//  Front_Paris_Sportifs
//
//  Created by walid on 22/9/2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var SearchLeague : UISearchBar!
    
    var searching : Bool = false
    var SearchingLeague = [League]()
    var listTeam = [Team]()
    var serachName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        SearchLeague.delegate = self
        // Do any additional setup after loading the view.
    }
    var homePresenter : HomePresenterProtocol!
    func initCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: HomeCollectionViewCell.nibName)
        self.collectionView.reloadData()
    }
    
    
}

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homePresenter.listTeam?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let mcell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.nibName,
                                                             for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let url = URL(string: homePresenter.listTeam![indexPath.row].strTeamBadge!){
            mcell.imgTeam.load(url: url)
        }
        return mcell
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
     DispatchQueue.main.async {
         self.collectionView.reloadData()
     }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        if searchText.isEmpty {
               searching = false
           
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
           } else {
               searching = true
           
               if let i = homePresenter.listLeague!.firstIndex(where: { $0.strLeagueAlternate?.lowercased() == searchText.lowercased() }) {
                   self.serachName = homePresenter.listLeague![i].strLeague
                   homePresenter.getTeams(searchText: serachName!)
                   DispatchQueue.main.async {
                       self.collectionView.reloadData()
                   }
               }

           }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homePresenter.getDetailTeam(strTeam: (homePresenter.listTeam?[indexPath.row].strTeam)!)
    }
    
    
}
extension HomeViewController : MainHome {
    func detailTeam() {
        let team = homePresenter.ListDetailTeam?[0]
        let detailViewController =  MainBuilder.createDetailModule(team: team!)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    func textchanged() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func searchTeams(name: String) {
        self.serachName = name
    }
    
    func succes() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    func Failure(error: Error) {
        print(error.localizedDescription)
    }
    
    
}
