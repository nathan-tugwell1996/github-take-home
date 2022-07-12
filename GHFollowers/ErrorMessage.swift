//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Nathan Tugwell on 12/07/2022.
//

import Foundation
enum ErrorMessage: String {
    case invalidUsername = "This username is incorrect, please try again."
    case unableToComplete = "Unable to complete request. Please check your internet"
    case invalidResponse = "Invalid Response from the server, Please try again."
    case invalidData = "The data received from the server was invalid, please try again."
}
