//
//  SelectionTableViewCell.swift
//  UrlSessionCache
//
//  Created by ihor on 11.07.2023.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {
    enum Constants {
        static let regularFont: CGFloat = 15
        static let cellIdentifier: String = "SelectionTableViewCell"
        static let cellPadding: CGFloat = 5
        static let sidePadding: CGFloat = 8
    }
    
    var selection: ListResult? {
        didSet {
            title.text = selection?.display_name
            text.text = selection?.newest_published_date
        }
    }
    
    var title: UILabel = {
        var text = UILabel()
        text.font = text.font.withSize(Constants.regularFont)
        return text
    }()
    
    var text: UILabel = {
        var text = UILabel()
        text.font = text.font.withSize(Constants.regularFont)
        text.textColor = .lightGray
        text.numberOfLines = 0
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: Constants.cellIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: Constants.cellPadding, left: Constants.cellPadding, bottom: Constants.cellPadding, right: Constants.cellPadding))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(title)
        contentView.addSubview(text)
        backgroundColor = .clear
        contentView.backgroundColor = .white
    }
    
    private func setupConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.cellPadding),
                title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.sidePadding),
                
                text.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.cellPadding),
                text.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.sidePadding),
            ])
    }
}
