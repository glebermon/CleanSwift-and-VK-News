//
//  testCamera.swift
//  VKNews
//
//  Created by Глеб on 01.11.2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import UIKit
import AVFoundation
import VKSdkFramework

class CameraViewController: UIViewController {
    
    let picker = UIImagePickerController()
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchInsideView))
    
    var previewView: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    var cameraView: UIImageView = {
       let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let photoImageView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .red
        return img
    }()
    
    let imageCamera : UIImageView = {
       let img = UIImageView()
//        img.backgroundColor = .blac
        img.image = UIImage(named: "camera100_2")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(presentCamera))
        self.navigationItem.title = "Photo"
        
        previewView.isUserInteractionEnabled = true
        previewView.addGestureRecognizer(tapGesture)
        

        setupConstrints()
        beginSession()
        setupPicker()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if cameraView.frame.contains(touch.location(in: imageCamera)) {
                presentCamera()
            }
        }
    }
    
    @objc func presentCamera() {
        present(picker, animated: true, completion: nil)
    }
    
    func beginSession() {
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { fatalError("No camera") }
        do {
          let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)

            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            cameraView.layer.addSublayer(videoPreviewLayer!)

            captureSession?.startRunning()
        } catch {
          print(error)
        }
    }
    
    func setupConstrints() {
        view.addSubview(previewView)
        previewView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        previewView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        previewView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        previewView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        

        previewView.addSubview(cameraView)
        cameraView.topAnchor.constraint(equalTo: previewView.topAnchor).isActive = true
        cameraView.leadingAnchor.constraint(equalTo: previewView.leadingAnchor).isActive = true
        cameraView.trailingAnchor.constraint(equalTo: previewView.trailingAnchor).isActive = true
        cameraView.bottomAnchor.constraint(equalTo: previewView.bottomAnchor).isActive = true
        
        previewView.addSubview(imageCamera)
        imageCamera.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageCamera.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageCamera.centerYAnchor.constraint(equalTo: previewView.centerYAnchor).isActive = true
        imageCamera.centerXAnchor.constraint(equalTo: previewView.centerXAnchor).isActive = true
    }
    
    override var shouldAutorotate: Bool {
        if (UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft ||
        UIDevice.current.orientation == UIDeviceOrientation.landscapeRight ||
        UIDevice.current.orientation == UIDeviceOrientation.unknown) {
            return false
        }
        else {
            return true
        }
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        photoImageView.image = img
//        uploadImageToNewsfeed(image: img)
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func touchInsideView(sender : UITapGestureRecognizer) {
        if sender.state == .ended {
            print("1234")
        }
        print("Hello")
    }
}


extension CameraViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func setupPicker() {
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
    }
    
    
    private func uploadImageToNewsfeed(image : Any?) {
        guard let userId = Int((VKSdk.accessToken()?.userId)!) else { return }
        if let imageToUpload = image as? UIImage {
            photoImageView.image = imageToUpload
            let photoRequest = VKApi.uploadWallPhotoRequest(imageToUpload, parameters:
                VKImageParameters.pngImage(), userId: userId, groupId: 0)
            photoRequest?.execute(resultBlock: { response in
                if let json = response?.json {
                    print("Photo: \(json)")
                }
                let photoInfo = (response?.parsedModel as? VKPhotoArray)?.object(at: 0)
                var post: VKRequest? = nil
                if let owner_id = photoInfo?.owner_id, let id = photoInfo?.id {
                    post = VKApi.wall().post([
                    VK_API_ATTACHMENTS: "photo\(owner_id)_\(id)"
                ])
                }
                post?.execute(resultBlock: { response in
                    if let response = response {
                        print("Result: \(response)")
                    }
                }, errorBlock: { error in
                    if let error = error {
                        print("Error: \(error)")
                    }
                })
            }, errorBlock: { error in
                if let error = error {
                    print("Error: \(error)")
                }
            })
        }
    }
}

