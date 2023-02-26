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
    
    var heroes: [HeroeEntity] = []
    var searchedHeroes: [HeroeEntity] = []
    
    let viewModel: TableViewModel = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        navigationItem.title = "Heroes"
        
        let xib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "customTableCell")
        
        if !viewModel.checkLogin() {
            let loginViewController = LoginViewController()
            loginViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(loginViewController, animated: true)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //He puesto esto aqui ya que la primera vez que se hace login, no se mostrarían los heroes en la tabla si lo
        // pusiese en el loadView()
        if heroes.isEmpty {
            viewModel.getHeroes(){ [weak self] heroes in
                self?.heroes = heroes
                self?.searchedHeroes = heroes
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableCell", for: indexPath) as! TableViewCell
        let heroe = searchedHeroes[indexPath.row]
        cell.cellImage.setImage(url: heroe.photo!)
        cell.cellName.text = heroe.name
        cell.cellDetails.text = heroe.details
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchedHeroes.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let heroe = searchedHeroes[indexPath.row]
        let detailsView = DetailViewController()
        detailsView.heroe = heroe
        navigationController?.pushViewController(detailsView, animated: true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        searchedHeroes = searchText.isEmpty ? heroes : heroes.filter { heroe in
            return heroe.name?.range(of: searchText, options: .caseInsensitive, range: nil,locale: nil) != nil
        }
        tableView.reloadData()
    }

}
