//
//  GoogleSignInService.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-19.
//

import GoogleSignIn

class GoogleSignInService {
    private init() { }

    static func configureGID() -> GIDConfiguration {
        let signInConfig: GIDConfiguration
        #if DEVELOPMENT
        signInConfig = GIDConfiguration(clientID: Constants.devGoogleOAuthClientID)
        #else
        signInConfig = GIDConfiguration(clientID: Constants.releaseGoogleOAuthClientID)
        #endif
        return signInConfig
    }
}
