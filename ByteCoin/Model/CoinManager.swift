//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoinRate(_ coinManager: CoinManager, data: CoinData)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let apiKey = "4F5EF984-9965-4039-88D5-596FB5FA2ABC"
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    
    
    func getCoinPrice(for currency: String){
        let url = URL(string:"\(baseURL)/\(currency)?apikey=\(apiKey)")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
           // print(String(data: data, encoding: .utf8)!)
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CoinData.self, from: data)
                self.delegate?.didUpdateCoinRate(self, data: decodedData)
            } catch {
                print(error.localizedDescription)
            }
            
        }

        task.resume()
    }
    
}
