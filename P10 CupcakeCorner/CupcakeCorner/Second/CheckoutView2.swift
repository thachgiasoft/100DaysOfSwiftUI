//
//  CheckoutView2.swift
//  CupcakeCorner
//
//  Created by Jason on 11/18/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import SwiftUI

struct CheckoutView2: View {
    @ObservedObject var order: Order2
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var networkAlert: Alert {
        Alert(title: Text("Uh oh."), message: Text("No Network"), dismissButton: .default(Text("Fine.")))
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        /* P15 - Challenge 1
                        The check out view in Cupcake Corner uses an image that doesn’t add anything to the UI, so find a way to make the screenreader not read it out.
                        */
                        .accessibility(removeTraits: .isImage)
                    
                    Text("Your order costs: $\(self.order.orderInfo.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        self.placeOrder()
                    }
                .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text(confirmationTitle), message: Text(confirmationMessage), dismissButton: .default(Text("Ok")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.orderInfo) else {
            print("Failed to encode data")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data else {
                // Challenge 2
                self.confirmationTitle = "Uh oh."
                self.confirmationMessage = "No network connection, son."
                self.showingConfirmation = true
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderInfo.types[decodedOrder.type].lowercased()) cupcakes is on it's way and will cost $\(decodedOrder.cost)"
                self.confirmationTitle = "Thank you!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server.")
            }
            
            
        }.resume()
    }
}

struct CheckoutView2_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView2(order: Order2())
    }
}
