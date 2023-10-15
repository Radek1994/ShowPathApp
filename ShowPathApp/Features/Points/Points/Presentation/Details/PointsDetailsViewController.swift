//
//  PointsDetailsViewController.swift
//  Points
//
//  Created by Radoslaw Slesarczyk on 13/10/2023.
//

import Foundation
import Common
import UIKit
import SnapKit
import MapKit

class PointsDetailsViewController: CommonViewController<PointsDetailsViewModel> {
    
    let mapView = MKMapView()
    let infoLabel = UILabel()
    let addressLabel = UILabel()
    
    let model: PointModel
    
    init(viewModel: PointsDetailsViewModel, model: PointModel) {
        self.model = model
        
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.addSubview(mapView)
        view.addSubview(infoLabel)
        view.addSubview(addressLabel)
        
        view.backgroundColor = .white
        
        mapView.isUserInteractionEnabled = false
        
        infoLabel.numberOfLines = 0
        addressLabel.numberOfLines = 0
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        mapView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(mapView.snp.width).multipliedBy(0.67)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
    
    override func setupRx() {
        super.setupRx()
        
        viewModel.getAddressFromPoint(model)
            .subscribe { [weak self] address in
                self?.addressLabel.text = address
            }.disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let annotation = MKPointAnnotation()
        let coord = CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude)
        annotation.coordinate = coord
        
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: coord, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: true)
        
        infoLabel.text = "\(LocalizableStrings.Points.Details.timestamp.localized): \(model.timestamp)\n\(LocalizableStrings.Points.Details.accuracy.localized): \(model.distance)"
    }
}
