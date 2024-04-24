//
//  ContentView.swift
//  SwiftUIForm
//
//  Created by Simon Ng on 19/8/2020.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: RestaurantViewModel
   
    var body: some View {
        NavigationView {
             List {
                //Ahora llamamos a los restaurantes a través del ViewModel
                 ForEach(viewModel.restaurantsDB.sorted(by:viewModel.almacen.displayOrder.predicate())){  restaurant in
                 
                    if viewModel.shouldShowItem(restaurant: restaurant) {
                    BasicImageRow(restaurant: restaurant)
                        .contextMenu {
                            
                            Button(action: {
                                // mark the selected restaurant as check-in
                                viewModel.toggleCheckIn(item:restaurant)
                                viewModel.fetchRestaurants()
                            }) {
                                HStack {
                                    Text("Check-in")
                                    Image(systemName: "checkmark.seal.fill")
                                }
                            }
                            
                            Button(action: {
                                // delete the selected restaurant
                                viewModel.delete(restaurant: restaurant)
                                viewModel.fetchRestaurants()
                            }) {
                                HStack {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                }
                            }
                                             
                            Button(action: {
                                // mark the selected restaurant as favorite
                                viewModel.toggleFavorite(restaurant: restaurant)
                                viewModel.fetchRestaurants()
                                
                            }) {
                                HStack {
                                    Text("Favorite")
                                    Image(systemName: "star")
                                }
                            }
                        }
                       .onTapGesture {
                            viewModel.selectedRestaurant = restaurant
                        }
                  }
                }
             .onDelete { (indexSet) in
                    viewModel.restaurantsDB.remove(atOffsets: indexSet)
                }
            }
            
            .navigationBarTitle("Restaurant")
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {
                        viewModel.showSettings = true
                    }) {
                        Image(systemName: "gear")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {
                        viewModel.fetchRestaurants() // Recarga restaurantes de firebase
                    }) {
                        Image(systemName: "arrow.clockwise.circle")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
            )
            .sheet(isPresented: $viewModel.showSettings) {
                SettingView().environmentObject(viewModel.almacen)
            }
        }
        .onAppear {
                    viewModel.fetchRestaurants() //Carga inicial de restaurantes de Firebase
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SettingStore())
    }
}*/
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        // Crear una instancia de RestaurantViewModel y pasar el SettingStore
        //let viewModel = RestaurantViewModel(almacen: viewModel.)
        
        // Configurar la vista de previsualización con el viewModel y el store
        return ContentView(viewModel: RestaurantViewModel())
            .environmentObject(self.viewModel.almacen) // Pasar SettingStore como EnvironmentObject
    }
}*/


}
