//
//  HomeViewController.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 14/07/22.
//

import UIKit
import SkeletonView
import CoreLocation

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var productTableView: UITableView!
    
    var viewModel: HomeViewModelProtocol?
    var currentLocation: CLLocation?
    
    let locationManager = CLLocationManager()
    
    private lazy var searchBarController: UISearchController? = {
        let resultsController = RecordRouter.createModule { [weak self] text in
            self?.viewModel?.search(text: text)
        }
        return UISearchController(searchResultsController: resultsController)
    }()
    
    private lazy var headerTable: UIView? = {
        let header = UIView(frame: CGRect(x: .zero, y: .zero, width: view.frame.size.width, height: 50))
        header.isSkeletonable = true
        let headerLabel = UILabel()
        headerLabel.backgroundColor = .clear
        headerLabel.textColor = .black
        headerLabel.text = "Ropa y Accesorios"
        headerLabel.frame = CGRect(x: 10, y: .zero, width: view.frame.size.width, height: 50)
        headerLabel.font = UIFont(name: "Helvetica", size: 18)
        headerLabel.isSkeletonable = true
        
        header.addSubview(headerLabel)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        definesPresentationContext = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
     
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        searchBarController?.showsSearchResultsController = false
        definesPresentationContext = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUp() {
        title = ""
        
        navigationController?.themeNavigationBar()
        setUpSearchBar()
        setupTable()
        viewModel?.getClothesAndAccessories()
    }
    
    private func setUpSearchBar() {
        searchBarController?.searchBar.searchTextField.placeholder = "Buscar en Mercado Libre"
        searchBarController?.searchBar.searchTextField.backgroundColor = .white
        searchBarController?.searchBar.searchTextField.isEnabled = false
        searchBarController?.searchBar.delegate = self
        searchBarController?.hidesNavigationBarDuringPresentation = false
        searchBarController?.searchResultsUpdater = self
        navigationItem.titleView = searchBarController?.searchBar
    }
    
    private func setupTable() {
        productTableView.dataSource = self
        productTableView.delegate = self
        productTableView.separatorStyle = .none
        productTableView.register(UINib(nibName: ProductTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ProductTableViewCell.identifier)
        productTableView.layer.cornerRadius = 8
        productTableView.isScrollEnabled = false
        productTableView.tableHeaderView = headerTable
        productTableView.tableHeaderView?.isSkeletonable = true
        headerTable?.showAnimatedSkeleton()
    }
    
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}

// MARK: View Protocol
extension HomeViewController: HomeViewProtocol {
    func update() {
        DispatchQueue.main.async { [weak self] in
            self?.productTableView.isScrollEnabled = true
            self?.searchBarController?.searchBar.searchTextField.isEnabled = true
            self?.headerTable?.hideSkeleton()
            self?.productTableView.reloadData()
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.headerTable?.hideSkeleton()
            self?.productTableView.isHidden = true
            
            let info = InformationViewModel(title: "Algo salió mal",
                                            description: "Estamos trabajando para solucionarlo",
                                            image: "otherError")
            self?.alertView(model: info)
        }
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.listProductsCount() ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(product: viewModel?.getProduct(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.productDetail(index: indexPath.row)
    }
}

// MARK: UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.searchTextField.text, text != "" else { return }
        searchBar.searchTextField.text = ""
        
        viewModel?.search(text: text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !(searchBarController?.showsSearchResultsController ?? false) && searchText != "" else { return }
        searchBarController?.showsSearchResultsController = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let vcResults = searchBarController?.searchResultsController as? RecordViewController {
            vcResults.setUp()
            vcResults.recordTableView.reloadData()
        }
    }
}

//MARK: Location
extension HomeViewController: CLLocationManagerDelegate {
     
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestMeliForLocation()
        }
    }
    
    func requestMeliForLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
        getAddressFromLatLon(latitude: lat, longitude: long)
    }
    
    func getAddressFromLatLon(latitude: Double, longitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = latitude
        center.longitude = longitude
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = placemarks![0]
                var addressString : String = ""
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                
                self.alertModal(mensaje: "Su direccion de entrega es: \(addressString)", completion: nil)
            }
        })
    }
}
