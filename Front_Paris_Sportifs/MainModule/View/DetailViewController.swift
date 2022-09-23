//
//  DetailViewController.swift
//  Front_Paris_Sportifs
//
//  Created by walid on 23/9/2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imgTeam: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var presenter : DeatailViewPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setDeatilTeam()
        // Do any additional setup after loading the view.
    }

}
extension DetailViewController : DetailViewProtocol {
    func setDetailTeam(team: Team) {
        if let url = URL(string: team.strTeamBanner ?? ""){
          imgTeam.load(url: url)
        }
        self.countryLabel.text = team.strCountry
        self.leagueLabel.text = team.strLeague
        self.descriptionLabel.text = team.strDescriptionFR
    }
    
    
}
