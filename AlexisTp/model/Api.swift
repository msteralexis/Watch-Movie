//
//  Api.swift
//  AlexisTp
//
//  Created by  on 05/03/2020.
//  Copyright © 2020 alexis. All rights reserved.
//

import Foundation

import UIKit


/****************
 
    La classe API permet de Gérer les requests effectuer sur les Serveur de  https://developers.themoviedb.org/3/configuration/get-api-configuration
    Ces requêtes recoivent toutes comme paramètre des closure nomé "Completion" Ces closure passer avec le mot clée " Escaping"  de renvoyer le résultat de la requêtes au fonction appelante (Controlleur)
    
    Les Controlleurs apelant les méthodes de la class API doivent passer un certain nombre de paramètre nécésaires au bon fonctionnement de l'API
    Si la requête ce déroule correctement un tableau d'objet de Type "RequestResponse"  es renvoyer. Un control des données renvoyer par l'API es nécésaires par les controlleur avant d'être utilises dans les Views.

****************/


struct Api {

    
    let token:String = "e54b55bff755194b72481100d46490d0" // Un token es nécésaires pour interroger cette API
    let session = URLSession.shared // on à besoin de cette objet pour généré un ojbet URL exploitable pour la requête
    
    
    
    /// Fonction servant à nous renvoyer une liste de fils selon une catéggories
    /// - Parameters:
    ///   - idCategory: ID de la categorie selectioner par l'utilisateur
    ///   - completion: Variable de types fonction qui prend en paramètre un tableau d'objet Correspondant à nos films. Ces objets seront traiter en fonctioner des données que l'on souaite conserver
    func requestListMoviesCategory(idCategory: String, completion: @escaping ((_ movies: [RequestReceptionMovie]  ) -> Void )) { // @escaping lors de requête asymchrome cette indication permet de récupéré les donénes même après le return de la fonction
       
        
        //on Si notre URL es bon
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(token)&language=fr-FR&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(idCategory)" ) else {
            return
        }
        
        URLSession.shared.dataTask(with: url)  { (data, response, error) in
            // si il y à une erreur lors de la reception de la requêtes alors on sort prématurement du programme
            guard error == nil else {
                print("error")
                return
            }
                                        
            
            // si j'ai bien une donnée alors je convertir le JSON recut vec un objet DECODE
            if let data = data {
                do {
                    let listResponseRequest = try JSONDecoder().decode(RequestReceptionListMovie.self, from: data)
                    completion(listResponseRequest.listMovies ?? [])
                } catch {
                    print(error)
                }
            }
            return
            
        }.resume()
    }
    
    

    /// Requete recevant un URL d'une image pour l'Uploder selon les besoin.
    /// - Parameters:
    ///   - url:
    ///   - completionHandler: Variable de types fonction qui prend en paramètre un tableau d'objet Correspondant à nos films. Ces objets seront traiter en fonctioner des données que l'on souaite conserver
    func dowloadImage( url: URL, completionHandler: @escaping (_ image: UIImage, _ path: String) ->Void ){
          URLSession.shared.dataTask(with: url ) { (data,response, error ) in
              guard error == nil,
              let data = data,
                  let downloadImage = UIImage(data: data) else {
                      return
              }
       
              DispatchQueue.main.async {
                completionHandler( downloadImage, url.absoluteString)
              }
              
          }.resume()
      }
    
    
    

    
    /// Requête permettant d'obtenir les détails d'un films avec sont ID
    /// - Parameters:
    ///   - url: <#url description#>
    ///   - completion:Variable de types fonction qui prend en paramètre un tableau d'objet detils du fils
    func detailsMovie( url: URL, completion: @escaping (_ detailsMovie: RequestReceptionDetailsMovie ) ->Void ){
      
        URLSession.shared.dataTask(with: url ) { (data,response, error ) in
            guard error == nil else {
                print("error")
                return
            }
            
            // si j'ai bien une donnée alors
            if let data = data {
                do {
                    let detailsMovie = try JSONDecoder().decode(RequestReceptionDetailsMovie.self, from: data)
                    completion(detailsMovie)
                } catch {
                    print(error)
                }
            }
            return
          }.resume()
      }
    
    
    
    /// Otenir la liste des Genres de films
    /// - Parameter completion: <#completion description#>
    func listgenres( completion: @escaping (_ genresMovies: [RequestReceptionGenreMovie] ) -> Void ) {
        
            guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(token)&language=fr-FR" ) else {
                return
            }
         
        URLSession.shared.dataTask(with: url ) { (data, response, error ) in
               guard error == nil else {
                   print("error")
                   return
               }
           
               // si j'ai bien une donnée alors
               if let data = data {
                   do {
                       let listGenresMoviees = try JSONDecoder().decode(RequestReceptionListGenreMovie.self, from: data)
      
                        completion(listGenresMoviees.listGenresMovies ?? [])
                   } catch {
                       print(error)
                   }
 
               }
              // return
             }.resume()
         }
    
    
    
    
    
    
    
    
    
    
}



