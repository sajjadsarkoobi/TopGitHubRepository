//
//  HomeViewModel.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 9.11.2022.
//

import Foundation
import Combine

class HomeViewModel {
    
    var isLoadingData: Observable<Bool> = Observable(nil)
    var dataSource: Observable<[RepositoryDetailsCellViewModel]> = Observable(nil)
    var cancellables = Set<AnyCancellable>()
    var errorInLoadingData: (() -> Void)?
    private var isCachedDataLoaded: Bool = false
    
    public enum SectionNames: Int, CaseIterable {
        case shimmerLoadr = 0
        case repositoryItems = 1
    }
    
    func numberOfSections() -> Int {
        SectionNames.allCases.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        let selectedSection = SectionNames(rawValue: section)
        switch selectedSection {
        case .shimmerLoadr:
            if isCachedDataLoaded && (isLoadingData.value ?? false) {
                return 1
            } else {
                return (dataSource.value?.count ?? 0) > 0 ? 0 : 5
            }
            
        case .repositoryItems:
            return dataSource.value?.count ?? 0
            
        case .none:
            return 0
        }
    }
    
    func getRepositorySearch(by language: APIParameters.SearchParams.Languages,
                             sortBy: APIParameters.SearchParams.SortBy,
                             itemPerPage: Int?) {
        
        isLoadingData.value = true
        if UserDefaultManager.shared.showCachedData {
            getCachedData()
        }
        
        APIClient.dispatch(APIRouter.GetSearchRepository(APIParameters.SearchParams(
            q: language, sort: sortBy, per_page: itemPerPage)))
        .sink { [weak self] completion in
            self?.isLoadingData.value = false
            
            switch completion {
            case .failure(let error):
                Log.warning(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.errorInLoadingData?()
                }
            case .finished: break
            }
        } receiveValue: { [weak self] searchData in
            self?.isCachedDataLoaded = false
            self?.setupRepositoryCellViewModel(items: searchData.items)
            self?.cachedData(items: searchData.items)
        }
        .store(in: &cancellables)
    }
    
    func setupRepositoryCellViewModel(items: [RepositoryItemModel]) {
        self.dataSource.value = items.map({RepositoryDetailsCellViewModel(repositoryData: $0)})
    }
    
    func cachedData(items: [RepositoryItemModel]) {
        if let data = try? items.jsonData() {
            CoreDataManager.shared.addLastTrendingData(data: data)
        }
    }
    
    private func getCachedData() {
        let trendingData = CoreDataManager.shared.fetchLastTrendings()
        if let data = trendingData.first?.trendingData,
           let repositoryItem = try? JSONDecoder().decode([RepositoryItemModel].self, from: data) {
            isCachedDataLoaded = true
            setupRepositoryCellViewModel(items: repositoryItem)
            Log.info("Cached data loaded")
        }
    }
}
