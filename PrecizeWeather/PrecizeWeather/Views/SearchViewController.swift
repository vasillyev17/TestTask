//
//  SearchViewController.swift
//  PrecizeWeather
//
//  Created by ihor on 06.01.2023.
//

import UIKit

var selectedCity = "'Kyiv','Kyiv','50.4500','30.5236','Ukraine','UA','UKR','Kyyiv', 'Misto','primary','2963199','1804382913'"

class SearchViewController: UIViewController {
    let searchController = UISearchController(searchResultsController: nil)
    
    private var searchTableView = UITableView()
    
    private var cities: [String] = []
    private var filteredCities: [String] = []
    
    var isSearchBarEmpty: Bool {
        return navigationItem.searchController?.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearence()
        setupNavigationBar()
        setupSubviews()
        setupConstraints()
        setupSearchController()
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: Const.tableViewCellIdentifier)
        viewModel.readFromCSV { [weak self] data in
            DispatchQueue.global(qos: .background).async {
                self?.cities = data
                self?.refreshView()
            }
        }
    }
    
    private func refreshView() {
        DispatchQueue.main.async {
            self.searchTableView.reloadData()
        }
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupAppearence() {
        navigationController?.navigationBar.backgroundColor = Const.primaryBlueColor
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Const.backwardImage), style: .plain, target: self, action: #selector(backButtonAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Const.magnifyingGlassImage), style: .plain, target: self, action: #selector(searchButtonAction))
        navigationItem.titleView = navigationItem.searchController?.searchBar
    }
    
    private func setupSubviews() {
        view.addSubview(searchTableView)
    }
    
    private func setupConstraints() {
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                searchTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
                searchTableView.heightAnchor.constraint(equalTo: view.heightAnchor),
                searchTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                searchTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredCities = cities.filter { (city: String) -> Bool in
            return city.lowercased().contains(searchText.lowercased())
        }
        
        searchTableView.reloadData()
    }
    
    @objc private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func searchButtonAction() {
        
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            let indexPath = tableView.indexPathForSelectedRow
            let currentCell = (tableView.cellForRow(at: indexPath ?? IndexPath()) ?? UITableViewCell()) as UITableViewCell
            selectedCity = currentCell.textLabel?.text ?? ""
        }
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = (tableView.cellForRow(at: indexPath ?? IndexPath()) ?? UITableViewCell()) as UITableViewCell
        selectedCity = currentCell.textLabel?.text ?? ""
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCities.count
        }
        
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var city = ""
        if isFiltering {
            city = filteredCities[indexPath.row]
        } else {
            city = cities[indexPath.row]
        }
        cell.textLabel?.text = city
        return cell
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}
