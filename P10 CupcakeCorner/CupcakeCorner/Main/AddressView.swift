//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Jason on 11/16/19.
//  Copyright © 2019 Jason. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
