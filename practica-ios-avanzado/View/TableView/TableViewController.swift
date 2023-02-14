//
//  TableViewController.swift
//  practica-ios-avanzado
//
//  Created by Pablo Gómez on 14/2/23.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var heroes: [Heroe] = []
    var searchedHeroes: [Heroe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //searchBar.delegate = self
        
        navigationItem.title = "Heroes"
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let xib = UINib(nibName: "TableCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "customTableCell")
        
        let token = LocalDataLayer.shared.getValue(key: .token)
        NetworkLayer.shared.fetchHeroes(token: token) { [weak self] allHeroes, error in
            guard let self = self else { return }
            
            if let allHeroes = allHeroes {
                self.heroes = allHeroes
                self.searchHeroes = allHeroes
                LocalDataLayer.shared.save(heroes: allHeroes)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }else{
                print("Error fetching heroes: ", error?.localizedDescription ?? "")
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! CellViewController
        let heroe = searchHeroes[indexPath.row]
        cell.image.setImage(url: heroe.photo)
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
        let heroe = searchHeroes[indexPath.row]
        let detailsView = DetailsViewController()
        detailsView.heroe = heroe
        navigationController?.pushViewController(detailsView, animated: true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        searchHeroes = searchText.isEmpty ? heroes : heroes.filter { heroe in
            return heroe.name.range(of: searchText, options: .caseInsensitive, range: nil,locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    


}