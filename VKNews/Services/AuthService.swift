//
//  AuthService.swift
//  CreatingViews
//
//  Created by Глеб on 12.10.2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate : class {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appID = "7165318"
    private let vkSdk : VKSdk
    private let vkTest = VKShareDialogController()
    
    weak var delegate : AuthServiceDelegate?
    
    var token : String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    var userId : String? {
        return VKSdk.accessToken()?.userId
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appID)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func test() {
        //  Converted to Swift 5.1 by Swiftify v5.1.30744 - https://objectivec2swift.com/
        let photoRequest = VKApi.uploadWallPhotoRequest(UIImage(named: "search"), parameters: VKImageParameters.pngImage(), userId: Int((VKSdk.accessToken()?.userId)!)!, groupId: 0)
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
    
    func wakeUpSession() {
        
        let scope = ["wall", "friends", "video", "photos"]
        
        VKSdk.wakeUpSession(scope) { [myDelegate = delegate] (state, error) in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
                myDelegate?.authServiceSignIn()
                //self.test()
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                VKSdk.authorize(scope)
            } else {
                print("auth problems, state: \(state), error: \(String(describing: error))")
                myDelegate?.authServiceDidSignInFail()
            }
        }
        
    }
    
    // MARK: VKSdkDelegate
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    // MARK: VKSdkUIDelegate
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        
        delegate?.authServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }

}

