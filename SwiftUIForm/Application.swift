//
//  Application.swift
//  SwiftUIForm
//
//  Created by Jose on 29/4/24.
//

import Foundation
import SwiftUI
import UIKit

final class Application_utility{
    
    static var rootViewController:UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        return root
    }
}

