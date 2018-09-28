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
	var releaseDate: String
	var voteAverage: Double

	var imageURL: URL?

	init(json: JSON)
	{
		self.title = json["title"].stringValue
		self.overview = json["overview"].stringValue
		self.overview = json["releaseDate"].stringValue
		self.overview = json["voteAverage"].doubleValue

		self.imageURL = json["poster_path"]
	}
}
