//
//  ViewController.swift
//  Movie App
//
//  Created by Peter Rutherford on 2018-09-27.
//  Copyright © 2018 Peter Rutherford. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
	@IBOutlet weak var movieCategoryLabel: UILabel!
	@IBOutlet weak var movieCollectionView: UICollectionView!

	var movies = [Movie]()
	
	override func viewDidLoad()
	{
		super.viewDidLoad()

		self.movieCollectionView.dataSource = self
		self.movieCollectionView.delegate = self

		APIManager.shared.getTopMovies()
		{ (movies) in

			self.movies = movies

			DispatchQueue.main.async
			{	self.movieCollectionView.reloadData()
			}
		}
	}

	// UICollectionViewDelegateFlowLayout protocol methods
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: self.movieCollectionView.bounds.width, height: self.movieCollectionView.bounds.height)
	}

	// UICollectionViewDataSource protocol methods
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return movies.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		if let movieCell = self.movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell
		{
			movieCell.setMovie(self.movies[indexPath.row])
			return movieCell
		}

		return UICollectionViewCell()
	}
}

