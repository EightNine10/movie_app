//
//  FavouritesManager.swift
//  Movie App
//
//  Created by Peter Rutherford on 2018-09-29.
//  Copyright © 2018 Peter Rutherford. All rights reserved.
//

// Singleton class used to manage the favourite movies of the users by Movie ID

import Foundation

class FavouritesManager
{
	static var shared = FavouritesManager()

	var favouriteMovies = [Int]()

	func toggle(movieID: Int)
	{
		if favouriteMovies.contains(movieID)
		{	self.remove(movieID: movieID)
		}
		else
		{	self.add(movieID: movieID)
		}
	}

	func add(movieID: Int)
	{
		if !favouriteMovies.contains(movieID)
		{	favouriteMovies.append(movieID)
		}

		self.save()
	}

	func remove(movieID: Int)
	{
		if let index = favouriteMovies.index(of: movieID)
		{	favouriteMovies.remove(at: index)
		}

		self.save()
	}

	func isFavourite(movieID: Int) -> Bool
	{
		return favouriteMovies.contains(movieID)
	}

	func save()
	{
		UserDefaults.standard.set(self.favouriteMovies, forKey: "FAVOURITES")
		UserDefaults.standard.synchronize()
	}

	func load()
	{
		if let movieArray = UserDefaults.standard.array(forKey: "FAVOURITES") as? [Int]
		{	self.favouriteMovies = movieArray
		}
	}
}
