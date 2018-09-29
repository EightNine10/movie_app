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
	@IBOutlet weak var movieImageView: UIImageView!
	@IBOutlet weak var movieTitleLabel: UILabel!
	@IBOutlet weak var movieOverviewLabel: UILabel!
	@IBOutlet weak var movieReleaseDateLabel: UILabel!
	@IBOutlet weak var movieVoteAverageLabel: UILabel!

	func setMovie(_ movie: Movie)
	{
		self.movieTitleLabel.text = movie.title
		self.movieOverviewLabel.text = movie.overview
		self.movieReleaseDateLabel.text = movie.releaseDate
		self.movieVoteAverageLabel.text = movie.voteAverage

		let data = try? Data(contentsOf: movie.imageURL!)

		if let imageData = data
		{	self.movieImageView.image = UIImage(data: imageData)
		}
	}
}
