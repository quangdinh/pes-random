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
  @IBOutlet weak var logoContainer: UIView!
  @IBOutlet weak var logo: UIImageView!
  @IBOutlet weak var logoAlt: UIImageView!
  var timer:Timer? = nil
  var times:Int = 0;
  var showingAlt = false
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    logo.alpha = 0.0
    logoAlt.alpha = 0.0
    logoContainer.layer.cornerRadius = 150.0
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
    restartTime(interval: 0.05)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
      self.restartTime(interval: 0.1)
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
        self.restartTime(interval: 0.2)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
          self.restartTime(interval: 0.5)
          self.timer?.invalidate()
          self.timer = nil
        }
      }
    }
  }
  
  func restartTime(interval: TimeInterval) {
    self.timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval:interval, repeats: true, block: { (_) in
      let team = self.teams?.randomElement()
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
      
    })
  }
}
