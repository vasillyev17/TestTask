//
//  MainViewController.swift
//  PrecizeWeather
//
//  Created by ihor on 06.01.2023.
//

import UIKit

enum Const {
    static let primaryBlueColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
    static let lightBlueColor = UIColor(red: 90/255, green: 159/255, blue: 240/255, alpha: 1)
    static let celsiusSymbol = "°C"
    static let percentSymbol = "%"
    static let speedSymbol = "м/с"
    static let cellIdentifier = "HourlyCell"
    static let tableViewCellIdentifier = "SearchCell"
    static let magnifyingGlassImage = "magnifyingglass"
    static let backwardImage = "chevron.backward"
    static let searchButton = "location.viewfinder"
    static let defaultCity = "'Kyiv','Kyiv','50.4500','30.5236','Ukraine','UA','UKR','Kyyiv', 'Misto','primary','2963199','1804382913'"
    static let bigConstraint: CGFloat = 200
    static let smallConstraint: CGFloat = 50
    static let halfScreenMultiplier = 0.5
    static let paddingConstraint: CGFloat = 20
    static let widthConstraint: CGFloat = 90
}

class MainViewController: UIViewController {
    private var selectedDay = 0 {
        didSet {
            hourlyForecastArray = []
            createHourlyArray()
        }
    }
    
    private var hourlyForecastArray: [DailyForecast] = []
    private var viewModel: MainViewModel
    private var forecast: Forecast?
    private var weekForecastItems: [DailyForecast] = []
    private var weekDays: [String] = []
    private var collectionViewSize = 0
    
    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    private var sharedConstraints: [NSLayoutConstraint] = []
    
    
    private var topView = UIView()
    private var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()
    
