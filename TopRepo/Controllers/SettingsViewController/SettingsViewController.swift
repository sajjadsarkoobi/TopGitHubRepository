//
//  SettingsViewController.swift
// TopRepo
//
//  Created by Sajjad Sarkoobi on 12.11.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var loadingCacheSwitch: UISwitch!
    @IBAction func loadingCacheSwitchAction(_ sender: UISwitch) {
        UserDefaultManager.shared.showCachedData = sender.isOn
    }
    
    @IBOutlet weak var deleteCacheButton: UIButton!
    @IBAction func deleteCacheButtonAction(_ sender: UIButton) {
        deleteCacheData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       configView()
    }
    
    private func configView() {
        self.title = "Settings"
        
        deleteCacheButton.setDefaultButton(title: "Clear cached data",
                                           backgroundColor: .systemRed)
        loadingCacheSwitch.isOn = UserDefaultManager.shared.showCachedData
    }
    
    private func deleteCacheData() {
        let trendingData = CoreDataManager.shared.fetchLastTrendings()
        if trendingData.isEmpty {
            showMessage("There is no cached data")
        } else {
            CoreDataManager.shared.deleteAllData()
            showMessage("Cached data cleared")
        }
    }
    
    private func showMessage( _ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }

}
