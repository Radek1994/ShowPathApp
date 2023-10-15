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
import RxSwift
import RxCocoa

class MapViewController: CommonViewController<MapViewModel> {
    
    let mapView = MKMapView()
    let distanceLabel = UILabel()
    let realDistanceLabel = UILabel()
    let filterButton = UIButton()
    let pointsListContainerView = PannableView(visibleHeight: MapViewController.pannableViewDefaultHeight)
    let pointsListViewController = PointsListViewController(viewModel: PointsListViewModel())
    
    private static let pannableViewDefaultHeight = 150.0
    
    override func setupUI() {
        super.setupUI()
        
        view.addSubview(mapView)
        view.addSubview(pointsListContainerView)
        embedViewController(pointsListViewController, inView: pointsListContainerView.contentView)
        
        mapView.delegate = self
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.bottom.equalToSuperview()
        }
        
        pointsListContainerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.titleView = NavigationBarLogoView()
        
        navigationController?.navigationBar.standardAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance.backgroundColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mapView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: MapViewController.pannableViewDefaultHeight - view.safeAreaInsets.bottom, right: 0)
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
        let rect = polyline.boundingMapRect
        setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), animated: true)
    }
}
