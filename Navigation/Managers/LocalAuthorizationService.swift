//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Dima Gorbachev on 23.10.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import LocalAuthentication

final class LocalAuthorizationService  {
    
    static var shared = LocalAuthorizationService()
    
    private var context = LAContext()
    private let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
    private var error: NSError?
    private var canUseBiometrics = false
    
    private init() {
        canUseBiometrics = context.canEvaluatePolicy(policy, error: &error)
    }
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        
        guard canUseBiometrics else { return }
        context.evaluatePolicy(policy, localizedReason: "getAuth".localized) { success, error in
            DispatchQueue.main.async {
                if success {
                    authorizationFinished(self.canUseBiometrics)
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
