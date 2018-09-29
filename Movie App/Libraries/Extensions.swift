//
//  Extensions.swift
//  Movie App
//
//  Created by Peter Rutherford on 2018-09-27.
//  Copyright © 2018 Peter Rutherford. All rights reserved.
//

import Foundation

extension URLSession
{
	func jsonFromUrlString(_ urlString: String, completion: @escaping (JSON?) -> Void)
	{
		if let url = URL(string: urlString)
		{
			let task = self.dataTask(with: url)
			{ (data, response, error) in

				if let data = data
				{
					do
					{	let json = try JSON(data: data)
						completion(json)
					}
					catch
					{	completion(nil)
					}
				}
				else
				{	completion(nil)
				}
			}

			task.resume()
		}
		else
		{	completion(nil)
		}
	}
}
