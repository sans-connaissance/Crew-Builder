//
//  CBErrors.swift
//  Crew Builder
//
//  Created by David Malicke on 6/20/22.
//

import Foundation

enum CBError: String, Error {
    case invalidUserName = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data from the server is invalid. Please try again."
    case unableToAddToCrew = "There was an error adding this person to your crew. Please try again."
    case alreadyInCrew = "You already have this person in your crew. "
}
