//
//  HomeViewController+TableView.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 9.11.2022.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        registerNibs()
        
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
        setupTableRefreshController()
    }
    
    func setupTableRefreshController() {
        refreshController = UIRefreshControl()
        refreshController?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.tableView.refreshControl = refreshController
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshController?.endRefreshing()
        }
    }
    
    private func registerNibs() {
        self.tableView.register(RepositoryDetailsCell.register(),
                                forCellReuseIdentifier: RepositoryDetailsCell.cellIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = HomeViewModel.SectionNames(rawValue: indexPath.section)
        switch section {
        case .shimmerLoadr:
            return generateRepositoryCell(isShimmerActive: true, indexPath: indexPath)
            
        case .repositoryItems:
            return generateRepositoryCell(isShimmerActive: false, indexPath: indexPath)
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RepositoryDetailsCell else {
            return
        }
        
        tableView.beginUpdates()
        cell.cellTapped()
        tableView.endUpdates()
    }
    
    private func generateRepositoryCell(isShimmerActive: Bool, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryDetailsCell.cellIdentifier,
                                                       for: indexPath) as? RepositoryDetailsCell else {
            return UITableViewCell()
        }
        
        if isShimmerActive {
            cell.isShimmerActive = isShimmerActive
        } else {
            if indexPath.row < self.repositoriesDataSource.count {
                let viewModel = self.repositoriesDataSource[indexPath.row]
                cell.setupCell(viewModel: viewModel)
            }
        }
        cell.selectionStyle = .none
        return cell
    }
}
