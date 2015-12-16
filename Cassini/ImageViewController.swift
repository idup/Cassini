//
//  ImageViewController.swift
//  Cassini
//
//  Created by 虎猫儿 on 15/12/12.
//  Copyright © 2015年 TAC. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    // MARK:- Accesstors
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    internal var imageURL: NSURL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    private var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
            spinner?.hidden = true
        }
    }
    
    lazy private var imageView = UIImageView()
    
    // MARK:- UIScrollViewDelegate
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // MARK:- Main
    private func fetchImage() {
        if let url = imageURL {
            spinner?.hidden = false
            spinner?.startAnimating()
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                let imageData = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()) {
                    if url == self.imageURL {
                        if imageData != nil {
                            self.image = UIImage(data: imageData!)
                        } else {
                            self.image = nil
                        }
                    }
                }
            }
        }
    }
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
}
