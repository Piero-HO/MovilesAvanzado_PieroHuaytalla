//
//  PersonasTableViewCell.swift
//  Laboratorio07_2
//
//  Created by Piero Huaytalla on 14/10/26.
//

import UIKit

class PersonasTableViewCell: UITableViewCell {

    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
