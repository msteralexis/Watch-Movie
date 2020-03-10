//
//  ViewController.swift
//  AlexisTp
//
//  Created by  on 03/03/2020.
//  Copyright © 2020 alexis. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    // When "ListViewsControlleur" calls this controller, it is started to implement the "Idmovie" variable to get the details of our films.
    var idMovie: String? = nil
    
  
    // All the elements of our View which will have to be modified
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categorieLabel: UILabel!
    @IBOutlet weak var soustitreLabel: UILabel!
    @IBOutlet weak var durerLabel: UILabel!
    @IBOutlet weak var dateSortieLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var afficheLabel: UIImageView!
    @IBOutlet weak var descriptifLabel: UILabel!
    
   
    // Fonction chargeant la Vue
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        /// Closure of types function which takes as a parameter a Films and and will be used to retrieve our films (see details of asymmetrical requests in API class)
        let completions = { (_ movies: Movie) ->  Void in
            
            // we perform a task on the Main Thread thanks to DispatchQueu
            DispatchQueue.main.async {
                
                // we modify the elements of our views with the information of our requests
                self.titleLabel.text = movies.title
                self.soustitreLabel.text = movies.underTitle
                self.categorieLabel.text = "Action"
                self.dateSortieLabel.text = movies.dateRelease
                // Ojbet regroupant l'ensemble des requpetes effectuer auprès de l'API (voir explicatiosn code Class API)
                let api: Api = Api()
                
                if let  urlAffiche = movies.affiche,  let urlImage  = URL(string: "https://image.tmdb.org/t/p/w300\(urlAffiche)" ){
                    api.dowloadImage(url: urlImage ) { (image, path) in
                        self.imageLabel.image = image
                    }
                }
                
                if let  urlPoster = movies.poster,  let urlImage  = URL(string: "https://image.tmdb.org/t/p/w300\(urlPoster)" ){
                    api.dowloadImage(url: urlImage ) { (image, path) in
                        self.afficheLabel.image  = image
                    }
                }
            }
        }
        
        // If we have a Film ID then we do the necessary search
        if let id = idMovie  {
            searchMovie(id: id, completions: completions)
        }
    }

    

    
    
    /// Function allowing to get the details of a film.
    /// - Parameters:
    ///   - id: Id Movie
    ///   - completions: of function types taking as parameter a Movie type object
    func searchMovie(id: String, completions: @escaping  (_ movies: Movie) -> Void){
        if let urlDetailsMovie = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=e54b55bff755194b72481100d46490d0&language=fr-FR" ) {
            let api: Api = Api()// classe abritant nos requête HTTP menant vers l'API
            
            
            api.detailsMovie(url: urlDetailsMovie ) { (movieReception) in
                
                // we test the values returned by the API. An intermediate object links the API data to the data used by the VIEWS
                guard let resumeMovie = movieReception.resume, // guard let allows to end the instruction if the elements are not good during Our Unwrap
                    let titleMovie = movieReception.title,
                    let dateReleaseMovie = movieReception.dateRelease
                    else {
                        return
                    }
                            
                // s the data is good then we create our Movie object used in our Views
                let movie: Movie = Movie(title: titleMovie,
                    dateRelease: dateReleaseMovie,
                    resume: resumeMovie,
                    underTitle: movieReception.underTitle,
                    categorie: ["action","Science-Fiction"] ,
                    affiche: movieReception.affiche,
                    poster: movieReception.poster)

                completions(movie) //we pass the value to our closure to retrieve our object.
                                          
            }
        }
    }
    
    
    

    
    
    /// When we click on our button we display the annocne strip of the films
    @IBAction func bandeAnnonceAction(_ sender: UIButton) {
        if let url = URL(string: "https://www.youtube.com/watch?v=QAEkuVgt6Aw") {
            UIApplication.shared.open(url)
        }
    }
    
 
   
 
    
}


