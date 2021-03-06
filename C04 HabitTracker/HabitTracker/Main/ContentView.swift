//
//  ContentView.swift
//  HabitTracker
//
//  Created by Jason on 11/22/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var activities = Activities()
    
    @State private var showingNewHabit = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Add Habit") {
                    self.showingNewHabit = true
                }
                
                List {
                    ForEach(activities.items.indices, id: \.self) { idx in
                        NavigationLink(destination: ActivityView(activity: self.$activities.items[idx])) {
                            Text(self.activities.items[idx].name)
                        }
                    }
                .onDelete(perform: removeHabit)
                }
            }
            .navigationBarTitle("Habit Tracker")
        .padding()
        }
        .sheet(isPresented: $showingNewHabit) {
            AddActivity(activities: self.activities)
        }
    }
    
    func removeHabit(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
