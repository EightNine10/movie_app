//
//  MovieCollectionViewCell.swift
//  Movie App
//
//  Created by Peter Rutherford on 2018-09-29.
//  Copyright © 2018 Peter Rutherford. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell
{
	@IBOutlet weak var movieTitleLabel: UILabel!
	@IBOutlet weak var movieOverviewLabel: UILabel!
	@IBOutlet weak var movieReleaseDateLabel: UILabel!
	@IBOutlet weak var movieVoteAverageLabel: UILabel!

	@IBOutlet weak var movieImageView: CachingImageView!

	@IBOutlet weak var favouriteButton: UIButton!
	@IBOutlet weak var pageNumberLabel: UILabel!

	var movie: Movie?
	
	@IBOutlet weak var imageTrailingConstraint: NSLayoutConstraint!
	@IBOutlet weak var imageLeadingConstraint: NSLayoutConstraint!

	func setMovie(_ movie: Movie, index: Int)
	{
		self.movie = movie

		self.movieTitleLabel.text = movie.title
		self.movieOverviewLabel.text = movie.overview
		self.movieReleaseDateLabel.text = movie.releaseDate
		self.movieVoteAverageLabel.text = movie.voteAverage

		if let url = movie.imageURL
		{	self.movieImageView.loadImageFromURL(url)
		}

		self.setFavouritesButton()
		self.pageNumberLabel.text = "\(index)/20"

		// Slight constraint modification for iPads
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
		{
			self.imageTrailingConstraint.constant = 170
			self.imageLeadingConstraint.constant = 170
		}
	}

	func setFavouritesButton()
	{
		if let movie = self.movie
		{
			let favouriteImageName = (FavouritesManager.shared.isFavourite(movieID: movie.movieID)) ? "heart_fill" : "heart_empty"
			favouriteButton.setImage(UIImage(named: favouriteImageName), for: .normal)
		}
	}

	@IBAction func favouritesButtonPressed(_ sender: UIButton)
	{
		if let movie = self.movie
		{
			FavouritesManager.shared.toggle(movieID: movie.movieID)
			self.setFavouritesButton()
		}
	}
}
