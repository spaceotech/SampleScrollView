//
//  ViewController.swift
//  SampleScrollView
//
//  Created by Hitesh on 1/4/17.
//  Copyright © 2017 spaceo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrMain: UIScrollView!
    var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgView = UIImageView(image: UIImage(named:"beautiful_swan_2-t2.jpeg"))
        imgView.center = self.view.center
        imgView.contentMode = .ScaleAspectFit
        imgView.frame = CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height)
        
        scrMain.backgroundColor = UIColor.blackColor()
        scrMain.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        scrMain.delegate = self
        scrMain.minimumZoomScale = 0.1
        scrMain.maximumZoomScale = 4.0
        scrMain.zoomScale = 1.0
        scrMain.addSubview(imgView)
        
        self.setupGestureRecognizer()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: Adding Gesture recognizer
    func setupGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        scrMain.addGestureRecognizer(doubleTap)
    }
    
    func handleDoubleTap(recognizer: UITapGestureRecognizer) {
        if (scrMain.zoomScale > scrMain.minimumZoomScale) {
            scrMain.setZoomScale(scrMain.minimumZoomScale, animated: true)
        } else {
            scrMain.setZoomScale(scrMain.maximumZoomScale, animated: true)
        }
    }
    
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }
    
    func setZoomScale() {
        let imageViewSize = imgView.bounds.size
        let scrollViewSize = scrMain.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scrMain.minimumZoomScale = min(widthScale, heightScale)
        scrMain.zoomScale = 1.0
    }
    
    
    //MARK: ScrollView Delegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imgView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        let imageViewSize = imgView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }



    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

