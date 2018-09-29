//
//  APIManager.swift
//  Movie App
//
//  Created by Peter Rutherford on 2018-09-27.
//  Copyright © 2018 Peter Rutherford. All rights reserved.
//

import Foundation

class APIManager
{
	private let API_KEY = "e8d3cef929e637daff7cc49b853ba05b"

	static var shared = APIManager()

	var secureBaseUrlString: String?
	var configurationComplete = false

	init()
	{
	}

	func loadConfiguration()
	{
		URLSession.shared.jsonFromUrlString("https://api.themoviedb.org/3/configuration?api_key=\(API_KEY)")
		{ (json) in

			if let json = json
			{
				self.secureBaseUrlString = json["secure_base_url"].stringValue
				self.configurationComplete = true
			}
		}
	}

	func getTopMovies(completion: @escaping ([Movie]) -> Void)
	{
		URLSession.shared.jsonFromUrlString("https://api.themoviedb.org/3/movie/now_playing?api_key=\(API_KEY)")
		{ (json) in

			var movies = [Movie]()

			if let jsonArray = json?["results"].arrayValue
			{
				for movieJSON in jsonArray
				{	movies.append(Movie(json: movieJSON))
				}
			}

			completion(movies)
		}
	}

	func createPosterImageURL(posterPath: String) -> URL?
	{
		if let baseURL = self.secureBaseUrlString
		{	return URL(string: "\(baseURL)original\(posterPath)")
		}

		return nil
	}
}
