//
//  HomeViewController.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 14/07/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    
    var viewModel: HomeViewModelProtocol?
    
    lazy var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpIU()
        viewModel?.getClothesAndAccessories()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.themeNavigationBar()
    }
    
    private func setUpIU() {
        setUpSearchBar()
        setupTable()
    }
    
    private func setUpSearchBar() {
        searchBar.searchTextField.placeholder = "Buscar en Mercado Libre"
        searchBar.searchTextField.backgroundColor = .white
    
        navigationItem.titleView = searchBar
        //searchBar.showsCancelButton = true
        
    }
    
    private func setupTable() {
        productTableView.dataSource = self
        productTableView.delegate = self
        productTableView.separatorStyle = .none
        productTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        productTableView.layer.cornerRadius = 8
        
        let header = UIView(frame: CGRect(x: .zero, y: .zero, width: view.frame.size.width, height: 50))
        let headerLabel = UILabel()
        headerLabel.backgroundColor = .clear
        headerLabel.textColor = .black
        headerLabel.text = "Ropa y Accesorios"
        headerLabel.frame = CGRect(x: 10, y: .zero, width: view.frame.size.width, height: 50)
        headerLabel.font = UIFont(name: "Helvetica", size: 18)

        
        header.addSubview(headerLabel)
        productTableView.tableHeaderView = header
    }
    
}

extension HomeViewController: HomeViewProtocol {
    func update() {
        DispatchQueue.main.async { [weak self] in
            self?.productTableView.reloadData()
        }
    }
    
    func update(with error: String) {
        print(error)
    }
}


// MARK: UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.listProductsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(product: viewModel?.getProduct(index: indexPath.row))
        return cell
    }
}


