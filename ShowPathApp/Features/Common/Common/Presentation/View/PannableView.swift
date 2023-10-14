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
    
    public var heightConstraint: ConstraintMakerEditable? = nil
    public var visibleHeight = 0.0 {
        didSet {
            currentHeight = visibleHeight
        }
    }
    var currentHeight = 0.0
    public var maxHeight = 0.0
    private var defaultCornerRadius = 32.0
    
    public override init() {
        super.init()
        
        setupUI()
        addPanGesture()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func setupUI() {
        super.setupUI()
        
        setCornerRadius(defaultCornerRadius)
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
        
        var height = currentHeight - diff
        height = max(visibleHeight, min(maxHeight, height))
        
        updateHeight(height)
        
        switch recognizer.state {
        case .cancelled, .ended, .failed:
            currentHeight = height
        default:
            break
        }
    }
    
    public func updateHeight(_ height: Double) {
        setCornerRadius(defaultCornerRadius * (1 - height / maxHeight))
        
        snp.updateConstraints {
            $0.height.equalTo(height)
        }
    }
}
