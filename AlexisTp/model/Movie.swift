//
//  Movie.swift
//  AlexisTp
//
//  Created by  on 03/03/2020.
//  Copyright © 2020 alexis. All rights reserved.
//

import Foundation
import UIKit

/****************
 
  269/5000
    In this class you will find the necessary Structures concerning films
         These strcutres are used for displaying data in the applications.
         Structures contained in the ReceptionsRequest file are temporary with the JSON received from the server.
 ****************/

// Structure Showing a film with the minimum of information
struct PresentationMovie{
    let idMovie :Int
    let title :String
    let resume : String
    let dateRelease : String?
    let poster : String?
}

// Structure representing the details of a film
struct Movie{
    let title : String
    let dateRelease : String
    let resume : String
    let underTitle : String?
    let categorie : [String]?
    let affiche : String?
    let poster : String?
    
    
}

struct GenreMovie{
    let idGenre: String
    let nomGenre: String
}
