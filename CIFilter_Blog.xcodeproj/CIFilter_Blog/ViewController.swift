//
//  ViewController.swift
//  CIFilter_Blog
//
//  Created by Erica Millado on 11/8/16.
//  Copyright © 2016 Erica Millado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let categoryBlurFilterArray:[String] = ["CIBoxBlur", "CIDiscBlur", "CIGaussianBlur", "CIMaskedVariableBlur", "CIMedianFilter", "CIMotionBlur", "CINoiseReduction", "CIZoomBlur"]
    
    let categoryHalftoneEffectArray:[String] = ["CICircularScreen", "CICMYKHalftone", "CIDotScreen", "CIHatchedScreen", "CILineSreen"]

    @IBOutlet weak var originalImageLabel: UILabel!
    @IBOutlet weak var originalImage: UIImageView!
    @IBOutlet weak var filteredImageLabel: UILabel!
    @IBOutlet weak var filteredImage: UIImageView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
    }

    //MARK: PickerView datasource methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryHalftoneEffectArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = categoryHalftoneEffectArray[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Avenir Next", size: 20.0)!,NSForegroundColorAttributeName:UIColor.black])
        pickerLabel.attributedText = myTitle
        
        //color  and center the label's background
        let hue = CGFloat(row)/CGFloat(categoryBlurFilterArray.count)
        pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness:1.0, alpha: 1.0)
        pickerLabel.textAlignment = .center
        return pickerLabel
        
    }

    //MARK: PickerView delegate methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryHalftoneEffectArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        filteredImageLabel.text = categoryBlurFilterArray[row]
        guard let filteredImageString = filteredImageLabel.text else { return }
//        DispatchQueue.main.async {
            self.useHalftoneEffects(filterName: filteredImageString)
            print(filteredImageString)
//        }
        
        
    }
    
    //MARK: change filter 
    
    func useHalftoneEffects(filterName:String) {
        let tacoImage = UIImage(named: "taco")
        
        var queue = OperationQueue()
        queue.qualityOfService = .userInitiated
        queue.addOperation {
            print("starting operation")
            let context = CIContext(options: nil)
            //        let filter = CIFilter(name: "CIBumpDistortion")
            let filter = CIFilter(name: filterName)
            var scaleFactor: CGFloat!
            var extent: CGRect!
            //gets the scale factor
            scaleFactor = UIScreen.main.scale
            //tells us the size that we need to create our image
            extent = UIScreen.main.bounds.applying(CGAffineTransform(scaleX: scaleFactor, y: scaleFactor))
            
            //we need to use a CIImage, taken from our current imageview image in storyboard
            let ciImage = CIImage(image: tacoImage!)
            
            //setting up our filter
            //sets the default value for each filter's properties
            filter?.setDefaults()
            
            //tell the filter what image it should use to apply the filter to
            //filters use key/value coding; value = ciImage; key = kCIInputImagekey (how you can get to all of the keys for Core Image)
            //told the filter that this ciImage is the one we want to be working with
            filter?.setValue(ciImage, forKey: kCIInputImageKey)
            
            let image = UIImage(cgImage: context.createCGImage((filter?.outputImage)!, from: extent)!)
            
            OperationQueue.main.addOperation {
                print("completed")
                self.filteredImage.transform = CGAffineTransform.identity
                self.filteredImage.image = image
            }
            
        }
    }
    
    func useBumpDistortion(filterName:String) {
        let tacoImage = UIImage(named: "taco")
        
        var queue = OperationQueue()
        queue.qualityOfService = .userInitiated
        queue.addOperation {
            print("starting operation")
            let context = CIContext(options: nil)
            //        let filter = CIFilter(name: "CIBumpDistortion")
            let filter = CIFilter(name: filterName)
            var scaleFactor: CGFloat!
            var extent: CGRect!
            //gets the scale factor
            scaleFactor = UIScreen.main.scale
            //tells us the size that we need to create our image
            extent = UIScreen.main.bounds.applying(CGAffineTransform(scaleX: scaleFactor, y: scaleFactor))
            
            //we need to use a CIImage, taken from our current imageview image in storyboard
            let ciImage = CIImage(image: tacoImage!)
            
            //setting up our filter
            //sets the default value for each filter's properties
            filter?.setDefaults()
            
            //tell the filter what image it should use to apply the filter to
            //filters use key/value coding; value = ciImage; key = kCIInputImagekey (how you can get to all of the keys for Core Image)
            //told the filter that this ciImage is the one we want to be working with
            filter?.setValue(ciImage, forKey: kCIInputImageKey)
            
            let image = UIImage(cgImage: context.createCGImage((filter?.outputImage)!, from: extent)!)
            
            OperationQueue.main.addOperation {
                print("completed")
                self.filteredImage.transform = CGAffineTransform.identity
                self.filteredImage.image = image
            }
            
        }
        
        
    }
    

//end
}



















