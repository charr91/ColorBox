//
//  ColorCell.swift
//  Colorbox
//
//  Created by Cliff Harris on 10/26/16.
//  Copyright © 2016 Clifford Harris. All rights reserved.
//

import UIKit

final class ColorCell: UITableViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
