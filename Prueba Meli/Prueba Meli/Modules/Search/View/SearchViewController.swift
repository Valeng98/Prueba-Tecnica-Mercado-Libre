//
//  SearchViewController.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 18/07/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SearchViewModelProtocol?
    
    lazy var searchBarController = UISearchController(searchResultsController: RecordRouter.createModule())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    private func setUp() {
        title = ""
        navigationController?.themeNavigationBar()
        setUpSearchBar()
        setupTableView()
        viewModel?.resultProdcuts()
    }
    
    private func setUpSearchBar() {
        searchBarController.searchBar.searchTextField.placeholder = "Buscar en Mercado Libre"
        searchBarController.searchBar.searchTextField.text = viewModel?.getTextDefault()
        searchBarController.searchBar.searchTextField.backgroundColor = .white
        searchBarController.searchBar.delegate = self
        searchBarController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        navigationItem.titleView = searchBarController.searchBar
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        tableView.layer.cornerRadius = 8
    }
}
    
// MARK: View Protocol
extension SearchViewController: SearchViewProtocol {
    func update() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func update(with error: String) {
        print(error)
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.resultProdcutsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(product: viewModel?.getProduct(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.detail(index: indexPath.row)
    }
}

// MARK: UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.searchTextField.text, text != "" else { return }
        searchBar.searchTextField.text = ""
        
        print(text)
        
        //viewModel?.search(text: text)
    }
}
    
