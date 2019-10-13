//
//  TableViewCell.swift
//  MHacks19
//
//  Created by Sam Jaehnig on 10/12/19.
//  Copyright © 2019 Sam Jaehnig. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var Item: UILabel!
    
//    func setItem(item: Item){
//        Item.text = item.title
//    }
    func setItem(item: String){
        Item.text = item
    }


}
