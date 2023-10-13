//
//  CommonTableViewCell.swift
//  Common
//
//  Created by Radoslaw Slesarczyk on 12/10/2023.
//

import Foundation
import UIKit

open class CommonTableViewCell<ModelType>: UITableViewCell {
    
    public static var cellIdentifier: String {
        String(describing: self)
    }
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setupUI()
        setupConstraints()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupUI() {
        
    }
    
    open func setupConstraints() {
        
    }
    
    open func setupWithModel(_ model: ModelType) {
        
    }
    
    public static func registerIn(_ tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: Self.cellIdentifier)
    }
}
