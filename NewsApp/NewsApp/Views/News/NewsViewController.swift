//
//  NewsViewController.swift
//  NewsApp
//
//  Created by ihor on 03.11.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class NewsViewController: UIViewController {
    private var viewModel = NewsViewModel()
    private var bag = DisposeBag()
    
    lazy var tableView : UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tv.rowHeight = 150
        tv.separatorStyle = .none
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        viewModel.fetchNews()
        bindTableView()
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationController?.setStatusBar(backgroundColor: .white)
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.titleView = logo
        let shadowView = UIView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.bounds.minY ?? 0) + 40, width: (self.navigationController?.navigationBar.bounds.width) ?? 0, height: 20))
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell else { return }
        let webViewController = WebViewController(links: cell.article?.url ?? "")
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    private func bindTableView() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,Article>> { _, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
            cell.article = item
            return cell
        } titleForHeaderInSection: { dataSorce, sectionIndex in
            return dataSorce[sectionIndex].model
        }
        self.viewModel.users.bind(to: self.tableView.rx.items(dataSource: dataSource)).disposed(by: bag)
    }
}

extension NewsViewController: UITableViewDelegate {}
