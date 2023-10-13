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
            .subscribe { [weak self] isLoading in
                self?.setLoading(isLoading)
            }.disposed(by: disposeBag)
        
        viewModel.error
            .subscribe { [weak self] error in
                self?.showError(error)
            }.disposed(by: disposeBag)
    }
    
    open func setLoading(_ isLoading: Bool) {
        view.bringSubviewToFront(loadingView)
        loadingView.isHidden = !isLoading
    }
    
    open func showError(_ error: CommonError) {
        print(error)
    }
}
