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
	var voteAverage: String

	var releaseDate: String

	var imageURL: URL?

	init(json: JSON)
	{
		self.title = json["title"].stringValue
		self.overview = json["overview"].stringValue
		self.voteAverage = "\(json["vote_average"].doubleValue) / 10"

		let dateString = json["release_date"].stringValue

		// Create Date String
		if let date = dateString.dateFromString(dateFormat: "yyyy-MM-dd")
		{
			let releaseDateString = dateString.dateToStyle(dateFormat: "yyyy-MM-dd", dateStyle: .medium)
			let releaseString = (date.compare(Date()) == .orderedAscending) ? "Released:" : "Releases:"

			self.releaseDate = "\(releaseString) \(releaseDateString)"
		}
		else
		{	self.releaseDate = ""
		}

		self.imageURL = APIManager.shared.createPosterImageURL(posterPath: json["poster_path"].stringValue)
	}
}
