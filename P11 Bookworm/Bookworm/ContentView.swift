//
//  ContentView.swift
//  Bookworm
//
//  Created by Jason on 11/19/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Fundamentals")) {
                    NavigationLink("Creating a custom component with @Binding", destination: CustomComponent())
                    NavigationLink("Using size classes with AnyView type erasure", destination: UsingAnyView())
                    NavigationLink("How to combine Core Data and SwiftUI", destination: UsingCoreData())
                }
                
                Section(header: Text("Main")) {
                    NavigationLink("Bookworm Application", destination: Application())
                }
            }
        .navigationBarTitle("P11 - Bookworm")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
