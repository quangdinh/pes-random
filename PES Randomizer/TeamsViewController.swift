//
//  ViewController.swift
//  PES Randomizer
//
//  Created by Quang Dinh Le on 10/15/19.
//  Copyright © 2019 Quang Dinh Le. All rights reserved.
//

import UIKit

struct PesTeam {
  let image: String
  let name: String
  var selected = true
  let attack: Int
  let midfield: Int
  let defense: Int
  init(image: String, name: String, attack: Int, midfield: Int, defense: Int) {
    self.attack = attack
    self.midfield = midfield
    self.defense = defense
    self.image = image
    self.name = name
    self.selected = true
  }
}

class TeamsViewController: UITableViewController {
  var teams = [
    PesTeam(image: "arsenal", name: "Arsenal", attack: 85, midfield: 83, defense: 83),
    PesTeam(image: "atletico-de-madrid", name: "Atletico De Madrid", attack: 88, midfield: 80, defense: 86),
    PesTeam(image: "barcelona", name: "Barcelona", attack: 93, midfield: 86, defense: 87),
    PesTeam(image: "bayern-munchen", name: "Bayern Munchen", attack: 88, midfield: 85, defense: 86),
    PesTeam(image: "juventus", name: "Juventus", attack: 92, midfield: 84, defense: 85),
    PesTeam(image: "liverpool", name: "Liverpool", attack: 89, midfield: 83, defense: 87),
    PesTeam(image: "manchester-city", name: "Manchester City", attack: 90, midfield: 86, defense: 85),
    PesTeam(image: "manchester-united", name: "Manchester United", attack: 83, midfield: 85, defense: 83),
    PesTeam(image: "psg", name: "PSG", attack: 91, midfield: 82, defense: 83),
    PesTeam(image: "napoli", name: "Napoli", attack: 84, midfield: 76, defense: 82),
    PesTeam(image: "chelsea", name: "Chelsea", attack: 88, midfield: 83, defense: 82),
    PesTeam(image: "tottenham-hotspur", name: "Tottenham Hotspur", attack: 88, midfield: 84, defense: 83),
    PesTeam(image: "internazionale", name: "Inter Milan", attack: 83, midfield: 81, defense: 83),
    PesTeam(image: "dvb", name: "Dortmund", attack: 81, midfield: 84, defense: 82),
    PesTeam(image: "real-madrid", name: "Real Madrid", attack: 86, midfield: 86, defense: 86)
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    teams = teams.sorted(by: { $0.name < $1.name })
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return teams.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "pesTeam", for: indexPath) as! TeamTableViewCell

    cell.team = teams[indexPath.row]
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var team = teams[indexPath.row]
    team.selected = !team.selected
    teams[indexPath.row] = team
    tableView.reloadRows(at: [indexPath], with: .fade)
  }
  
  @IBAction func random(sender: UIBarButtonItem) {
    self.performSegue(withIdentifier: "showRandomizer", sender: sender)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showRandomizer" {
      if let vc = segue.destination as? RandomViewController {
        vc.teams = teams.filter ( {$0.selected == true} )
      }
    }
  }
  
}

