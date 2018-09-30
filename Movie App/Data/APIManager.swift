//
//  APIManager.swift
//  Movie App
//
//  Created by Peter Rutherford on 2018-09-27.
//  Copyright © 2018 Peter Rutherford. All rights reserved.
//

// Singleton class used to manage the API calls to the tMDB API

import Foundation

class APIManager
{
	enum MovieListCategory
	{
		case nowPlaying
		case topRated
	}

	// Constant API KEY for tMDB account
	private let API_KEY = "e8d3cef929e637daff7cc49b853ba05b"

	static var shared = APIManager()

	var secureBaseUrlString: String?
	var configurationComplete = false

	init()
	{
	}

	func loadConfiguration(completion: ((Bool) -> Void)?)
	{
		URLSession.shared.jsonFromUrlString("https://api.themoviedb.org/3/configuration?api_key=\(API_KEY)")
		{ (json) in

			if let json = json
			{
				self.secureBaseUrlString = json["images"]["secure_base_url"].stringValue
				self.configurationComplete = true

				completion?(self.configurationComplete)
			}
			else
			{	completion?(false)
			}
		}
	}

	func checkConfiguration(completion: @escaping (Bool) -> Void)
	{
		if configurationComplete
		{	completion(true)
		}
		else
		{
			self.loadConfiguration()
			{ (result) in

				completion(result)
			}
		}
	}

	func getMoviesForCategory(_ category: MovieListCategory, completion: @escaping ([Movie]) -> Void)
	{
		// If initial configuration API failed, it needs to be called before any movie image data can be loaded
		self.checkConfiguration()
		{ (result) in

			if result
			{
				let urlCategoryString = (category == .nowPlaying) ? "now_playing" : "top_rated"

				URLSession.shared.jsonFromUrlString("https://api.themoviedb.org/3/movie/\(urlCategoryString)?api_key=\(self.API_KEY)")
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
			else
			{	completion([])
			}
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
