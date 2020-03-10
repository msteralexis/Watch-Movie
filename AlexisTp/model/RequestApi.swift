//
//  RequestApi.swift
//  AlexisTp
//
//  Created by  on 05/03/2020.
//  Copyright © 2020 alexis. All rights reserved.
//

import Foundation
import UIKit


struct Api {


    let url :String
    
    func APIRequest() {
    let url :String = "https://api.themoviedb.org/3/movie/550?api_key=e54b55bff755194b72481100d46490d0"
              
                  let request = NSMutableURLRequest(url: URL(string: url)!)
    
                  let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) {data, response, error in
                      if (error != nil) {
                          print(error!.localizedDescription) // On indique dans la console ou est le problème dans la requête
                      }
                    
                    
                      if let httpStatus = response as? HTTPURLResponse , httpStatus.statusCode != 200 {
                          print("statusCode devrait être de 200, mais il est de \(httpStatus.statusCode)")
                          print("réponse = \(response)") // On affiche dans la console si le serveur ne nous renvoit pas un code de 200 qui est le code normal
                      }
              
                    
                      let responseAPI = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                      print("responseString = \(responseAPI)") // Affiche dans la console la réponse de l'API
              
                    
                      if error == nil {
                          print("il y a une erreur il y a une erreuril y a une erreuril y a une erreuril y a une erreuril y a une erreuril y a une erreuril y a une erreuril y a une erreuril y a une erreuril y a une erreuril y a une erreuril y a une erreuril y a une erreuril y a une erreuril y a une erreur")
                      }
                  }
                  requestAPI.resume()
        
    }
    
}
       
