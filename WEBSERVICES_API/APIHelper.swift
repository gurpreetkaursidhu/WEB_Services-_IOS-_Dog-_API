//
//  APIHelper.swift
//  WEBSERVICES_API
//
//  Created by Gurpreet Kaur on 2022-10-29.
//

import Foundation
import UIKit

struct APIHelper{
    // create base URL for fetching dog breeds
    private static let baseURL : String = "https://dog.ceo/api/breeds/"
    
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    //fetch dog list:
    static func fetchdog(callback: @escaping ([String]) -> Void){
        guard
            let url = URL(string: baseURL + "list") // Add the required input in base URL for letting URL know what to fetch
        else{return}
        var newArray = [String]()
        let datarequest = URLRequest(url: url)
        let demandtask = session.dataTask(with: datarequest) {
            data, response, error in
            
            if let data = data {
                do{
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    guard // guard function if there would be any kind of error in fetching data
                        let jsonDictionary = jsonObject as? [AnyHashable: Any],
                        let dogType = jsonDictionary["message"] as? [String]
                    else {preconditionFailure("could not parse JSOn data")}
                    //receive data from jsonDictionary
                    for i in 0..<dogType.count {
                        let item = dogType[i]
                        newArray.append(item)
                    }
                    OperationQueue.main.addOperation {
                        callback(newArray)
                    }
                } catch let er {
                    print("error \(er)")
                }
            } else if let error = error {
                print("error has been found: \(error)")
            } else {
                print("opps, something went wrong")
            }
        }
        demandtask.resume()
    }
    
    static func fetchImage(url: String, callback: @escaping ([String]) -> Void){
   // for the breed images
        guard
            // guard function
            let url = URL(string: url)
        else{return}
        
        let datarequest = URLRequest(url: url)
        let demandtask = session.dataTask(with: datarequest) {
            data, response, error in

            if let data = data {
                do{
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    guard
                        let jsonDictionary = jsonObject as? [AnyHashable: Any],
                        let dogImage = jsonDictionary["message"] as? [String]
                    else {preconditionFailure("could not parse JSOn data")}
      
                    OperationQueue.main.addOperation {
                        callback(dogImage)
                    }
                } catch let er {
                    print("error \(er)")
                }
            } else if let error = error {
                print("error has been found: \(error)")
            } else {
                print("opps something went wrong")
            }
        }
        demandtask.resume()
    }
}

