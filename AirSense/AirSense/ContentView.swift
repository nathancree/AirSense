//
//  ContentView.swift
//  AirSense
//
//  Created by Nathan Cree on 9/14/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        HomeView(homevm: vm)
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
