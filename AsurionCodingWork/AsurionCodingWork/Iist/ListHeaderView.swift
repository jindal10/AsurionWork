//
//  ListHeaderView.swift
//  AsurionCodingWork
//
//  Created by Gaurav Jindal on 02/08/22.
//

import UIKit
protocol ListHeaderViewDelegate: AnyObject {
    func callButtonAction()
    func chatButtonAction()
}

class ListHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var actionStackView: UIStackView!
    weak var delegate: ListHeaderViewDelegate?
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        chatButton.layer.cornerRadius = 10
        callButton.layer.cornerRadius = 10
    }
    
    @IBAction func callButtonClicked(_ sender: UIButton) {
        delegate?.callButtonAction()
    }
    
    @IBAction func chatButtonClicked(_ sender: UIButton) {
        delegate?.chatButtonAction() 
    }
}
