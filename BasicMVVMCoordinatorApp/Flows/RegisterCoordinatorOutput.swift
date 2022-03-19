//
//  RegisterCoordinatorOutput.swift
//  Foodak
//
//  Created by Batoul Issa on 1/19/21.
//  Copyright © 2021 Ideatolife. All rights reserved.
//

protocol RegisterCoordinatorOutput: AnyObject {
    var finishFlow: ((RegisterStartingPoint?) -> Void)? { get set }
}
