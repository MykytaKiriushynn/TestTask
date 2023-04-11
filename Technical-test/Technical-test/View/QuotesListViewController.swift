//
//  QuotesListViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

class QuoteListViewController: UIViewController {
    private let dataManager = DataManager()
    var quotes: [Quote] = []
    var favouriteQuotes: [Quote] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "QuoteTableViewCell", bundle: nil), forCellReuseIdentifier: "QuoteTableViewCell")
        setupUI()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavouriteQuotes()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Quotes"
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func fetchData() {
        dataManager.fetchQuotes { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let quotes):
                    self?.quotes = quotes
                    self?.tableView.reloadData()
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func fetchFavouriteQuotes() {
        self.favouriteQuotes = dataManager.loadFavoriteQuotes()
        self.tableView.reloadData()
    }
    
}

extension QuoteListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let quote = quotes[indexPath.row]
        let quoteDetailsViewController = QuoteDetailsViewController(quote: quote)
        navigationController?.pushViewController(quoteDetailsViewController, animated: true)
    }
}

extension QuoteListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteTableViewCell", for: indexPath) as! QuoteTableViewCell
        var quote = quotes[indexPath.row]
        if favouriteQuotes.contains(where: { $0 == quote}) {
            quote.isFavourite = true
        }
        cell.configure(with: quote)
        return cell
    }
}
