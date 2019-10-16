//
//  TableViewCell.swift
//  PES Randomizer
//
//  Created by Quang Dinh Le on 10/15/19.
//  Copyright © 2019 Quang Dinh Le. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
  var team: PesTeam? {
    didSet {
      if let imageName = team?.image {
        if team!.selected {
          teamLogo.image = UIImage.init(named: imageName)
          teamName.textColor = UIColor.black
          teamContainer.alpha = 1.0
        } else {
          let ciImage = CIImage(image: UIImage.init(named: imageName)!)!
          let blackAndWhiteImage = ciImage.applyingFilter("CIColorControls", parameters: ["inputSaturation": 0, "inputContrast": 1])
          let result = UIImage.init(ciImage: blackAndWhiteImage)
          teamLogo.image = result
          teamName.textColor = UIColor.lightGray
          teamContainer.alpha = 0.3
        }
      }
      attack.text = String(team?.attack ?? 0)
      midfield.text = String(team?.attack ?? 0)
      defense.text = String(team?.defense ?? 0)
      teamName.text = team?.name
    }
  }
  
  @IBOutlet weak var teamLogo: UIImageView!
  @IBOutlet weak var teamName: UILabel!
  @IBOutlet weak var teamContainer: UIView!
  
  @IBOutlet weak var attackContainer: UIView!
  @IBOutlet weak var midfieldContainer: UIView!
  @IBOutlet weak var defenseContainer: UIView!
  
  @IBOutlet weak var attack: UILabel!
  @IBOutlet weak var midfield: UILabel!
  @IBOutlet weak var defense: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    self.teamContainer.layer.cornerRadius = 10.0
    self.attackContainer.layer.cornerRadius = 5.0
    self.midfieldContainer.layer.cornerRadius = 5.0
    self.defenseContainer.layer.cornerRadius = 5.0
  }
}
