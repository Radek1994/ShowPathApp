//
//  CommonViewController.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 09/10/2023.
//

import Foundation
import RxSwift
import UIKit
import SnapKit

open class CommonViewController<ViewModelType: CommonViewModel>: UIViewController {
    
    public var disposeBag = DisposeBag()
    private let loadingView = LoadingView()
    open var viewModel: ViewModelType
    
    public init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
        setupConstraints()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupUI() {
        view.addSubview(loadingView)
        
        loadingView.layer.zPosition = 100
    }
    
    open func setupConstraints() {
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRx()
        viewModel.getData()
    }
    
    open func setupRx() {
        disposeBag = DisposeBag()
        
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] isLoading in
                self?.setLoading(isLoading)
            }.disposed(by: disposeBag)
        
        viewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] error in
                self?.showError(error)
            }.disposed(by: disposeBag)
    }
    
    open func setLoading(_ isLoading: Bool) {
        loadingView.isHidden = !isLoading
    }
    
    open func showError(_ error: CommonError) {
        let alert = UIAlertController(title: LocalizableStrings.Common.error.localized, message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
