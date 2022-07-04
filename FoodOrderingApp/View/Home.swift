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
        
        ZStack{
            VStack(spacing: 10){
                
                HStack(spacing: 15) {
                    
                    Button(action: {
                        withAnimation(.easeIn){
                            HomeModel.showMenu.toggle()
                        }
                    }, label: {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(Color.pink)
                    })
                    
                    Text(HomeModel.userLocation == nil ? "Locating..." : "Deliver To")
                        .foregroundColor(.black)
                    
                    
                    Text(HomeModel.userAddress)
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
               // .padding(.top,10)
                
                Divider()
                
                ScrollView(.vertical, showsIndicators: false, content:  {
                    VStack(spacing: 25){
                        ForEach(HomeModel.items){item in
                            
                            //Item view
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                
                                ItemView(item: item)
                                
                                HStack{
                                    
                                    Text("Free Delivery!")
                                        .foregroundColor(.white)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal)
                                        .background(.pink)
                                    
                                    Spacer(minLength: 0)
                                    
                                    Button(action: {}, label: {
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(.pink)
                                            .clipShape(Circle())
                                                            
                                    })
                                }
                                .padding(.trailing, 10)
                                .padding(.top, 10)
                            })
                            .frame(width: UIScreen.main.bounds.width - 30)
                                
                            
                            
                        }
                    }
                    .padding(.top, 10)
                })
            }
            
            // Side Menu
            
            HStack{
                
                Menu(homeData: HomeModel)
                    .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                
                Spacer(minLength: 0)
            }
            .background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
            // Closing menu when taps on outside area
                .onTapGesture(perform: {
                withAnimation(.easeIn){
                    HomeModel.showMenu.toggle()
                }
            })
            )
            
            // Non closable alert if permission denied
            
            if HomeModel.noLocation{
                Text("Please enable location in settings to continue...")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            
            }
        }
        
      
        .onAppear(perform: {
            
            //calling location delegate
            HomeModel.locationManager.delegate = HomeModel
            
        })
    
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
