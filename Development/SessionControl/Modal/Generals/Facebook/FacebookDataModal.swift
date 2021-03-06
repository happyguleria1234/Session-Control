//
//	Data.swift
//
//	Create by Dharmesh Avaiya on 16/3/2021
//	Copyright © 2021. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class FacebookDataModal : NSObject, NSCoding{

	var height : Int!
	var isSilhouette : Int!
	var url : String!
	var width : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		height = dictionary["height"] as? Int
		isSilhouette = dictionary["is_silhouette"] as? Int
		url = dictionary["url"] as? String
		width = dictionary["width"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if height != nil{
			dictionary["height"] = height
		}
		if isSilhouette != nil{
			dictionary["is_silhouette"] = isSilhouette
		}
		if url != nil{
			dictionary["url"] = url
		}
		if width != nil{
			dictionary["width"] = width
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         height = aDecoder.decodeObject(forKey: "height") as? Int
         isSilhouette = aDecoder.decodeObject(forKey: "is_silhouette") as? Int
         url = aDecoder.decodeObject(forKey: "url") as? String
         width = aDecoder.decodeObject(forKey: "width") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if height != nil{
			aCoder.encode(height, forKey: "height")
		}
		if isSilhouette != nil{
			aCoder.encode(isSilhouette, forKey: "is_silhouette")
		}
		if url != nil{
			aCoder.encode(url, forKey: "url")
		}
		if width != nil{
			aCoder.encode(width, forKey: "width")
		}

	}

}
