//
//  WeatherView.swift
//  Weather
//
//  Created by Sudhir Pawar on 04/10/23.
//

import UIKit

class WeatherView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()

    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35)
        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 70, weight: .regular)
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    private let lastUpdated: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(cityNameLabel)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(lastUpdated)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    func update(with weatherData: WeatherDataModel) {
        cityNameLabel.text = weatherData.name
        let roundedTemperature = Int(round(weatherData.tempC))
        temperatureLabel.text = "\(roundedTemperature)°"
        textLabel.text = "\(weatherData.text) Weather"
        lastUpdated.text = "Last Updated - \(weatherData.lastUpdated)"
    }
}

