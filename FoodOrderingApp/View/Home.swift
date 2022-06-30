//
//  Home.swift
//  FoodOrderingApp
//
//  Created by Sadman Adib on 30/6/22.
//

import SwiftUI

struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    
    var body: some View {
        
        VStack(spacing: 10){
            
            HStack(spacing: 15) {
                
                Button(action: {}, label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(Color.pink)
                })
                
                Text("Deliver To")
                    .foregroundColor(.black)
                
                Text("Apple")
                    .font(.caption)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.pink)
                
                Spacer(minLength: 0)
                
            }
            .padding([.horizontal, .top])
            
            Divider()
            
            HStack(spacing: 15) {
                
                TextField("Search", text: $HomeModel.search)
                
                if HomeModel.search != "" {
                    Button(action: {}, label: {
                        
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                    })
                    .animation(.easeIn, value: 0)
                    
                }
                
            }
            .padding(.horizontal)
            .padding(.top,10)
            
            Divider()
            
            Spacer()
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
