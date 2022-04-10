//
//  SubscriptionBuilder.swift
//  SmartReceipts
//
//  Created by a.agataev on 27.03.2022.
//  Copyright © 2022 Will Baumann. All rights reserved.
//

import Foundation
import StoreKit
import RxSwift
import RxCocoa

public struct SubscriptionEnvironment {
    let purchaseService: PurchaseService
    let router: SubscriptionRouter
    let authService: AuthService
    
    init(purchaseService: PurchaseService, router: SubscriptionRouter, authService: AuthService ) {
        self.purchaseService = purchaseService
        self.router = router
        self.authService = authService
    }
}

public enum SubscriptionBuilder {
    public static func build() -> UIViewController {
        let purchaseService = PurchaseService()
        let router = SubscriptionRouter()
        let authService = AuthService()
        let environment = SubscriptionEnvironment(
            purchaseService: purchaseService,
            router: router,
            authService: authService
        )
        let viewModel = SubscriptionViewModel(environment: environment)
        let dataSource = SubscriptionDataSource()
        let vc = SubscriptionViewController(dataSource: dataSource)
        vc.output.drive(onNext: {
            viewModel.accept(action: $0)
        }).disposed(by: vc.bag)
        vc.bind(viewModel.output.map(convert(state:)))
        router.moduleViewController = vc
        return vc
    }
    
    private static func convert(
        state: SubscriptionViewModel.State
    ) -> SubscriptionViewController.ViewState {
        switch state {
        case .content(let products):
            let collection = products.compactMap { product -> PlanSectionItem in
                return PlanSectionItem(
                    items: [
                        PlanModel(
                        kind: product.productIdentifier == PRODUCT_STANDARD_SUB ? .standard : .premium,
                        price: product.localizedPrice,
                        isPurchased: product.productIdentifier == PRODUCT_STANDARD_SUB ? true : false )
                    ]
                )
            }
            return .content(collection)
        case .loading:
            return .loading
        case .error:
            return .error
        }
    }
}
