//
//  GameCollectionViewCell.swift
//  TicTacToe
//
//  Created by Venugopal Reddy Devarapally on 05/06/17.
//  Copyright © 2017 venu. All rights reserved.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    var playerId: Int = 0
}
