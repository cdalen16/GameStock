//
//  StockDetails.swift
//  GameStock
//
//  Created by Nahom  Atsbeha on 4/25/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI
import MapKit

struct StockDetails: View {
    let stockDet: StockStruct
    
    var body: some View {
        Form{
            Section(header: Text("Stock Name")){
                Text(stockDet.name)
            }
            Section(header: Text("Logo")){
                getImageFromUrl(url: stockDet.imgURL, defaultFilename: "")
            }
            Section(header: Text("Share Price")){
                Text("$\(String(stockDet.latestPrice))")
            }
            Section(header: Text("30 Days Low")){
                Text("$\(String(stockDet.low))")

            }
            Section(header: Text("30 Days High")){
                Text("$\(String(stockDet.high))")

            }
            Section(header: Text("Company Headquarters")){
                NavigationLink(destination: placeLocationOnMap ) {
                    Image(systemName: "mappin.and.ellipse")
                        .imageScale(.medium)
                        .font(Font.title.weight(.regular))
                        .foregroundColor(.blue)
                    Text("Show Trip Photo Location on Map")
                        .font(.system(size: 16))
                }
                .frame(minWidth: 300, maxWidth: 500, alignment: .leading)

            }
            Section(header: Text("Keep A Watch")){
                
            }
            Section(header: Text("Buy Stock")){
                
            }
            Section(header: Text("Amount of Shares")){
                
            }
            
            
            
        } // End of Form
        
    }
    
    var placeLocationOnMap: some View{
        
        let mapType = MKMapType.standard
            
        let lat = stockDet.latitude
        let longt = stockDet.longitude
        let title = stockDet.name
        
        return AnyView(MapView(mapType: mapType, latitude: lat, longitude: longt, delta: 10.0, deltaUnit: "degrees", annotationTitle: title, annotationSubtitle: ""))
            .navigationBarTitle(Text(title ?? ""), displayMode: .inline)
            .edgesIgnoringSafeArea(.all)

        
    }
}

struct StockDetails_Previews: PreviewProvider {
    static var previews: some View {
        StockDetails(stockDet: apiGetStockData(stockSymbol: "AAPL"))
    }
}
