//
//  BoxCell.swift
//  Flood
//
//  Created by MAHIMA on 27/08/20.
//  Copyright © 2020 MAHIMA. All rights reserved.
//

import UIKit

class BoxCell: UICollectionViewCell {
    var state: State = .solid {
        didSet {
            self.colorView.backgroundColor =  state.getColor()
        }
    }
    var position: Position = .middle
    var value: Int = 0
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var valLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(for box: Box) {
        self.state = box.state
        self.position = box.position
        self.value = box.val
       // valLabel.text = "\(self.value)"
    }
}
