//
//  data.swift
//  tinkofLesson2
//
//  Created by Andrey Minin on 13/03/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import Foundation
class CustomData{
    
    var name : String = ""
    var photo = UIImage()
    var info : String = ""
    
    init(name: String,photo: UIImage, info: String){
        self.name = name
        self.photo = photo
        self.info = info
    }
    func getName() -> String {
        return name
    }
    func getPhoto() -> UIImage{
        return photo
    }
    func getInfo() -> String {
        return info
    }
    
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.photo = aDecoder.decodeObject(forKey: "photo") as! UIImage
        self.info = aDecoder.decodeObject(forKey: "info") as! String
    }
    func initWithCoder(aDecoder: NSCoder) -> CustomData{
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.photo = aDecoder.decodeObject(forKey: "photo") as! UIImage
        self.info = aDecoder.decodeObject(forKey: "info") as! String
        return self
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.photo, forKey: "photo")
        aCoder.encode(self.info, forKey: "info")
    }
}
