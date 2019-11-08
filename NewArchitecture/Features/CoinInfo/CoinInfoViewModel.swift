//
//  CoinInfoInteractor.swift
//  NewArchitecture
//
//  Created by Matija Kruljac on 19/10/2019.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import RxSwift

class CoinInfoViewModel {
    
    private let apiClient: MockableAPIClient
    private let disposeBag = DisposeBag()
    
    init(apiClient: MockableAPIClient = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public methods
    
    func fetchCoinInfoList(success: @escaping SuccessHandler<CoinInfoViewController.Data>,
                           failure: FailureHanlder<PrintableError>? = nil) {
        guard let request = APIRequest.coinInfo.generated else {
            return
        }
        let single: Single<CoinInfoList> = apiClient.send(request: request)
        single
            .subscribeOnBackgroundObserveOnMain()
            .subscribe { event in
                switch event {
                case .success(let coinInfoList):
                    let viewModel = CoinInfoViewController.Data(coinInfoList: coinInfoList)
                    success(viewModel)
                case .error(let error):
                    let printableError = error as? PrintableError
                    failure?(printableError)
                }
        }.disposed(by: disposeBag)
    }
}
