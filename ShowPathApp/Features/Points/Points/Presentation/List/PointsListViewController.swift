//
//  PointsListViewController.swift
//  ShowPathApp
//
//  Created by Radoslaw Slesarczyk on 11/10/2023.
//

import Foundation
import Common
import UIKit
import RxSwift
import RxCocoa

public class PointsListViewController: CommonViewController<PointsListViewModel> {
    
    let titleLabel = UILabel()
    let pagesSegmentedControl = CommonSegmentedControl()
    let separator = UIView()
    let pageViewControllerContrainerView = UIView()
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    var viewControllers = [UIViewController]()
    
    public override func setupUI() {
        super.setupUI()
        
        view.addSubview(titleLabel)
        view.addSubview(pagesSegmentedControl)
        view.addSubview(pageViewControllerContrainerView)
        embedViewController(pageViewController, inView: pageViewControllerContrainerView)
        
        view.backgroundColor = .white
        
        titleLabel.textAlignment = .center
        titleLabel.text = LocalizableStrings.Points.title.localized
        
        viewModel.segmentedControlItems
            .enumerated()
            .forEach { index, title in
                pagesSegmentedControl.insertSegment(withTitle: title, at: index, animated: false)
            }
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        viewControllers = viewModel.viewControllers
        
        if let firstViewController = viewControllers.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true)
        }
        
        pagesSegmentedControl.selectedSegmentIndex = 0
    }
    
    public override func setupConstraints() {
        super.setupConstraints()
        
        titleLabel.snp.makeConstraints {
//            $0.top.left.right.equalToSuperview().inset(16)
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        pagesSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        
        pageViewControllerContrainerView.snp.makeConstraints {
            $0.top.equalTo(pagesSegmentedControl.snp.bottom).offset(16)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    public override func setupRx() {
        super.setupRx()
        
        pagesSegmentedControl.rx
            .indexChangeObservable
            .subscribe { [unowned self] indexChange in
                self.segmentedControlChanged(indexChange)
            }.disposed(by: disposeBag)
    }
    
    private func segmentedControlChanged(_ indexChange: CommonSegmentedControlIndexChange) {
        guard viewControllers.haveIndex(indexChange.after) else { return }
        
        let direction: UIPageViewController.NavigationDirection = indexChange.before < indexChange.after ? .forward : .reverse
        
        pageViewController.setViewControllers([viewControllers[indexChange.after]], direction: direction, animated: true)
    }
    
    private func segmentedControlSetIndex(_ index: Int) {
        pagesSegmentedControl.selectedSegmentIndex = index
    }
}

extension PointsListViewController: UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        
        let indexBefore = index - 1
        
        guard viewControllers.haveIndex(indexBefore) else { return nil }
        
        return viewControllers[indexBefore]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        
        let indexAfter = index + 1
        
        guard viewControllers.haveIndex(indexAfter) else { return nil }
        
        
        return viewControllers[indexAfter]
    }
}

extension PointsListViewController: UIPageViewControllerDelegate {
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        
        guard let viewController = pageViewController.viewControllers?.first else { return }
        
        guard let index = viewControllers.firstIndex(of: viewController) else { return }
        
        segmentedControlSetIndex(index)
    }
}
