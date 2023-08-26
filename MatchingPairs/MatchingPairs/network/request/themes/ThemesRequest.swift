//
//  ThemesRequest.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import Foundation

enum ThemesRequest: RequestProtocol {
    case getThemes
    
    var path: String {
        "/v0/b/concentrationgame-20753.appspot.com/o/themes.json?alt=media"
    }
    
    var requestType: RequestType {
        .GET
    }
}
