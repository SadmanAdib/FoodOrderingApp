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
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    
                    TextField("Search", text: $HomeModel.search)
                    
                    
                }
                .padding(.horizontal)
                // .padding(.top,10)
                
                Divider()
                
                ScrollView(.vertical, showsIndicators: false, content:  {
                    VStack(spacing: 25){
                        ForEach(HomeModel.filtered){item in
                            
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
                                    
                                    Button(action: {
                                        HomeModel.addToCart(item: item)
                                    }, label: {
                                        Image(systemName: item.isAdded ? "checkmark" : "plus")
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(item.isAdded ? .green : .pink)
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
            
            // Side Menu...
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
        .onChange(of: HomeModel.search ) { value in
            //to avoid continous search requests...
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                if value == HomeModel.search && HomeModel.search != ""{
                    
                    //search data...
                    
                    HomeModel.filterData()
                } 
            }
            
            if HomeModel.search == ""{
                //reset all data...
                withAnimation(.linear){
                    HomeModel.filtered = HomeModel.items
                }
            }
            
        }
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
