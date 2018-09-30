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
	@IBOutlet weak var movieCollectionView: UICollectionView!

	var movies = [Movie]()
	var movieListCategory = APIManager.MovieListCategory.nowPlaying

	// Used to determine if the network call has failed
	var movieLoadFailed = false
	
	override func viewDidLoad()
	{
		super.viewDidLoad()

		self.movieCollectionView.dataSource = self
		self.movieCollectionView.delegate = self

		self.refreshData()
	}

	func refreshData()
	{
		APIManager.shared.getMoviesForCategory(self.movieListCategory)
		{ (movies) in

			self.movies = movies
			self.movieLoadFailed = (movies.count == 0)

			DispatchQueue.main.async
			{
				// Reset CollectionView back to the first cell
				self.movieCollectionView.setContentOffset(CGPoint.zero, animated: false)
				
				self.movieCollectionView.reloadData()
			}
		}
	}

	@IBAction func toggleCategory(_ sender: UISegmentedControl)
	{
		self.movieListCategory = (sender.selectedSegmentIndex == 0) ? .nowPlaying : .topRated
		self.refreshData()
	}

	// UICollectionViewDelegateFlowLayout protocol methods
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: self.movieCollectionView.bounds.width, height: self.movieCollectionView.bounds.height)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
	{
		return 0
	}

	// UICollectionViewDataSource protocol methods
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		if self.movieLoadFailed
		{	return 1
		}

		return movies.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		if self.movieLoadFailed
		{
			return self.movieCollectionView.dequeueReusableCell(withReuseIdentifier: "LoadErrorCell", for: indexPath)
		}
		else if let movieCell = self.movieCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell
		{
			movieCell.setMovie(self.movies[indexPath.row], index: indexPath.row + 1)
			return movieCell
		}

		return UICollectionViewCell()
	}
}

