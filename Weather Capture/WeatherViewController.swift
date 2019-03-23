//
//  ViewController.swift
//  WeatherApp
//
//
//
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import INTULocationManager



class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
  

    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "2de96d0439a44790decb0c02943dea02"
    
    let fahrenheitValue = 32
    var switchIsOn: Bool = true
    
    
   
    
    //Declare instance variables
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    let weatherDataInfoModel = WeatherDataInfoModel()
    let photoWeatherTipsModel = PhotoWeatherTips()
  
    
  //weatherInfoTextField
    
    //IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var weatherInfoTextField: UILabel!
    @IBOutlet weak var weatherDetailLabel: UILabel!
    @IBOutlet weak var weatherTipsLabel: UILabel!
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    @IBOutlet weak var sunsetTimeLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    
    var useFahrenheit: Bool {
        return UserDefaults.standard.bool(forKey: Constants.useFahreneitKey)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Location manager setup
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        
        
        
    }
    
    
    
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { 
            response in
            if response.result.isSuccess {
                
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                
                print(weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
                
                ///////////////////here
                self.updateWeatherInfoData(json: weatherJSON)
                print("got weather details")
                //////
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
        
    }
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    /////////////////////////////////////////////////
    
   
    //////////////////////////////////////////////////
    
    
    //updateWeatherData method
    
    
    
    
    func updateWeatherData(json : JSON) {
        
        if let tempResult = json["main"]["temp"].double {
            
            
            weatherDataModel.temperature = useFahrenheit ? Int(((tempResult - 273.15) * 1.8)  + 32) : Int(tempResult - 273.15)
            
            weatherDataModel.city = json["name"].stringValue
            
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            updateUIWithWeatherData()
            
            
        } else {
            
            cityLabel.text = "Weather Unavailable"
            
        }
        
    }
    
    
    //get temp description for weather info label(TEXTVIEW)
    
    func updateWeatherInfoData(json: JSON) {
        
        if let tempInfo = json["main"]["temp"].double {
            
            weatherDataInfoModel.temperature = Int(tempInfo - 273.15 * 1.8)  + 32
            
            weatherDataInfoModel.description = json["weather"][0]["description"].stringValue.uppercased()
            
            weatherDataInfoModel.mainDescription = json["weather"][0]["main"].stringValue
            
            weatherDataInfoModel.humidity = json["main"]["humidity"].intValue
            
            weatherDataInfoModel.visibility = json["visibility"].intValue
            
            weatherDataInfoModel.pressure = json["main"]["pressure"].intValue
            
            
            //gets SunRise Time from API
            weatherDataInfoModel.sunriseTime = json["sys"]["sunrise"].doubleValue
            
//            change sunrise time to 12 hour time
            let time = weatherDataInfoModel.sunriseTime
            let sunriseUnixHour = Date(timeIntervalSince1970: time)
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            sunriseTimeLabel.text =  formatter.string(from: sunriseUnixHour)
            
            //Gets SunSet Time from API
            weatherDataInfoModel.sunsetTime = json["sys"]["sunset"].doubleValue
            
            let time1 = weatherDataInfoModel.sunsetTime
            let sunsetUnixHour = Date(timeIntervalSince1970: time1)
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "h:mm a"
            sunsetTimeLabel.text = formatter1.string(from: sunsetUnixHour)
            
     
            
            
            updateUIWithWeatherDataInfo()
            updateUIWithWeatherDataDetails()
            
            
        } else {
            weatherInfoTextField.text = "Information Unavailable, check connection"
        }
        
    }
    
        
        //MARK: - UI Updates
        /***************************************************************/
    
    
        //updateUIWithWeatherData method
        
        func updateUIWithWeatherData() {
            
            //change sunset time to 12  time
            
            cityLabel.text = weatherDataModel.city
            temperatureLabel.text = "\(weatherDataModel.temperature)°"
            weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
            
            
        }
    
    
    // weatherInfoTextField
    func updateUIWithWeatherDataInfo() {
        weatherInfoTextField.text = weatherDataInfoModel.mainDescription
        
    }
    
    //weather details Label
    func updateUIWithWeatherDataDetails() {
        weatherDetailLabel.text = "\(weatherDataInfoModel.description)"
        
        photoWeatherTipsModel.photoTip = photoWeatherTipsModel.getPhotoTip(condition: weatherDataModel.condition)
        
        weatherTipsLabel.text = "\(photoWeatherTipsModel.photoTip)"
        
    }
    
        
        //MARK: - Location Manager Delegate Methods
        /***************************************************************/
        
        
        //didUpdateLocations method
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations[locations.count - 1]
            if location.horizontalAccuracy > 0 {
                
                self.locationManager.stopUpdatingLocation()
                
                print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
                
                let latitude = String(location.coordinate.latitude)
                let longitude = String(location.coordinate.longitude)
                
                let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
                
                getWeatherData(url: WEATHER_URL, parameters: params)
                
              
            }
        }
        
        
        //didFailWithError method
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
            cityLabel.text = "Location Unavailable"
        }

        
        //MARK: - Change City Delegate methods
        /***************************************************************/
        
        
        //userEnteredANewCityName Delegate method
        
        func userEnteredANewCityName(city: String) {
            let params: [String : String] = ["q": city, "appid": APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
        
    
        //PrepareForSegue Method
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "changeCityName" {
                
                let destinationVC = segue.destination as! ChangeCityViewController
                
                
                destinationVC.delegate = self
                
            }
            
        }
    
    
    //get user current location button 
    func userLocation() {
        locationManager.startUpdatingLocation()
    }
    
}
