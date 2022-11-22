//
//  HomeViewController.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 9.11.2022.
//

import UIKit

class HomeViewController: UIViewController {

    //IBOutlets:
    @IBOutlet weak var tableView: UITableView!
    
    //Objects
    var refreshController: UIRefreshControl?
    
    //View model
    var viewModel: HomeViewModel
    
    //Data source
    var repositoriesDataSource: [RepositoryDetailsCellViewModel] = []
    
    //Passing data:
    var openSettingsTapped: (() -> Void)?
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    @objc func loadData() {
        viewModel.getRepositorySearch(by: .swift, sortBy: .stars, itemPerPage: nil)
    }
    
    private func configView() {
        self.title = "Trending"
        self.setupTableView()
        self.addRightNavigationToolbarButton()
    }
    
    private func addRightNavigationToolbarButton() {
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                                              style: .plain,
                                                              target: self,
                                                              action: #selector(openSettings)),
                                              animated: true)
    }
    
    @objc func openSettings() {
        openSettingsTapped?()
    }
    
    private func bindViewModel() {
        //Binding Observable objects from viewModel
        viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else {
                return
            }
            
            if !isLoading {
                DispatchQueue.main.async {
                    self.reloadTableView()
                }
            }
        }
        
        viewModel.dataSource.bind { [weak self] cellData in
            guard let self = self, let cellData = cellData else {
                return
            }
            self.repositoriesDataSource = cellData
            self.reloadTableView()
        }
        
        viewModel.errorInLoadingData = { [weak self] in
            self?.showErorLoading()
        }
    }
    
    func showErorLoading() {
        let errorView = ErrorInLoadingView()
        errorView.delegate = self
        errorView.appear(sender: self)
    }
}

extension HomeViewController: ErrorInLoadingViewDelegate {
    func dismissed() {
        // eror pop up dismissed
    }
    
    func reloadAgain() {
        self.loadData()
    }
}
