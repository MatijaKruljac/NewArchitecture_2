//
//  CoinInfoInteractorShould.swift
//  NewArchitectureTests
//
//  Created by Matija Kruljac on 20/10/2019.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxSwift
@testable import NewArchitecture

class CoinInfoVIewModelShould: QuickSpec {
    
    override func spec() {
        var apiClientMock: APIClientMock!
        var sut: CoinInfoViewModel!
        
        beforeEach {
            apiClientMock = APIClientMock()
            sut = CoinInfoViewModel(apiClient: apiClientMock)
        }
        
        afterEach {
            apiClientMock = nil
            sut = nil
        }
        
        describe("func fetchCoinInfoList(success: @escaping SuccessHandler<CoinInfoViewController.Data>, failure: FailureHanlder<PrintableError>? = nil)") {
            context("and an error did not occur while fetching data") {
                it("should fetch coin info list and present it") {
                    let coinInfoTest = CoinInfo(name: "testname",
                                                symbol: "testSymbol",
                                                walletStatus: "walletTest",
                                                minDepositAmount: 0,
                                                minOrderAmount: 0)
                    let coinInfoListTest = CoinInfoList(success: true,
                                                        minimalOrderBTC: "test",
                                                        info: [coinInfoTest])
                    apiClientMock.model = coinInfoListTest
                    
                    sut.fetchCoinInfoList(success: {
                        expect(apiClientMock.model)
                            .to(beAKindOf(CoinInfoList.self))
                        expect((apiClientMock.model as! CoinInfoList).minimalOrderBTC)
                            .to(match($0.minimalOrderBTC))
                        expect((apiClientMock.model as! CoinInfoList).info.count) == $0.info.count
                        expect((apiClientMock.model as! CoinInfoList).info.first!.name)
                            .to(match($0.info.first!.name))
                    }, failure: { error in
                        expect(error).toEventually(beNil())
                    })
                }
                
                context("and an error occurred while fetching data") {
                    it("should tell presenter to show error") {
                        apiClientMock.apiError = .invalidStatusCode(code: 404)
                        
                        sut.fetchCoinInfoList(success: {
                            expect($0).toEventually(beNil())
                        }, failure: {
                            expect($0)
                                .toNot(beNil())
                            expect($0?.description)
                                .to(match(apiClientMock.apiError?.description))
                        })
                        
                        expect(apiClientMock.model).toEventually(beNil())
                    }
                }
            }
        }
    }
}
