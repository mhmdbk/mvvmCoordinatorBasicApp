//
//  RegisterCoordinatorOutput.swift
//  BasicMVVMCoordinatorApp
//
//  Created by MohammadBarek on 2022-03-07.
//

protocol RegisterCoordinatorOutput: AnyObject {
    var finishFlow: ((RegisterStartingPoint?) -> Void)? { get set }
}
