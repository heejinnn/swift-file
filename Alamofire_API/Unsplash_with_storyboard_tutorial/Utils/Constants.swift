//
//  Constants.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 최희진 on 2023/04/15.
//

import Foundation

enum SEGUE_ID{
    static let USER_LIST_VC = "goToUserListVC"
    static let PHOTO_COLLECTION_VC = "goToPhotoCollectionVC"
}

enum API {
    static let BASE_URL : String = "https://api.unsplash.com/"
    static let CLIENT_ID : String = "2wdGFppe0iViLiW01XMTROZJ3RZ-MIoYfRdZLeGkSnw"
}

enum NOTIFICATION{
    enum API {
        static let AUTH_FAIL = "authentication_fail"
    }
}
