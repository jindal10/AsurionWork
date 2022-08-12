//
//  ListTableViewCell.swift
//  AsurionCodingWork
//
//  Created by Gaurav Jindal on 02/08/22.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petNameLabel: UILabel!

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        petImageView.image = nil
    }
}
