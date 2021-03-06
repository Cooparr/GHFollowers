//
//  GFError.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 27/11/2020.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data recieved from the server was invalid. Please try again."
    case unableToFavorite = "Could not favorite user. Please try again."
    case alreadyInFavorites = "This user is already a favorite."
}
