//
//  ViewController.swift
//  Movie App
//
//  Created by Peter Rutherford on 2018-09-27.
//  Copyright © 2018 Peter Rutherford. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
	override func viewDidLoad()
	{
		super.viewDidLoad()

		let API_KEY = "e8d3cef929e637daff7cc49b853ba05b"

		if let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(API_KEY)")
		{
			let task = URLSession.shared.dataTask(with: url)
			{ (data, response, error) in

				if let data = data
				{
					do
					{	let json = try JSON(data: data)
					}
					catch
					{
					}
				}
			}

			task.resume()
		}
	}
}

