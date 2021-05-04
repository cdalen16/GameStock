//
//  Home.swift
//  GameStock
//
//  Created by CS3714 on 4/20/21.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var userData: UserData
    //let quote: QuoteStruct

    var body: some View {
        
        NavigationView {

        ZStack{
            //Color(red: 11/255.0,green: 15/255.0, blue: 128/255.0).edgesIgnoringSafeArea(.all)
            Color(red: 227/255, green: 228/255, blue: 223/255).edgesIgnoringSafeArea(.all)
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    Image("GameStock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        //.frame(minWidth: 300, maxWidth: 600)
                        //.padding(.trailing, 30)
                    
                            NavigationLink(destination: HotStocksList()){
                                HStack{
                                    Text("Hottest Stocks \("\n") Right Now")
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 20))
                                        .italic()

                                    Image(systemName: "flame.fill")
                                        .foregroundColor(.red)
                                        .imageScale(.large)
                                }
                                .frame(width: 200, height: 50)
                                .background(Color(.blue))
                                .font(Font.title.weight(.bold))
                                .cornerRadius(10)


                            }
                            .padding()
                    NavigationLink(destination: NewsList()){
                        HStack{
                            Text("What's on the news Today")
                                .foregroundColor(Color.black)
                                .font(.system(size: 20))
                                .italic()
                            
                            Image(systemName: "newspaper")
                                .foregroundColor(.red)
                                .imageScale(.large)
                        }
                        .frame(width: 200, height: 50)
                        .background(Color(.blue))
                        .cornerRadius(10)
                        .font(Font.title.weight(.bold))
                    }
                    
                    .padding()
                    .padding()
                    .padding()
                    .padding()
                    .padding()
                    
                    VStack{
                        Text("\(userData.getAQuote().text)")
                            .frame(alignment: .center)
                        Text(userData.getAQuote().from)
                    }
                    .font(.system(size: 14))
                    
                    
                    
                } //End of VStack
            } // End of scrollview

        } // End of ZStack
        }// End of NavigationView
        .customNavigationViewStyle()


    }   // End of body
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(UserData())
    }
}
