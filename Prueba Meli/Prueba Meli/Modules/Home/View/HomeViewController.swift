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
    lazy var searchBarController: UISearchController? = {
        let resultsController = RecordRouter.createModule { [weak self] text in
            self?.viewModel?.search(text: text)
        }
        return UISearchController(searchResultsController: resultsController)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        definesPresentationContext = true
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

// MARK: View Protocol
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
            vcResults.viewModel?.getlistRecord()
            vcResults.recordTableView.reloadData()
        }
    }
}
