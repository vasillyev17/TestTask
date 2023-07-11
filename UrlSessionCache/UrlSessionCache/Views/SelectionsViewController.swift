//
//  SelectionsViewController.swift
//  UrlSessionCache
//
//  Created by ihor on 10.07.2023.
//

import UIKit
import CoreData

class SelectionsViewController: UIViewController {
    enum Constants {
        static let rowHeight: CGFloat = 50
        static let cellIdentifier: String = "SelectionTableViewCell"
        static let title: String = "Book Selections"
        static let label: String = "com.example.app.bookResultSynchronization"
    }
    
    private let synchronizationQueue = DispatchQueue(label: Constants.label)
    var listsEntity: Lists
    private var list: ListResult
    private var bookResultEntity: BookResult?
    private var viewModel: SelectionsViewModelProtocol
    
    lazy var tableView : UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.rowHeight = Constants.rowHeight
        tv.separatorStyle = .none
        return tv
    }()
    
    init(viewModel: SelectionsViewModelProtocol, listsEntity: Lists, list: ListResult) {
        self.viewModel = viewModel
        self.listsEntity = listsEntity
        self.list = list
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        navigationItem.title = Constants.title
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        tableView.register(SelectionTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.synchronizationQueue.sync {
            viewModel.decideApplicationFlow(completion: { [weak self] lists in
                self?.listsEntity = lists ?? Lists(status: "", copyright: "", num_results: 0, results: [])
                self?.tableView.reloadData()
            })
        }
    }
}

extension SelectionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listsEntity.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? SelectionTableViewCell else { return UITableViewCell() }
        cell.selection = listsEntity.results[indexPath.row]
        
        return cell
    }
}

extension SelectionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listsArray = listsEntity.results
        let booksViewController = BooksViewController(viewModel: BooksViewModel(), lists: listsEntity, list: listsArray[indexPath.row])
        navigationController?.pushViewController(booksViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
}
