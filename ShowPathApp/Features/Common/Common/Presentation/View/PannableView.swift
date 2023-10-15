//
//  PannableView.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 14/10/2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

public class PannableView: CommonView {
    
    var panGestureRecognizer = UIPanGestureRecognizer()
    var panDisposeBag = DisposeBag()
    public var contentView = UIView()
    
    public var minVisibleOffset: Double
    var currentOffset: Double
    
    var maxOffset: Double {
        return self.bounds.height
    }
    
    private var defaultCornerRadius = 32.0
    
    var topConstraint: ConstraintMakerEditable? = nil
    
    public init(visibleHeight: Double) {
        self.minVisibleOffset = visibleHeight
        self.currentOffset = visibleHeight
        
        super.init()
        
        addPanGesture()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func setupUI() {
        super.setupUI()
        
        addSubview(contentView)
        contentView.setCornerRadius(defaultCornerRadius)
    }
    
    public override func setupConstraints() {
        super.setupConstraints()
        
        contentView.snp.makeConstraints {
            topConstraint = $0.top.equalTo(self.snp.bottom).offset(-minVisibleOffset)
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    
    func addPanGesture() {
        addGestureRecognizer(panGestureRecognizer)
        
        panGestureRecognizer.rx
            .event
            .bind { [unowned self] recognizer in
                self.handleRecognizerEvent(recognizer)
            }.disposed(by: panDisposeBag)
    }
    
    func handleRecognizerEvent(_ recognizer: UIPanGestureRecognizer) {
        let diff = recognizer.translation(in: recognizer.view).y
        
        var offset = currentOffset - diff
        offset = max(minVisibleOffset, min(maxOffset, offset))
        
        updateOffset(offset)
        
        switch recognizer.state {
        case .cancelled, .ended, .failed:
            handleGluableForOffset(offset)
        default:
            break
        }
    }
    
    private func updateOffset(_ offset: Double) {
        topConstraint?.constraint.update(offset: -offset)
        contentView.setCornerRadius(defaultCornerRadius * (1 - offset/maxOffset))
    }
    
    private func handleGluableForOffset(_ offset: Double) {
        let progress = offset/maxOffset
        
        let nextOffset: Double
        if progress > 0.33 {
            nextOffset = maxOffset
        } else {
            nextOffset = minVisibleOffset
        }
        
        UIView.animate(withDuration: 0.3) {
            self.updateOffset(nextOffset)
            self.layoutIfNeeded()
        }
        
        currentOffset = nextOffset
    }
}
