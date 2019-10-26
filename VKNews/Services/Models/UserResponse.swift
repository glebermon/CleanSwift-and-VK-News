//
//  UserResponse.swift
//  VKNews
//
//  Created by Глеб on 24.10.2019.
//  Copyright © 2019 Глеб. All rights reserved.
//

import UIKit

struct UserResponseWrapped : Decodable {
    let response : [UserResponse]
}

struct UserResponse : Decodable {
    let photo100 : String?
}
