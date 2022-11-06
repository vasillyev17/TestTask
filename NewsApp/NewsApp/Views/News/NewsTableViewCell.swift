//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by ihor on 03.11.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    var article: Article? {
        didSet {
            picture.imageFromUrl(urlString: article?.image ?? "")
            title.text = article?.title
            text.text = article?.description
        }
    }
    
    var picture: UIImageView = {
        var picture = UIImageView()
        picture.contentMode = .scaleAspectFill
        picture.clipsToBounds = true
        return picture
    }()
    
    var title: UILabel = {
        var text = UILabel()
        text.font = text.font.withSize(22)
        return text
    }()
    
    var text: UILabel = {
        var text = UILabel()
        text.font = text.font.withSize(15)
        text.textColor = .gray
        text.numberOfLines = 0
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: "NewsTableViewCell")
        setupSubviews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(picture)
        contentView.addSubview(title)
        contentView.addSubview(text)
        backgroundColor = .clear
        contentView.backgroundColor = .white
    }
    
    private func setupConstraints() {
        picture.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                picture.heightAnchor.constraint(equalTo: contentView.heightAnchor),
                picture.widthAnchor.constraint(equalTo: picture.heightAnchor),
                picture.leadingAnchor.constraint(equalTo: leadingAnchor),
                
                title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                title.leadingAnchor.constraint(equalTo: picture.trailingAnchor, constant: 10),
                title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                
                text.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
                text.leadingAnchor.constraint(equalTo: picture.trailingAnchor, constant: 10),
                text.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                text.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
    }
}
