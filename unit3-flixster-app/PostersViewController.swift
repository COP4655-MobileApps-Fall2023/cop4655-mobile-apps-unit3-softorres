//
//  PostersViewController.swift
//  unit3-flixster-app
//
//  Created by Sofia Torres on 9/19/23.
//

import UIKit
import Nuke

class PostersViewController: UIViewController, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // the number of items shown should be the number of albums we have.
            posters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get a collection view cell (based in the identifier you set in storyboard) and cast it to our custom AlbumCell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell

            // Use the indexPath.item to index into the albums array to get the corresponding album
            let poster = posters[indexPath.item]

            // Get the artwork image url
           // let imageUrl = poster.poster_path
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w300/" + poster.poster_path.absoluteString)
            // Set the image on the image view of the cell
            Nuke.loadImage(with: imageUrl, into: cell.posterImageView)

            return cell
    }
    
    
    //add property
    var posters: [Poster] = []

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self


        // Do any additional setup after loading the view.
        // Create a search URL for fetching albums (`entity=album`)
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=bc5cd9c1a05098330cdba7dd04ec08f6")!
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            // Handle any errors
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }
            
            // Make sure we have data
            guard let data = data else {
                print("❌ Data is nil")
                return
            }
            
            // Create a JSON Decoder
            let decoder = JSONDecoder()
            do {
                // Try to parse the response into our custom model
                let response = try decoder.decode(PosterSearchResponse.self, from: data)
                let posters = response.results
                
                DispatchQueue.main.async {
                    self?.posters = posters
                    self?.collectionView.reloadData()
                }
               // print(albums)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        // Get a reference to the collection view's layout
        // We want to dynamically size the cells for the available space and desired number of columns.
        // NOTE: This collection view scrolls vertically, but collection views can alternatively scroll horizontally.
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        // The minimum spacing between adjacent cells (left / right, in vertical scrolling collection)
        // Set this to taste.
        layout.minimumInteritemSpacing = 4

        // The minimum spacing between adjacent cells (top / bottom, in vertical scrolling collection)
        // Set this to taste.
        layout.minimumLineSpacing = 4

        // Set this to however many columns you want to show in the collection.
        let numberOfColumns: CGFloat = 3

        // Calculate the width each cell need to be to fit the number of columns, taking into account the spacing between cells.
        let width = (collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns

        // Set the size that each tem/cell should display at
        layout.itemSize = CGSize(width: width, height: width)
        // Initiate the network request
        task.resume()
    }

}
/*

class PostersViewController: UIViewController {
    //add property
    var posters: [Poster] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Create a search URL for fetching albums (`entity=album`)
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=bc5cd9c1a05098330cdba7dd04ec08f6")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            // Handle any errors
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }
            
            // Make sure we have data
            guard let data = data else {
                print("❌ Data is nil")
                return
            }
            
            // Create a JSON Decoder
            let decoder = JSONDecoder()
            do {
                // Try to parse the response into our custom model
                let response = try decoder.decode(PosterSearchResponse.self, from: data)
                let posters = response.results
                print(posters)
            } catch {
                print(error.localizedDescription)
            }
            // Initiate the network request
            task.resume()
        }
        
    }
}
*/
