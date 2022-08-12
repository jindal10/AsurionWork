//
//  PetListViewController.swift
//  AsurionCodingWork
//
//  Created by Gaurav Jindal on 02/08/22.
//

import UIKit

class PetListViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    lazy var viewModel: PetListViewModel = PetListViewModel()

    private let estimatedHeight: CGFloat = 180
    private let rowHeight: CGFloat = 135

    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.estimatedRowHeight = estimatedHeight
        fetchConfig()
        registerNib()
    }

    private func registerNib() {
        let nib = UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil)
        listTableView.register(nib, forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        listTableView.register(UINib(nibName: ListHeaderView.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: ListHeaderView.reuseIdentifier)
    }
    
    func fetchConfig() {
        viewModel.geConfigData { [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    self?.fetPetList()
                } else {
                    self?.configApiFailure()
                }
            }
        }
    }
    
    func fetPetList() {
        viewModel.fetchPetData { [weak self] success, error in
            if success {
                DispatchQueue.main.async {
                    self?.listTableView.reloadData()
                }
            } else {
                self?.petListApiFailure()
            }
        }
    }
    
    private func configApiFailure() {
        UIAlertController.show(AlertMessage.configApiFail.message(), from: self)
    }
    
    private func petListApiFailure() {
        UIAlertController.show(AlertMessage.configApiFail.message(), from: self)
    }
    
    private func contactCall() {
        if viewModel.isWorkingHourOpen(for: IndexPath(row: 0, section: 0)) {
            UIAlertController.show(AlertMessage.workHoursOpen.message(), from: self)
        } else {
            UIAlertController.show(AlertMessage.workHoursEnded.message(), from: self)
        }
    }
}

extension PetListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else {
            fatalError(StringConstant.unableDequeueCell)
        }
        if let imageString = viewModel.getimage(index: indexPath.row) {
            cell.petImageView?.setImage(urlString: imageString)
        }
        cell.petNameLabel.text = viewModel.getPetName(index: indexPath.row)
        return cell
    }
}

extension PetListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contentUrl = viewModel.getContentUrl(index: indexPath.row)
        if let detailsController = self.storyboard?.instantiateViewController(withIdentifier: "PetDetailsViewController") as? PetDetailsViewController {
            detailsController.contentUrl = contentUrl
            navigationController?.pushViewController(detailsController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ListHeaderView.reuseIdentifier) as? ListHeaderView else { fatalError() }
        headerView.delegate = self
        headerView.timeLabel.text = viewModel.getWorkingHours()
        headerView.callButton.isHidden = !viewModel.isCallEnable()
        headerView.chatButton.isHidden = !viewModel.isChatEnable()
        if !viewModel.isCallEnable() && !viewModel.isChatEnable() {
            headerView.actionStackView.isHidden = true
        } else {
            headerView.actionStackView.isHidden = false
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.getHeightOfHeader()
    }
}

extension PetListViewController: ListHeaderViewDelegate {
    func callButtonAction() {
        contactCall()
    }

    func chatButtonAction() {
        contactCall()
    }
}
