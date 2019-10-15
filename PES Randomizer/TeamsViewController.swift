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
}

class TeamsViewController: UITableViewController {
  var teams = [
    PesTeam(image: "arsenal", name: "Arsenal"),
    PesTeam(image: "atletico-de-madrid", name: "Atletico De Madrid"),
    PesTeam(image: "barcelona", name: "Barcelona"),
    PesTeam(image: "bayern-munchen", name: "Bayern Munchen"),
    PesTeam(image: "juventus", name: "Juventus"),
    PesTeam(image: "liverpool", name: "Liverpool"),
    PesTeam(image: "manchester-city", name: "Manchester City"),
    PesTeam(image: "manchester-united", name: "Manchester United"),
    PesTeam(image: "psg", name: "PSG"),
    PesTeam(image: "napoli", name: "Napoli"),
    PesTeam(image: "chelsea", name: "Chelsea"),
    PesTeam(image: "tottenham-hotspur", name: "Tottenham Hotspur"),
    PesTeam(image: "internazionale", name: "Inter Milan"),
    PesTeam(image: "dvb", name: "Dortmund"),
    PesTeam(image: "real-madrid", name: "Real Madrid")
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

