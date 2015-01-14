//
//  ViewController.swift
//  MyGraphicExample
//
//  Created by wwwins on 2015/1/12.
//  Copyright (c) 2015年 isobar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //let image = processImage1()
    //let image = processImage2()
    let image = processImage3()
    let scale = self.view.frame.size.width/image.size.width
    let imageView = UIImageView(frame: CGRectMake(0, 100, image.size.width*scale, image.size.height*scale))
    imageView.image = image
    self.view.addSubview(imageView)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func processImage1() -> UIImage {
    // creating the graphics context
    UIGraphicsBeginImageContextWithOptions(CGSize(width: 200, height: 200), true, 1)
    
    // retrieve it
    let context = UIGraphicsGetCurrentContext()
    
    // drawing commands
    CGContextSetRGBFillColor (context, 1, 1, 0, 1);
    CGContextFillRect (context, CGRectMake (0, 0, 200, 200));// 4
    CGContextSetRGBFillColor (context, 1, 0, 0, 1);// 3
    CGContextFillRect (context, CGRectMake (0, 0, 100, 100));// 4
    CGContextSetRGBFillColor (context, 1, 1, 0, 1);// 3
    CGContextFillRect (context, CGRectMake (0, 0, 50, 50));// 4
    CGContextSetRGBFillColor (context, 0, 0, 1, 0.5);// 5
    CGContextFillRect (context, CGRectMake (0, 0, 50, 100));
    
    // quering an image from it
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
  }
  
  // core image with filter
  func processImage2(xpos:CGFloat = 300, ypos:CGFloat = 300) -> UIImage {
    
    // we reference our image (path)
    //let data = NSData (contentsOfFile: "/Users/XXXX/Desktop/c0415.png")
    // we create a UIImage out of it
    //let image = UIImage(data: data)
    let image = UIImage(named: "c0415")
    
    // creating Core Image context
    let ciContext = CIContext(options: nil)
    // creating a CIImage, think of a CIImage as image data for processing.
    let coreImage = CIImage(image: image)
    // picking the filter
    //let filter = CIFilter(name: "CIPhotoEffectTransfer")
    let filter = CIFilter(name: "CIVignetteEffect")
    // passing image
    filter.setValue(coreImage, forKey: kCIInputImageKey)
    // set a custom value for the inputCenter
    filter.setValue(CIVector(x: xpos, y: ypos), forKey: kCIInputCenterKey)
    // retrieve the processed image
    let filteredImageData = filter.valueForKey(kCIOutputImageKey) as CIImage
    // returns a Quartz image from the Core Image context
    let filteredImageRef = ciContext.createCGImage(filteredImageData, fromRect: filteredImageData.extent())
    // this is our final UIImage ready to be displayed
    let filteredImage = UIImage(CGImage: filteredImageRef);
    
    return filteredImage!
    
  }
  
  // drawing text
  func processImage3() -> UIImage {
    
    let font = UIFont.boldSystemFontOfSize(44)
    let showText:NSString = "女帝無敵"
    let attr = [NSFontAttributeName: font, NSForegroundColorAttributeName:UIColor.whiteColor()]
    let sizeOfText = showText.sizeWithAttributes(attr)
    
    let image = UIImage(named: "c0415")
    let rect = CGRectMake(0, 0, image!.size.width, image!.size.height)
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: rect.size.width, height: rect.size.height), true, 0)
    
    // drawing our image to the graphics context
    image?.drawInRect(rect)
    showText.drawInRect(CGRectMake(rect.size.width-sizeOfText.width-10, rect.size.height-sizeOfText.height-10, rect.size.width, rect.size.height), withAttributes: attr)
    
    // quering an image from it
    let newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext()
    
    return newImage
    
  }


}

