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
        } else {
          let ciImage = CIImage(image: UIImage.init(named: imageName)!)!
          let blackAndWhiteImage = ciImage.applyingFilter("CIColorControls", parameters: ["inputSaturation": 0, "inputContrast": 1])
          let result = UIImage.init(ciImage: blackAndWhiteImage)
          teamLogo.image = result
          teamName.textColor = UIColor.lightGray
        }
      }
      
      teamName.text = team?.name
    }
  }
  
  @IBOutlet weak var teamLogo: UIImageView!
  @IBOutlet weak var teamName: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

  }

}
