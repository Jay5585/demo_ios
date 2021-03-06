//
//  BaseImageView.swift
//  ViewControllerDemo
//
//  Created by SamSol on 01/07/16.
//  Copyright © 2016 SamSol. All rights reserved.
//

import UIKit
import SDWebImage

/**
 This is list of ImageView Type which are define in BaseImageView Class. We can add new type in this and handle in BaseImageView.
 */
enum BaseImageViewType : Int {
    
    case unknown = -1
    case profile = 1
    case logo = 2
    case defaultImg = 3
}

/**
 This class used to Create ImageView object and set image. We can use used this class as base ImageView in Whole Application.
 */
class BaseImageView: UIImageView {
    
    // MARK: - Attributes -
    
    /// Its type Of ImageView. Default is unknown
    var imageViewType : BaseImageViewType = .unknown
    
    
    // MARK: - Lifecycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /**
     Its Initialize method of BaseImageView.
     - parameter type its type of imageview like profile,logo etc..
     - parameter superView its object of imageView's superView. Its can be null. When it's not null than imageview will added as subview in SuperView object
     */
    init(type : BaseImageViewType, superView: UIView?) {
        super.init(frame: CGRect.zero)
        
        imageViewType = type
        
        self.setCommonProperties()
        self.setlayout()
        
        if(superView != nil){
            superView?.addSubview(self)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)!
        
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
       
    }
    
    /**
     Its will free the memory of basebutton's current hold object's. Mack every object nill her which is declare in class as Swift not automattically release the object.
     */
    deinit{

    }
    
    // MARK: - Layout -
    /**
     This method is used to Set the Common proparty of ImageView as per Type like ContentMode,Border,tag,Backgroud color etc...
     */
    func setCommonProperties(){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        switch imageViewType {
            
        case BaseImageViewType.profile:
            
            self.contentMode = .scaleAspectFit
            self.layoutSubviews()

            
            break
            
        case BaseImageViewType.logo:
            
            //self.image = UIImage(named: "App_icon")!
            
            self.contentMode = .scaleAspectFit
            self.setBorder(Color.border.withAlpha(0.5), width: 0.0, radius: 2.0)
            self.clipsToBounds = true
            self.tag = 0
            self.isUserInteractionEnabled = true
            self.translatesAutoresizingMaskIntoConstraints = false
            
            break;
            
        case BaseImageViewType.defaultImg:
            
            self.contentMode = .scaleAspectFill
            self.clipsToBounds = true
            self.translatesAutoresizingMaskIntoConstraints = false

            break
            
        default:
            break
        }
        
    }
    
    /// This method is used to Set the layout related things as per type like ImageView Height, width etc..
    func setlayout(){
        
        
    }
    
    // MARK: - Public Interface -
    
    /**
     This imethod is Used to Set the image from Url.Its will set the Image when download complete meanwhile its show placeholder image on imageview. or progress bar.
     - parameter urlString: URL of image.
     */
    func displayImageFromURL(_ urlString : String) {
        self.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "UserPlaceholder"), options: SDWebImageOptions.continueInBackground, progress: { [weak self] (receivedSize, totalSize, url) in
            if self != nil{

            }
            
        }) {[weak self] (image, error, cacheType, imageURL) in
            
            if self == nil{
                return
            }

            if(image !=  nil) {
                self!.image = image
            }
        }
        self.layoutSubviews()
    }
    
    func displayImageFromURLWithPlaceholder(_ urlString : String, placeholder : UIImage?) {
        self.sd_setImage(with: URL(string: urlString), placeholderImage: placeholder, options: SDWebImageOptions.continueInBackground, progress: { [weak self] (receivedSize, totalSize, url) in
            
            if self != nil{

            }
            
        }) {[weak self] (image, error, cacheType, imageURL) in
            
            if self == nil {
                return
            }

            if(image !=  nil) {
                self!.image = image
            }
        }
        self.layoutSubviews()
    }
    
   
    
    
    
    
    // MARK: - User Interaction -
    
    
    
    // MARK: - Internal Helpers -
    
}
