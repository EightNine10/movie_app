//
//  Movie.swift
//  Movie App
//
//  Created by Peter Rutherford on 2018-09-27.
//  Copyright © 2018 Peter Rutherford. All rights reserved.
//

import Foundation

class Movie
{
	var title: String
	var overview: String
	var voteAverage: Double

	var releaseDate: String

	var imageURL: URL?

	init(json: JSON)
	{
		self.title = json["title"].stringValue
		self.overview = json["overview"].stringValue
		self.voteAverage = json["vote_average"].doubleValue

		self.releaseDate = json["release_date"].stringValue

		self.imageURL = APIManager.shared.createPosterImageURL(posterPath: json["poster_path"].stringValue)
	}
}
