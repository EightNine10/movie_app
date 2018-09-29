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

extension String
{
	func dateToStyle(dateFormat: String, dateStyle: DateFormatter.Style) -> String
	{
		let inputDateFormatter = DateFormatter()
		inputDateFormatter.dateFormat = dateFormat

		if let date = inputDateFormatter.date(from: self)
		{
			let outputDateFormatter = DateFormatter()
			outputDateFormatter.dateStyle = dateStyle
			return outputDateFormatter.string(from: date)
		}

		return self
	}

	func dateFromString(dateFormat: String) -> Date?
	{
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = dateFormat

		if let date = dateFormatter.date(from: self)
		{	return date
		}

		return nil
	}
}
