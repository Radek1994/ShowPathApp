//
//  MapViewController.swift
//  ShowPathApp
//
//  Created by Radoslaw Slesarczyk on 09/10/2023.
//

import UIKit
import MapKit
import SnapKit
import Common
import Points

class MapViewController: CommonViewController<MapViewModel> {
    
    let mapView = MKMapView()
    let distanceLabel = UILabel()
    let realDistanceLabel = UILabel()
    let filterButton = UIButton()
    let pointsListContainerView = UIView()
    let pointsListViewController = PointsListViewController(viewModel: PointsListViewModel())
    
    override func setupUI() {
        super.setupUI()
        
        view.addSubview(mapView)
        view.addSubview(pointsListContainerView)
        embedViewController(pointsListViewController, inView: pointsListContainerView)
        
        mapView.delegate = self
        
        pointsListContainerView.setCornerRadius(32)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pointsListContainerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(500)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    override func setupRx() {
        super.setupRx()
        
        viewModel.pathObservable
            .subscribe { [weak self] polyline in
                self?.mapView.addOverlay(polyline)
                self?.mapView.showPolyline(polyline)
            }.disposed(by: disposeBag)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        guard let overlay = overlay as? MKPolyline else {
            return MKOverlayRenderer()
        }
        
        let renderer = MKPolylineRenderer(polyline: overlay)
        
        renderer.lineWidth = 7
        renderer.strokeColor = .systemBlue
        renderer.fillColor = .systemTeal
        
        return renderer
    }
}

extension MKMapView {
    
    func showPolyline(_ polyline: MKPolyline) {
        let margin = 0.1
        
        let rect = polyline.boundingMapRect
        let widthMargin = rect.width * margin
        let heightMargin = rect.height * margin
        
        let rectWithMargin = MKMapRect(x: rect.origin.x - widthMargin,
                                       y: rect.origin.y - heightMargin,
                                       width: rect.width + 2 * widthMargin,
                                       height: rect.height + 2 * heightMargin)
        
        setRegion(MKCoordinateRegion(rectWithMargin), animated: true)
    }
}
