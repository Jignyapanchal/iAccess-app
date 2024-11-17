//
//  ExpandableCell.swift
//  iACCESS
//
//  Created by Jignya Panchal on 30/09/24.
//

import UIKit

class AllergyCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var stackData: UIStackView!
    @IBOutlet weak var viewDesc: UIView!


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
