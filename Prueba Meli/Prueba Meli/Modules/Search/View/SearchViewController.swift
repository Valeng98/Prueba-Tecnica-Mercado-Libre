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
    
    lazy var searchBarController: UISearchController? = {
        let resultsController = RecordRouter.createModule { [weak self] text in
            self?.searchBarController?.searchBar.searchTextField.text = text
            self?.viewModel?.resultProdcuts(text: text)
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
        
        definesPresentationContext = false
    }
    
    private func setUp() {
        title = ""
        navigationController?.themeNavigationBar()
        setUpSearchBar()
        setupTableView()
        viewModel?.resultProdcuts(text: nil)
    }
    
    private func setUpSearchBar() {
        searchBarController?.searchBar.searchTextField.placeholder = "Buscar en Mercado Libre"
        searchBarController?.searchBar.searchTextField.text = viewModel?.getTextDefault()
        searchBarController?.searchBar.searchTextField.backgroundColor = .white
        searchBarController?.searchBar.delegate = self
        searchBarController?.searchResultsUpdater = self
        searchBarController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        navigationItem.titleView = searchBarController?.searchBar
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: ProductTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ProductTableViewCell.identifier)
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
        DispatchQueue.main.async { [weak self] in
            self?.tableView.isHidden = true
            let info = InformationViewModel(title: "Algo salió mal",
                                            description: "Estamos trabajando para solucionarlo",
                                            image: "otherError")
            self?.alert(model: info)
        }
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.resultProdcutsCount() ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as? ProductTableViewCell else {
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
extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.searchTextField.text, text != "" else { return }
        
        searchBarController?.showsSearchResultsController = false
        viewModel?.resultProdcuts(text: text)
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let vcResults = searchBarController?.searchResultsController as? RecordViewController {
            definesPresentationContext = true
            searchBarController?.showsSearchResultsController = true
            vcResults.viewModel?.getlistRecord()
            vcResults.recordTableView.reloadData()
        }
    }
}
    
