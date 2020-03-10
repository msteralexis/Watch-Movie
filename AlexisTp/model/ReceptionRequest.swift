//
//  ReceptionRequest.swift
//  AlexisTp
//
//  Created by  on 05/03/2020.
//  Copyright © 2020 alexis. All rights reserved.
//

import Foundation


/****************
 
 In this class you will find the Structures necessary for receiving Requests made in the API class.
   All fields are not mandatory because we do not know what we send the server
   These requests are then processed in Controllers then transformed into corresponding objects
  
   The particularity of these objects is that they are of Decodable types so they are used to convert the reception of HHTP requests (json) into an object.
   it will then result in the fruti of a treatment (we test the data it contains in the controller, the variables are therefore all optional)
 
 ****************/

// Obtain a list of objects detailing a film
struct RequestReceptionListMovie: Decodable {
    let listMovies: [RequestReceptionMovie]?
    
    // faire correspondre les elements de notre
    private enum CodingKeys: String, CodingKey {
        case listMovies = "results"
    }
}


// Structure allowing to decode the JSON during the reception of the requests to obtain a representation of a film
struct RequestReceptionMovie: Decodable {
    let title: String?
    let overview: String?
    let release_date: String?
    let poster: String?
    let idMovie: Int?
    
    // all the fields of the structure are not identical with the JSON recut (we therefore come to answer this problem with an ENUM)
    private enum CodingKeys: String, CodingKey {
        case poster = "poster_path"
        case title
        case overview
        case release_date
        case idMovie = "id"
    }
}


// Structure allowing to decode the JSON Concerning the details of a film.
struct RequestReceptionDetailsMovie: Decodable {
    
    let title : String?
    let affiche : String?
    let poster : String?
    let resume : String?
    let underTitle : String?
    let dateRelease : String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case affiche = "backdrop_path"
        case poster = "poster_path"
        case resume = "overview"
        case underTitle = "tagline"
        case dateRelease = "release_date"
        
    }
}






// Obtain a list of objects detailing a film
struct RequestReceptionListGenreMovie: Decodable {
    let listGenresMovies: [RequestReceptionGenreMovie]?
    
    private enum CodingKeys: String, CodingKey {
        case listGenresMovies = "genres"
    }
}


struct RequestReceptionGenreMovie: Decodable{
    let idGenre: Int?
    let nomGenre: String?
    
    private enum CodingKeys: String, CodingKey {
        case idGenre = "id"
        case nomGenre =  "name"
    }
}


