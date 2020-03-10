//
//  ListViewsController.swift
//  AlexisTp
//
//  Created by  on 04/03/2020.
//  Copyright © 2020 alexis. All rights reserved.
//

import UIKit

class ListViewsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // UITableViewDelegate = it is the tableViews which delegates behaviors to the controller
    // UITableViewDataSource = Protocol which allows the controller to give data (TabesViewsCell) to the TableViews
        
    // When loading our controller we need the ID of the selected category to get the threads to link to this one
     var idCategories: String? = nil
    
    // our TableViews variable corresponding to our TableViews graphic element
    @IBOutlet weak var tableViews: UITableView!
    
    // By default we define the name of our cells
    let cellId :String = "cellulesMovie"
    
    // Table storing our films
    var movies: [PresentationMovie] = []
    
    // The API class contains all the functions allowing HHTP requests
    let api: Api = Api()
    
    @IBOutlet weak var imageView: UIImageView!

    
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
           // On créer une dépendance ici la "tableViews" vas dependre de ce controller
           tableViews.delegate = self
           tableViews.dataSource = self
           
           // the height of the line is done automatically according to the Cointresses set by the cells
           tableViews.rowHeight = UITableView.automaticDimension
           
           // We instantiate our TablesViews object
           tableViews.register( UINib(nibName: "ListTableViewCell" , bundle: nil ), forCellReuseIdentifier: cellId)
           
            if let id = idCategories  {
                // call to the function e declaring a closure in a variable then by calling the function
                let completion = { (_ movies: [PresentationMovie] ) ->  Void in
                    self.movies = movies
                    DispatchQueue.main.async {
                        self.tableViews.reloadData()
                    }
                }
                listPresentationMovieCategory(idCategory: id, completion: completion)
            }
       }
       

    
    /// Fontion permettant d'obtenir la liste de nos films en fonction de la categorie selectioner
    /// - Parameters:
    ///   - idCategory: ID de la categorie selectioner
    ///   - completion: function type variable that takes as a parameter a List of Presentation Films Objects allowing to retrieve the values returned by the HTTP request which is asynchronous
    func listPresentationMovieCategory(idCategory: String, completion: @escaping  (_ movies: [PresentationMovie]) -> Void) {
        api.requestListMoviesCategory(idCategory: idCategory) { ( listRequestMovies )  in
            
            /// The request perform returns data to us which we must process
            let movies: [PresentationMovie] = listRequestMovies.compactMap { (responseMovie ) -> PresentationMovie? in
                
                // we test the values returned by the API. An intermediate object links the API data to the data used by the VIEWS
                guard let idmovie = responseMovie.idMovie,
                    let titleMovie = responseMovie.title,
                    let resumeMovie = responseMovie.overview else {
                        return nil
                }
                
                let movie: PresentationMovie = PresentationMovie(
                    idMovie: idmovie,
                    title: titleMovie ,
                    resume: resumeMovie,
                    dateRelease: responseMovie.release_date,
                    poster: responseMovie.poster)
                
                return movie
            }
            
            completion(movies)
        }
    }
    
    
   
    
    
    // Returns the Maximum Number of items that the Views array will need to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count // On count le nombre d'éléments de notres tableaux
    }
    
    
    // Function which returns the "TableViewsCell" which will be displayed by the "TableViews"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // la méthode dequeueReusableCell fournient des cellules disponible
        let cell = tableViews.dequeueReusableCell(withIdentifier: cellId , for:  indexPath) as! ListTableViewCell
        
        let movie:PresentationMovie = movies[indexPath.item]
        
        cell.listTitleMovie.text  = movie.title
        cell.listDureeMovie.text  = movie.dateRelease
        cell.listDescriptifMovie.text = movie.resume
       
        if let  f = movie.poster,  let urlImage  = URL(string: "https://image.tmdb.org/t/p/w300\(f)" ){
            api.dowloadImage(url: urlImage ) { (image, path) in
                    cell.listImageMovie.image = image
            }
        }
        
        return cell
    }
    

  
      
      
    
    /// When calling performSegue we overload the function called by default to pass it the ID of the selected film
    /// - Parameters:
    ///   - segue:
    ///   - sender: Contains the film ID
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC : ViewController = segue.destination as! ViewController
            destVC.idMovie = sender as! String
    }
    

    
    /// when clicking on an item in the Views table (details of the films)
    /// - Parameters:
    ///   - tableView:
    ///   - indexPath: Index of the select line
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetailsMovie" , sender: String(movies[indexPath.row].idMovie))
    }
    
    
    
    
    
    
    
}
