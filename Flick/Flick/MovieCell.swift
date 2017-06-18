//
//  MovieCell.swift
//  Flick
//
//  Created by Triet on 6/17/17.
//  Copyright © 2017 Triet. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

  @IBOutlet weak var posterImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
