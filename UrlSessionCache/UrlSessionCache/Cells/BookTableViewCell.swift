//
//  BookTableViewCell.swift
//  NYTBooks
//
//  Created by ihor on 04.07.2023.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    enum Constants {
        static let titleFont: CGFloat = 14
        static let regularFont: CGFloat = 12
        static let cellIdentifier: String = "BookTableViewCell"
        static let cellPadding: CGFloat = 5
    }
    
    var book: Book? {
        didSet {
            title.text = book?.title
            text.text = book?.description
            author.text = book?.author
        }
    }
    
    var title: UILabel = {
        var text = UILabel()
        text.font = UIFont.boldSystemFont(ofSize: Constants.titleFont)
        return text
    }()
    
    var text: UILabel = {
        var text = UILabel()
        text.font = text.font.withSize(Constants.regularFont)
        text.textColor = .lightGray
        text.numberOfLines = 0
        return text
    }()
    
    var author: UILabel = {
        var text = UILabel()
        text.font = UIFont.boldSystemFont(ofSize: Constants.regularFont)
        text.textColor = .gray
        text.numberOfLines = 0
        return text
    }()
    
    var vstack: UIStackView = {
        var stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 5
        return stackview
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: Constants.cellIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        vstack.addArrangedSubview(title)
        vstack.addArrangedSubview(author)
        vstack.addArrangedSubview(text)
        
        contentView.addSubview(vstack)
        backgroundColor = .clear
        contentView.backgroundColor = .white
    }
    
    private func setupConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        author.translatesAutoresizingMaskIntoConstraints = false
        vstack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                vstack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.cellPadding),
                vstack.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
                vstack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ])
    }
}
