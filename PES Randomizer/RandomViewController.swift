//
//  RandomViewController.swift
//  PES Randomizer
//
//  Created by Quang Dinh Le on 10/15/19.
//  Copyright © 2019 Quang Dinh Le. All rights reserved.
//

import UIKit

class RandomViewController: UIViewController {
  var teams: [PesTeam]?
  var allTeams: [PesTeam]?
  
  @IBOutlet weak var logoContainer: UIView!
  @IBOutlet weak var logo: UIImageView!
  @IBOutlet weak var logoAlt: UIImageView!
  
  @IBOutlet weak var logoTeamAContainer: UIView!
  @IBOutlet weak var logoTeamA: UIImageView!
  
  @IBOutlet weak var logoTeamBContainer: UIView!
  @IBOutlet weak var logoTeamB: UIImageView!
  
  var timer:Timer? = nil
  var times:Int = 0;
  var showingAlt = false
  
  var teamA: PesTeam?
  var teamB: PesTeam?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    allTeams = teams
    logo.alpha = 0.0
    logoAlt.alpha = 0.0
    logoContainer.layer.cornerRadius = 150.0
    logoTeamAContainer.layer.cornerRadius = 64.0
    logoTeamBContainer.layer.cornerRadius = 64.0
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.random(sender: nil)
  }
  
  @IBAction func close(sender: UIButton!) {
    self.dismiss(animated: true) {
      
    }
  }
  
  @IBAction func random(sender: UIButton!) {
    if self.teamB == nil && self.teamA != nil {
      teams = allTeams?.filter ( {$0.image != self.teamA!.image} )
    } else {
      teams = allTeams
      self.teamA = nil
      self.teamB = nil
      self.logoTeamA.image = nil
      self.logoTeamB.image = nil
    }
    
    restartTime(interval: 0.05)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
      self.restartTime(interval: 0.1)
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
        self.restartTime(interval: 0.2)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
          self.restartTime(interval: 0.6)
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            self.timer?.invalidate()
            self.timer = nil
            let team = self.pickRandomTeam()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(250)) {
              self.animateLogo(team: team)
              if let imageName = team?.image {
                let image = UIImage.init(named: imageName)
                if self.teamA == nil {
                  self.teamA = team
                  self.logoTeamA.image = image
                } else if self.teamB == nil {
                  self.teamB = team
                  self.logoTeamB.image = image
                }
              }
            }
          }
        }
      }
    }
  }
  
  func animateLogo(team: PesTeam?) {
    if let imageName = team?.image {
      let image = UIImage.init(named: imageName)
      UIView.animate(withDuration: 0.1) {
        if self.showingAlt {
          self.logoAlt.alpha = 1.0
          self.logoAlt.image = image
          self.logo.alpha = 0.0
        } else {
          self.logoAlt.alpha = 0.0
          self.logo.image = image
          self.logo.alpha = 1.0
        }
      }
      self.showingAlt = !self.showingAlt
    }
  }
  
  func pickRandomTeam() -> PesTeam? {
    let team = self.teams?.randomElement()
    return team
  }
  
  func restartTime(interval: TimeInterval) {
    self.timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval:interval, repeats: true, block: { (_) in
      let team = self.pickRandomTeam()
      self.animateLogo(team: team)
    })
  }
}
