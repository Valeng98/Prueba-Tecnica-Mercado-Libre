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
        
        view.backgroundColor = .white
        setupTable()

    }
    
    func setupTable() {
        
        recordTableView.delegate = self
        recordTableView.dataSource = self
        recordTableView.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "RecordTableViewCell")
    }
}

extension RecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell") as? RecordTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
