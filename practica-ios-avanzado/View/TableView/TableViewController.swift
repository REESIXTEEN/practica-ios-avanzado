//
//  TableViewController.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 14/2/23.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var heroes: [Heroe] = []
    var searchedHeroes: [Heroe] = []
    
    let viewModel: TableViewModel = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        navigationItem.title = "Heroes"
        
        let xib = UINib(nibName: "TableCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "customTableCell")
        
        if !viewModel.checkLogin() {
            let loginViewController = LoginViewController()
            loginViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(loginViewController, animated: true)
        }
        else {
            
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableCell", for: indexPath) as! CellViewController
        let heroe = searchedHeroes[indexPath.row]
        cell.cellImage.setImage(url: heroe.photo)
        cell.nameLabel.text = heroe.name
        cell.descriptionLabel.text = heroe.description
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let heroe = searchedHeroes[indexPath.row]
        let detailsView = DetailViewController()
        detailsView.heroe = heroe
        navigationController?.pushViewController(detailsView, animated: true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        searchedHeroes = searchText.isEmpty ? heroes : heroes.filter { heroe in
            return heroe.name.range(of: searchText, options: .caseInsensitive, range: nil,locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    


}
