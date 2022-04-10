//
//  SubscriptionRouter.swift
//  SmartReceipts
//
//  Created by Азамат Агатаев on 12.12.2021.
//  Copyright © 2021 Will Baumann. All rights reserved.
//

import UIKit
import RxSwift

final class SubscriptionRouter {
    weak var moduleViewController: UIViewController!
    
    func openLogin() {
        let module = AppModules.auth.build()
        module.router.show(from: moduleViewController, embedInNavController: true)
    }
     
    func openSuccessPage() {
        let successPlanVc = SuccessPlanBuilder.build() as! SuccessPlanViewController
        successPlanVc.modalPresentationStyle = .fullScreen
        moduleViewController.present(successPlanVc, animated: true)
    }
}
