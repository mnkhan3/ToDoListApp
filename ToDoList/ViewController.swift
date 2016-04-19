//
//  ViewController.swift
//  ToDoList
//
//  Created by Nayeem on 12/7/15.
//  Copyright © 2015 Mohammed Khan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDesc: UITextField!
    @IBOutlet weak var imageView: UIImageView!

    var imagePicker = UIImagePickerController()
    
    var task:Task?
    let moreContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //imageView.image = UIImage(named: "logo.jpeg")
        imagePicker.delegate = self
        
        if let t = task
        {
        
            txtName.text = t.tName
            txtDesc.text = t.tDesc
            imageView.image = UIImage(data:t.tImage!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveData(sender: AnyObject) {
        
        if task == nil
        {
            let taskDescription = NSEntityDescription.entityForName("Task", inManagedObjectContext: moreContext)
            
            
            // Create the Managed Object to be  inserted into the cored data
            task = Task(entity: taskDescription!, insertIntoManagedObjectContext: moreContext)
            print (task)
        }

        // set the attributes
        task?.tName = txtName.text!
        task?.tDesc = txtDesc.text!
        
        //let img = UIImage(named: "imageView")
        let imgData = UIImageJPEGRepresentation(imageView.image!, 1)
        task?.tImage = imgData
        

        
        // Finally we issue the command to save the data
        var error: NSError?
        
        
        do {
            // Save The object
            
            try moreContext.save()
        } catch var error1 as NSError {
            error = error1
        }
        
        
        //Check if there is any erros
        
        if let err = error {
            
            let a = UIAlertView(title: "Error", message: err.localizedFailureReason, delegate: nil, cancelButtonTitle: "OK")
            a.show()
            
        } else {
            
            let a = UIAlertView(title: "Success", message: "Your Record is saved", delegate: nil, cancelButtonTitle: "OK")
            a.show()
            
        }
    }
    
    
    
    
    

    @IBAction func cameraBtn(sender: AnyObject) {
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)

    }
    
    @IBAction func libraryBtn(sender: AnyObject) {
    
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

