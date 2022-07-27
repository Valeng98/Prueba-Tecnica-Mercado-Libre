//
//  RecordViewController.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 19/07/22.
//

import UIKit

class RecordViewController: UIViewController,RecordViewProtocol  {
    var viewModel: RecordViewModelProtocol?
    
    @IBOutlet weak var recordTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    private func setUp() {
        view.backgroundColor = .white
        setupTable()
        viewModel?.getlistRecord()
    }
    
    func setupTable() {
        recordTableView.delegate = self
        recordTableView.dataSource = self
        recordTableView.separatorStyle = .none
        recordTableView.register(UINib(nibName: RecordTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RecordTableViewCell.identifier)
        
        let header = UIView(frame: CGRect(x: .zero, y: .zero, width: view.frame.size.width, height: 50))
        let headerLabel = UILabel()
        headerLabel.backgroundColor = .clear
        headerLabel.textColor = .black
        headerLabel.text = "Últimas búsquedas"
        headerLabel.frame = CGRect(x: 10, y: .zero, width: view.frame.size.width, height: 50)
        headerLabel.font = UIFont(name: "Helvetica", size: 18)

        
        header.addSubview(headerLabel)
        recordTableView.tableHeaderView = header
    }
}

extension RecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.listRecordCount() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.identifier) as? RecordTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setUp(text: viewModel?.recordText(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.searchRecordText(index: indexPath.row)
    }
}
