//
//  BaseViewController.swift
//  SeSACRxThreads
//
//  Created by 김진수 on 4/1/24.
//

import UIKit

class BaseViewController<T: BaseView>: UIViewController {
    
    let mainView = T()

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        configureNav()
    }
    
    func configureNav() {
        
    }
    
    func bind() {
        
    }

}
