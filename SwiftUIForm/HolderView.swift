//
//  Holder.swift
//  SwiftUIForm
//
//  Created by Jose on 24/4/24.
//

import SwiftUI

struct HolderView: View {
    
    @EnvironmentObject private var authModel: AuthViewModel
    
    var body: some View {
        Group{
            if authModel.user == nil {
                SignUpView()
            } else {
                let almacenInicial = SettingStore()
                let viewModel = RestaurantViewModel(almacen: SettingStore())
                ContentView(viewModel: viewModel).environmentObject(almacenInicial)
            }
        }
            .onAppear {
            authModel.listenToAuthState()
        }
    }

}

struct HolderView_Previews: PreviewProvider {
    static var previews: some View {
        HolderView()
    }
}
