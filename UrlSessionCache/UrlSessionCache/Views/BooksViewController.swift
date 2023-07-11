//
//  BooksViewController.swift
//  UrlSessionCache
//
//  Created by ihor on 10.07.2023.
//

import UIKit
import CoreData

class BooksViewController: UIViewController {
    enum Constants {
        static let rowHeight: CGFloat = 120
        static let cellIdentifier: String = "BookTableViewCell"
        static let title: String = "Books"
        static let label: String = "com.example.app.bookResultSynchronization"
    }
    
    private let synchronizationQueue = DispatchQueue(label: Constants.label)
    
    var bookResultEntity: BookResult?
    private var viewModel: BooksViewModelProtocol
    private var list: ListResult
    private var lists: Lists
    
    lazy var tableView : UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.rowHeight = Constants.rowHeight
        tv.separatorStyle = .singleLine
        return tv
    }()
    
    init(viewModel: BooksViewModelProtocol, lists: Lists, list: ListResult) {
        self.list = list
        self.viewModel = viewModel
        self.lists = lists
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .white
        navigationItem.title = bookResultEntity?.display_name
        view.addSubview(tableView)
        navigationItem.title = Constants.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.synchronizationQueue.sync {
            viewModel.decideApplicationFlow(list: list, lists: lists, completion: { [weak self] bookResult in
                self?.bookResultEntity = bookResult
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            })
        }
    }
}

extension BooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookResultEntity?.books.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        cell.book = bookResultEntity?.books[indexPath.row]
        return cell
    }
}

extension BooksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = bookResultEntity?.books[indexPath.row]
        let webViewController = WebViewController(links: selectedBook?.amazon_product_url ?? "")
        navigationController?.pushViewController(webViewController, animated: true)
    }
}
