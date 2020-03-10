//
//  ListTableViewCell.swift
//  AlexisTp
//
//  Created by  on 04/03/2020.
//  Copyright © 2020 alexis. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {



    @IBOutlet weak var listImageMovie: UIImageView!
    
    @IBOutlet weak var listTitleMovie: UILabel!
    
    @IBOutlet weak var listDureeMovie: UILabel!
    
    @IBOutlet weak var listDescriptifMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
