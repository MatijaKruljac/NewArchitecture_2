//
//  CoinInfoCoordinator.swift
//  NewArchitecture
//
//  Created by Matija Kruljac on 19/10/2019.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation

class CoinInfoCoordinator {
    
    private let viewModel: CoinInfoViewModel
    private let router: CoinInfoRouter
    
    init(viewController: CoinInfoViewController) {
        viewModel = CoinInfoViewModel()
        router = CoinInfoRouter(navigationController: viewController.navigationController)
    }
    
    // MARK: - Public methods
    
    func fetchCoinInfoList(success: @escaping SuccessHandler<CoinInfoViewController.Data>,
                           failure: FailureHanlder<PrintableError>? = nil) {
        viewModel.fetchCoinInfoList(success: success, failure: failure)
    }
    
    func presentDetails(for coinInfo: CoinInfo) {
        router.presentDetails(for: coinInfo)
    }
    
    func presentError(error: String?) {
        router.presentAlert(title: "Error", message: error)
    }
}
