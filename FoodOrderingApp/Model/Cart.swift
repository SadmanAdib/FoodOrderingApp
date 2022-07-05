//
//  Cart.swift
//  FoodOrderingApp
//
//  Created by Sadman Adib on 5/7/22.
//

import SwiftUI

struct Cart: Identifiable {
    
    var id = UUID().uuidString
    var item: Item
    var quantity: Int
    
}

//struct Cart_Previews: PreviewProvider {
//    static var previews: some View {
//        Cart()
//    }
//}
