//
//  TakePhotoViewController.swift
//  NJIT Student Guide
//
//  Created by Venkatesh Muthukrishnan on 10/26/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import UIKit

class TakePhotoViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
     var imagePicker = UIImagePickerController()
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func takePhoto(sender: AnyObject) {
        
       imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true,completion: nil)
        imageView.image = UIImagePickerControllerOriginalImage as? UIImage
        
    }

}
