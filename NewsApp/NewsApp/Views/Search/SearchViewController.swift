//
//  SearchViewController.swift
//  NewsApp
//
//  Created by ihor on 04.11.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Alamofire

class SearchViewController: UIViewController {
    private var disposeBag = DisposeBag()
    
    lazy var tableView : UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tv.rowHeight = 150
        tv.separatorStyle = .none
        tv.allowsSelection = true
        tv.isUserInteractionEnabled = true
        return tv
    }()
    
    var logo: UILabel = {
        let lbl = UILabel()
        lbl.text = "Logo"
        lbl.font = lbl.font.withSize(30)
        lbl.font = lbl.font.boldItalic()
        lbl.textColor = .orange
        return lbl
    }()
    
    var navStackView = UIStackView()
    let searchBar = UISearchBar()
    
    let filterButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "filter"), for: .normal)
        return btn
    }()
    
    let sortButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "sort"), for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.sizeToFit()
        tableView.delegate = self
        rxSetup()
        setupAppearence()
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.backgroundColor = .white
        let shadowView = UIView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.minY ?? 0) + 44, width: (self.navigationController?.navigationBar.bounds.width) ?? 0, height: 20))
        self.navigationController?.navigationBar.insertSubview(shadowView, at: 1)
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: shadowView.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        shadowLayer.shadowOpacity = 0.1
        shadowLayer.shadowRadius = 2
        shadowView.layer.insertSublayer(shadowLayer, at: 0)
        navigationController?.setStatusBar(backgroundColor: .white)
    }
    
    private func setupAppearence() {
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: filterButton),  UIBarButtonItem(customView: sortButton)]
        view.backgroundColor = .white
    }
    
    private func rxSetup() {
      let results = searchBar.rx.text.orEmpty
            .throttle(RxTimeInterval.milliseconds(30), scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .flatMapLatest { query -> Observable<[Article]> in
          if query.isEmpty {
            return .just([Article(title: "", description: "", content: "", url: "", image: "", publishedAt: "", source: Source(name: "", url: ""))])
          }
          return ApiController.shared.search(search: query)
                .catchAndReturn([Article(title: "", description: "", content: "", url: "", image: "", publishedAt: "", source: Source(name: "", url: ""))])
        }
        .observe(on: MainScheduler.instance)

      results
        .bind(to: tableView.rx.items(cellIdentifier: "NewsTableViewCell",
                                     cellType: NewsTableViewCell.self)) {
            (index, nflPlayerStats: Article, cell: NewsTableViewCell) in
            
            cell.article = nflPlayerStats
            cell.selectionStyle = .default
        }
        .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell else { return }
        let webViewController = WebViewController(links: cell.article?.url ?? "")
        navigationController?.pushViewController(webViewController, animated: true)
    }
}

extension SearchViewController: UITableViewDelegate {}
