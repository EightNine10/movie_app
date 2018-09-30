//
//  CachingImageView.swift
//  Movie App
//
//  Created by Peter Rutherford on 2018-09-29.
//  Copyright © 2018 Peter Rutherford. All rights reserved.
//

// Simple class to handle caching and loading of images from URL sources
// Also ensures that correct images are loaded when using a CollectionView

import Foundation
import UIKit

class CachingImageView: UIImageView
{
	static var imageCache = NSCache<AnyObject, AnyObject>()

	var lastImageURLString: String?

	func loadImageFromURL(_ url: URL)
	{
		self.lastImageURLString = url.absoluteString
		self.image = nil

		if let cachedImage = CachingImageView.imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage
		{
			self.image = cachedImage
			return
		}

		let task = URLSession.shared.dataTask(with: url)
		{ (data, response, error) in

			if error == nil && data != nil
			{
				if let newImage = UIImage(data: data!)
				{
					CachingImageView.imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)

					DispatchQueue.main.async
					{
						if self.lastImageURLString == url.absoluteString
						{
							self.image = newImage
							self.alpha = 0

							UIView.animate(withDuration: 0.16)
							{	self.alpha = 1
							}
						}
					}
				}
			}
		}

		task.resume()
	}
}
