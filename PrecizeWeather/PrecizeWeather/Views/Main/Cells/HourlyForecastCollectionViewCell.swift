//
//  HourlyForecastCollectionViewCell.swift
//  PrecizeWeather
//
//  Created by ihor on 07.01.2023.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    private var timeLabel = UILabel()
    private var temperatureLabel = UILabel()
    private var weatherImageView = UIImageView()
    private var vstackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(time: String, weatherImage: UIImageView, temperature: String) {
        timeLabel.text = time
        weatherImageView = weatherImage
        temperatureLabel.text = temperature
        setupSubviews()
        setupConstraints()
        timeLabel.textColor = .white
        temperatureLabel.textColor = .white
    }
    
    private func setupSubviews() {
        addSubview(timeLabel)
        addSubview(weatherImageView)
        addSubview(temperatureLabel)
    }
    
    private func setupConstraints() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                timeLabel.widthAnchor.constraint(equalToConstant: Const.widthConstraint),
                timeLabel.heightAnchor.constraint(equalToConstant: Const.paddingConstraint),
                timeLabel.topAnchor.constraint(equalTo: topAnchor),
                
                weatherImageView.widthAnchor.constraint(equalToConstant: Const.widthConstraint),
                weatherImageView.heightAnchor.constraint(equalToConstant: Const.widthConstraint),
                weatherImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
                weatherImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(Const.paddingConstraint)),
                
                temperatureLabel.widthAnchor.constraint(equalToConstant: Const.widthConstraint),
                temperatureLabel.heightAnchor.constraint(equalToConstant: Const.paddingConstraint),
                temperatureLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor)
            ])
    }
}

extension HourlyForecastCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
