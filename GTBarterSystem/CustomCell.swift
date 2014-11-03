//
//  CustomCell.swift
//  GTBarterSystem
//
//  Created by Haytham Abutair on 10/4/14.
//  Copyright (c) 2014 Haytham Abutair. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    
    
    override init?(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(title:String, description:String){
        self.productTitle.text = title
        self.productDescription.text = description
    }

}
