    //
    //  ViewController.swift
    //  Weather
    //
    //  Created by Sudhir Pawar on 20/09/23.
    //



import UIKit



class ViewController: UIViewController {
    
    private let weatherDisplayView = WeatherView()
    private let weatherViewModel = GetWeatherInfoViewModel()
    private let locationViewModel = UserLocationViewModel()
    private let listViewController = ListViewController()
    
    private var userLocation: String?
    private var hasLocationCalledbefore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationViewModel.delegate = self
        listViewController.delegate = self
        locationViewModel.locationManager.requestWhenInUseAuthorization()
        
        if !hasLocationCalledbefore{
            locationViewModel.requestOnTimeLocation()
            hasLocationCalledbefore = true
        }
        
        setupViewModels(userLocation: userLocation)
        setupUI()
    }
    
    @objc private func buttonMethod(){
    print("Clicked")
    setupViewModels(userLocation: "Nashik")
    }
    
    private func setupUI() {
        let button = UIButton()
        button.configuration = .tinted()
        button.configuration?.title = "Search Location"
        button.configuration?.imagePadding = 8
        button.tintColor = .systemGreen
        button.addTarget(self, action: #selector(buttonMethod), for:.touchUpInside  )
        button.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(button)
        
        view.addSubview(weatherDisplayView)
        weatherDisplayView.translatesAutoresizingMaskIntoConstraints = false

        let backgroundImage = UIImage(named: "Day Normal")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = view.bounds
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        backgroundImageView.contentMode = .scaleAspectFill

        NSLayoutConstraint.activate([
            weatherDisplayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherDisplayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
//            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    private func setupViewModels(userLocation: String?) {
        guard let userlocation = userLocation else {
            return
        }
        
        weatherViewModel.getWeather(for: userlocation)
        
        weatherViewModel.weatherDataReceived = { [weak self] weatherData in
            DispatchQueue.main.async {
                self?.weatherDisplayView.update(with: weatherData)
                self?.setupUI()
            }
            
        }
        print("end of method")
        
    }
}


extension ViewController: UserLocationDelegate {
    func didReceivedLocation(userLocationString: String) {
        
        userLocation = userLocationString
//        print("in delegate method implementation --- \(userLocation)")
        setupViewModels(userLocation: userLocation)
    }
    
}

extension ViewController: CustomLocationDelegate{
    func didReceivedCustomLocation(userLocationString: String) {
        
        userLocation = userLocationString
        
        print("in delegate method implementation --- \(userLocation)")
        setupViewModels(userLocation: userLocation)
    }
}