    private var weekForecastView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private var dateLabel = UILabel()
    private var iconImageView = UIImageView()
    private var temperatureLabel = UILabel()
    private var humidityLabel = UILabel()
    private var windLabel = UILabel()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weekForecastView.delegate = self
        weekForecastView.dataSource = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: Const.cellIdentifier)
        setupAppearence()
        setupSubviews()
        setupNavigationBar()
        setupConstraints()
        NSLayoutConstraint.activate(sharedConstraints)
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var coordinates = ""
        if !selectedCity.isEmpty {
            coordinates = selectedCity
        } else {
            coordinates = Const.defaultCity
        }
        
        let split = coordinates.split(separator: ",")
        viewModel.loadWeather(lat: String(split[2]), lng: String(split[3]), callback: { [weak self] forecast in
            DispatchQueue.main.async {
                self?.forecast = forecast
                self?.refreshView()
                self?.weekForecastView.reloadData()
            }
        })
    }
    
    private func refreshView() {
        navigationItem.leftBarButtonItem?.title = "🔽 \(forecast?.city.name ?? "")"
        iconImageView.image = UIImage(named: forecast?.list[1].weather[0].icon ?? "")
        setupLabels()
        filterWeekForecastItems()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(aimButtonAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Const.searchButton), style: .plain, target: self, action: #selector(aimButtonAction))
    }
    
    private func setupAppearence() {
        view.backgroundColor = .white
        topView.backgroundColor = Const.primaryBlueColor
        collectionView.backgroundColor = Const.lightBlueColor
        formatDate()
    }
    
    private func filterWeekForecastItems() {
        guard let list = forecast?.list else { return }
        for item in list {
            let date = item.dt_txt
            let prefix = date.prefix(10)
            let suffix = "\(prefix.suffix(2))"
            if !weekDays.contains(suffix) {
                weekDays.append(suffix)
                weekForecastItems.append(item)
            }
        }
    }
    
    private func createHourlyArray() {
        let dayToForecastByHours = weekForecastItems[selectedDay]
        guard let list = forecast?.list else { return }
        for item in list {
            if isEqualDates(dayToForecast: dayToForecastByHours.dt_txt, dayToCompare: item.dt_txt) {
                hourlyForecastArray.append(item)
            }
        }
        weekDays = []
    }
    
    private func isEqualDates(dayToForecast: String, dayToCompare: String) -> Bool {
        let prefixForecast = dayToForecast.prefix(10)
        let suffixForecast = "\(prefixForecast.suffix(2))"
        let prefixCompare = dayToCompare.prefix(10)
        let suffixCompare = "\(prefixCompare.suffix(2))"
        return suffixForecast == suffixCompare
    }
    
    private func setupLabels() {
        dateLabel.textColor = .white
        temperatureLabel.text = "🌡️ \(forecast?.list[0].main.temp_max ?? 0.0) / \(forecast?.list[0].main.temp_min ?? 0.0) \(Const.celsiusSymbol)"
        temperatureLabel.textColor = .white
        humidityLabel.text = "💧 \(forecast?.list[0].main.humidity ?? 0) \(Const.percentSymbol)"
        humidityLabel.textColor = .white
        windLabel.text = "💨 \(forecast?.list[0].wind.speed ?? 0) \(Const.speedSymbol)"
        windLabel.textColor = .white
    }
    
    private func formatDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfTheWeekString = dateFormatter.string(from: date)
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "LLLL"
        let monthString = monthFormatter.string(from: date)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        let dayOfMonth = components.day
        dateLabel.text = "\(dayOfTheWeekString), \(dayOfMonth ?? 0) \(monthString)"
    }
    
    private func setupSubviews() {
        infoStackView.addArrangedSubview(temperatureLabel)
        infoStackView.addArrangedSubview(humidityLabel)
        infoStackView.addArrangedSubview(windLabel)
        
        topView.addSubview(dateLabel)
        topView.addSubview(iconImageView)
        topView.addSubview(infoStackView)
        
        view.addSubview(topView)
        view.addSubview(collectionView)
        view.addSubview(weekForecastView)
    }
    
    private func setupConstraints() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        weekForecastView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        sharedConstraints.append(contentsOf: [
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 320),
            
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: Const.bigConstraint),
            
            weekForecastView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            weekForecastView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weekForecastView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weekForecastView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 100),
            dateLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: Const.paddingConstraint),
            
            iconImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: Const.bigConstraint),
            iconImageView.heightAnchor.constraint(equalToConstant: Const.bigConstraint),
            
            infoStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Const.smallConstraint),
            infoStackView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -(Const.smallConstraint))
        ])
        
        regularConstraints.append(contentsOf: [
            topView.widthAnchor.constraint(equalToConstant: Const.bigConstraint),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: infoStackView.leadingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: Const.paddingConstraint),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Const.halfScreenMultiplier),
            
            weekForecastView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            weekForecastView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weekForecastView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Const.halfScreenMultiplier)
            
        ])
        
        compactConstraints.append(contentsOf: [
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 320),
            
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: Const.bigConstraint),
            
            weekForecastView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            weekForecastView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weekForecastView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weekForecastView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 100),
            dateLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: Const.paddingConstraint),
            
            iconImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: Const.bigConstraint),
            iconImageView.heightAnchor.constraint(equalToConstant: Const.bigConstraint),
            
            infoStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Const.smallConstraint),
            infoStackView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -(Const.smallConstraint))
        ])
    }
    
    @objc private func aimButtonAction() {
        navigationController?.pushViewController(SearchViewController(viewModel: SearchViewModel()), animated: true)
    }
    
    func layoutTrait(traitCollection:UITraitCollection) {
        if (!sharedConstraints[0].isActive) {
            NSLayoutConstraint.activate(sharedConstraints)
        }
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layoutTrait(traitCollection: traitCollection)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDay = indexPath.row
        collectionViewSize = hourlyForecastArray.count
        collectionView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekForecastItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let date =  weekForecastItems[indexPath.row].dt_txt.prefix(10)
        cell.textLabel?.text = "\(date)       \(weekForecastItems[indexPath.row].main.temp_max) / \(weekForecastItems[indexPath.row].main.temp_min) \(Const.celsiusSymbol)"
        cell.textLabel?.textAlignment = .center
        cell.imageView?.image = UIImage(named: "\(weekForecastItems[indexPath.row].weather[0].icon)")
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 90, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image = UIImageView(image: UIImage(named: hourlyForecastArray[indexPath.row].weather[0].icon))
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.cellIdentifier, for: indexPath) as! HourlyForecastCollectionViewCell
        let suffix = hourlyForecastArray[indexPath.row].dt_txt.suffix(8)
        let time = suffix.prefix(5)
        cell.setupCell(time: String(time),
                       weatherImage: image,
                       temperature: "\(hourlyForecastArray[indexPath.row].main.temp) \(Const.celsiusSymbol)")
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate { }
