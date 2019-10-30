//
//  CameraViewController.swift
//  VKNews
//
//  Created by Глеб on 28.10.2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import UIKit
import AVFoundation
import VKSdkFramework

class CameraViewController: UIViewController {
    
    var previewView : UIView!
    var boxView:UIView!
    let myButton: UIButton = UIButton()

    //Camera Capture requiered properties
    var videoDataOutput: AVCaptureVideoDataOutput!
    var videoDataOutputQueue: DispatchQueue!
    var previewLayer:AVCaptureVideoPreviewLayer!
    var captureDevice : AVCaptureDevice!
    let session = AVCaptureSession()
    
    let navigationControllerMy = UINavigationController()
    
    let picker = UIImagePickerController()
    let titleCameraButton = TitleViewCamera()
    
    let photoImageView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .red
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.navigationController?.isNavigationBarHidden = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(presentCamera))
        self.navigationItem.title = "Photo"
        
        setupConstraints()
        setupPicker()
        
        
        /* ================================================================================== */
        
        previewView = UIView(frame: CGRect(x: 0,
                                           y: 0,
                                           width: UIScreen.main.bounds.size.width,
                                           height: UIScreen.main.bounds.size.height))
        previewView.contentMode = UIView.ContentMode.scaleAspectFit
        view.addSubview(previewView)

        //Add a view on top of the cameras' view
        boxView = UIView(frame: self.view.frame)

        myButton.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        myButton.backgroundColor = UIColor.red
        myButton.layer.masksToBounds = true
        myButton.setTitle("press me", for: .normal)
        myButton.setTitleColor(UIColor.white, for: .normal)
        myButton.layer.cornerRadius = 20.0
        myButton.layer.position = CGPoint(x: self.view.frame.width/2, y:200)
        myButton.addTarget(self, action: #selector(self.onClickMyButton(sender:)), for: .touchUpInside)

        view.addSubview(boxView)
        view.addSubview(myButton)

        self.setupAVCapture()
        
        /* ================================================================================== */
        
    }
    
    private func setupConstraints() {
        view.addSubview(photoImageView)
        
        // photoImageView constraints
        photoImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        photoImageView.image = img
//        uploadImageToNewsfeed(image: img)
        picker.dismiss(animated: true, completion: nil)
        
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
    
    @objc func presentCamera() {
        present(picker, animated: true, completion: nil)
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

    @objc func onClickMyButton(sender: UIButton){
        print("button pressed")
    }
    
}

extension CameraViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func setupPicker() {
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
    }
    
}

// AVCaptureVideoDataOutputSampleBufferDelegate protocol and related methods
extension CameraViewController:  AVCaptureVideoDataOutputSampleBufferDelegate {
    
     func setupAVCapture(){
        session.sessionPreset = AVCaptureSession.Preset.vga640x480
        guard let device = AVCaptureDevice
        .default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                 for: .video,
                 position: AVCaptureDevice.Position.back) else {
                            return
        }
        captureDevice = device
        beginSession()
    }

    func beginSession(){
        var deviceInput: AVCaptureDeviceInput!

        do {
            deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            guard deviceInput != nil else {
                print("error: cant get deviceInput")
                return
            }

            if self.session.canAddInput(deviceInput){
                self.session.addInput(deviceInput)
            }

            videoDataOutput = AVCaptureVideoDataOutput()
            videoDataOutput.alwaysDiscardsLateVideoFrames=true
            videoDataOutputQueue = DispatchQueue(label: "VideoDataOutputQueue")
            videoDataOutput.setSampleBufferDelegate(self, queue:self.videoDataOutputQueue)

            if session.canAddOutput(self.videoDataOutput){
                session.addOutput(self.videoDataOutput)
            }

            videoDataOutput.connection(with: .video)?.isEnabled = true

            previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect

            let rootLayer :CALayer = self.previewView.layer
            rootLayer.masksToBounds=true
            previewLayer.frame = rootLayer.bounds
            rootLayer.addSublayer(self.previewLayer)
            session.startRunning()
        } catch let error as NSError {
            deviceInput = nil
            print("error: \(error.localizedDescription)")
        }
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // do stuff here
    }

    // clean up AVCapture
    func stopCamera(){
        session.stopRunning()
    }

}
