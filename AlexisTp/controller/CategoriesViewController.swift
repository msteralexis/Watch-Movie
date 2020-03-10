//
//  CategoriesViewController.swift
//  AlexisTp
//
//  Created by  on 09/03/2020.
//  Copyright © 2020 alexis. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController ,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Variable allowing access to our graphic element
    @IBOutlet weak var collectionViews: UICollectionView!
    
    // By default we define the name of our cells
    let cellId :String = "cellulesCategory"
    
    // list of our categories that we will use for our Views
    var genres: [GenreMovie] = []
    
    // The API class contains all the functions allowing HHTP requests
    let api: Api = Api()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    
        /// Closure of types function which takes as parameter a table of Genre of films and will be used to retrieve our genres (see details of asymmetrical request in API class)
        let completion = { (_ genresMovies: [GenreMovie] ) ->  Void in
            self.genres = genresMovies
            DispatchQueue.main.async {
                self.collectionViews.reloadData()
            }
  
        }
        // on charge notre list de Categories
        UploadGenreMovies(completion: completion)

    }
    
    
    
    /// We load our cells in our TableViewsCell
    private func setupCollectionView() {
        collectionViews.delegate = self
        collectionViews.dataSource = self
        collectionViews.register(
            UINib(nibName: "CategoriesCollectionViewCell" , bundle: nil ),
            forCellWithReuseIdentifier: cellId)
    }
    

    
    ///
    /// - Parameter completion:Function type variable taking as a parameter a table of Genres list used for our displays
    func UploadGenreMovies(completion: @escaping  (_ genresMovies: [GenreMovie]) -> Void) {
        api.listgenres { (listGenres) in
            let genre:[GenreMovie] = listGenres.compactMap { (responseGenre) -> GenreMovie? in
                
                guard let idGenreGood = responseGenre.idGenre,
                    let nomGenreGood = responseGenre.nomGenre else {
                    return nil
                }
                
                let genre: GenreMovie = GenreMovie (
                               idGenre: String(idGenreGood) ,
                               nomGenre: nomGenreGood)

                return genre
            }
            completion(genre)
        }
    }
    
    

    
    // Détermines de la tailel de nos cellules
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 40  )  / 2  // self.view.frame.size.width nosu returns the width of the screen to which we remove the margins of our TablesViewsCells and divide by 2 to display 2 elements per line
        let height = width  //The height of our cells will make the width to display squares
        return CGSize(width: width, height: height)
    }
    
    
    // number of element that we will have in our views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.genres.count
    }
    
    
    
    /// Function used to generate the cells necessary for our displays
    /// - Parameters:
    ///   - collectionView: Delegation of the necessary elements processing of our TavleViewsCell
    ///   - indexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath ) as! CategoriesCollectionViewCell
        let movie:GenreMovie = genres[indexPath.item]
        cell.nameCategories.text = movie.nomGenre
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC : ListViewsController = segue.destination as! ListViewsController
            destVC.idCategories = sender as! String
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showListMoviesByCategories" , sender: String(genres[indexPath[1]].idGenre))
    }
 
    
    
    
    
    
    
    
    
    
}
