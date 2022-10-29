//
//  TableViewCell.swift
//  WEBSERVICES_API
//
//  Created by Gurpreet Kaur on 2022-10-29.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
   
    @IBOutlet weak var BreedName: UILabel!
    @IBOutlet weak var BreedImage: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // for spinner animation
        spinner.startAnimating()
        // Configure the view for the state that is selected
    }

}

