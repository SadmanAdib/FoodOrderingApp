//
//  CartView.swift
//  FoodOrderingApp
//
//  Created by Sadman Adib on 5/7/22.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var homeData: HomeViewModel
    @Environment(\.presentationMode) var present
    var body: some View {
        VStack {
            
            HStack(spacing: 20){
                Button(action: {present.wrappedValue.dismiss()}){
                    Image(systemName: "chevron.left")
                        .font(.system(size: 26, weight: .heavy))
                        .foregroundColor(.pink)
                }
                
                Text("My Cart")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer()
                
            }
            .padding()
            
            ScrollView(.vertical, showsIndicators: false){
                
                LazyVStack(spacing: 0){
                    
                    ForEach(homeData.cartItems){ item in
                        
                        Text(item.item.item_name)
                        
                    }
                    
                }
                
            }
            
            //Bottom View
            
            VStack{
                
                HStack{
                    Text("Total")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    //Calulcating Total Price
                    Text(homeData.calculateTotalPrice())
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                }
                .padding([.top, .horizontal])
                
                Button(action: {}){
                    
                    Text("Check Out")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(
                            LinearGradient(gradient: .init(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(15)
                }
            }
            .background(Color.white)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView()
//    }
//}
