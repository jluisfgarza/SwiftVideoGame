//
//  HomeAlbumsCell.swift
//  PhotoTrash
//
//  Created by Luis Felipe Salazar on 8/6/15.
//  Copyright (c) 2015 Luis Felipe Salazar. All rights reserved.
//

import UIKit

class HomeAlbumsCell: UICollectionViewCell {
    
    //var textLabel: UILabel!
    var imageView: UIImageView!
    var boy : Bool = true
    
    var textLabel: UILabel!
    
    
 
    required override init(frame: CGRect) {
        super.init(frame: frame)
       

        //Label that shows the title of the album
        //textLabel.font = UIFont(name: "Oswald-Regular", size: 20)
        //textLabel.font = UIFont(name: "Didot", size: 20)
        //let font = UIFont.systemFontOfSize(30, weight: UIFontWeightBold)
        
        let font = UIFont(name: "Oswald-Regular", size: 30)

        textLabel = UILabel(frame: CGRect(x: 0, y: 190, width: frame.size.width, height: 30))
        textLabel.font = font
        textLabel.textColor = UIColor.whiteColor()
        textLabel.textAlignment = .Center
        contentView.addSubview(textLabel)
        
        //Front image
        if boy {
            imageView = UIImageView(frame: CGRect(x: 50, y: 20, width: 165, height: 165))
        } else {
            imageView = UIImageView(frame: CGRect(x: 25, y: 20, width: 165, height: 165))
        }
        
        
        contentView.addSubview(imageView)

        
    }
    
    func setThumbnailImage(thumbnailImage: UIImage){
        self.imageView.image = thumbnailImage
    }
    
    func setName(name: String){
        self.textLabel.text = name
    }
    
    override var highlighted : Bool {
        didSet {
            if highlighted {
                textLabel.alpha = 0.5
                imageView.alpha = 0.5
            } else {
                imageView.alpha = 1
                textLabel.alpha = 1
            }
            
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
