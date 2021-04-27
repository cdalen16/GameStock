//
//  StockDetails.swift
//  GameStock
//
//  Created by Nahom  Atsbeha on 4/25/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUICharts
import SwiftUI
import MapKit

struct StockDetails: View {
    let stockDet: StockStruct
    @State var purchaseAmount = 0
    @State private var showStockBoughtAlert = false
    
    var body: some View {

        Form{
            
            Section(header: Text("Company And Stock Name")){
                VStack{
                    Text(stockDet.name)
                    Text(stockDet.symbol)
                }
                
            }
            Section(header: Text("Logo")){
                getImageFromUrl(url: stockDet.imgURL, defaultFilename: "")
            }
            Section(header: Text("Historical Data")){
                LineView(data: getDoubleArrayForChart(Symbol: stockDet.symbol), title: "Line Chart")
                    .frame(width: 300, height: 400, alignment: .center)

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
                    Text("Show Company Location on Map")
                        .font(.system(size: 16))
                }
                .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
                
            }
            Section(header: Text("Keep A Watch")){
                
            }
            Section(header: Text("Buy Stock")){
                VStack {
                    HStack {
                        //minus button
                        Button(action: {
                            if purchaseAmount > 0 {
                                //purchaseAmount -= 1
                                print(purchaseAmount)
                            }
                        }) {
                            Image(systemName: "minus.square")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40)
                                .foregroundColor(.blue)
                        }
                        
                        //buy stock button
                        Button(action: {
                            let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                            let StockEntity = Stock(context: managedObjectContext)
                            let CompanyEntitry = Company(context: managedObjectContext)
                            let PhotoEntity = Photo(context: managedObjectContext)
                            
                            StockEntity.high = stockDet.high as NSNumber
                            StockEntity.low = stockDet.low as NSNumber
                            StockEntity.percentChange = stockDet.percentChange as NSNumber
                            StockEntity.isMarketOpen = stockDet.isMarketOpen as NSNumber
                            StockEntity.label = stockDet.label
                            StockEntity.latestPrice = stockDet.latestPrice as NSNumber
                            StockEntity.primaryExchange = stockDet.primaryExchange
                            StockEntity.symbol = stockDet.symbol
                            StockEntity.numberPurchased = purchaseAmount as NSNumber
                            
                            CompanyEntitry.hqLatitude = stockDet.latitude as NSNumber
                            CompanyEntitry.hqLongitude = stockDet.longitude as NSNumber
                            CompanyEntitry.name = stockDet.name as String
                            
                            PhotoEntity.imageUrl = stockDet.imgURL
                            
                            StockEntity.company = CompanyEntitry
                            CompanyEntitry.stock = StockEntity
                            CompanyEntitry.photo = PhotoEntity
                            PhotoEntity.company = CompanyEntitry
                            // ❎ CoreData Save operation
                            do {
                                try managedObjectContext.save()
                            } catch {
                                print("ERROR! Can't save Item to Core Db")
                            }
                            
                            showStockBoughtAlert = true
                            
                        }) {
                            Text("Buy \(purchaseAmount) Stock")
                        }
                        .frame(width: 240, height: 36, alignment: .center)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(Color.black, lineWidth: 1)
                        )
                        
                        //plus button
                        Button(action: {
                            purchaseAmount += 1
                            print(purchaseAmount)
                        }) {
                            Image(systemName: "plus.app")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40)
                                .foregroundColor(.blue)
                        }
                        
                    }
                    
                }
                
            }
            Section(header: Text("Amount of Shares")){
                
            }
        } .alert(isPresented: $showStockBoughtAlert, content: { self.stockBoughtAlert })
    }
   
    func getDoubleArrayForChart(Symbol: String) -> [Double] {
        var arrayResults = [Double]()
        
        let dataArray = apiGetStockChart(stockSymbol: Symbol, Duration: "1m")
                

        
        for time in dataArray {
            
            arrayResults.append(time.fClose)

        }
        
        
        print(arrayResults)
        return arrayResults
    }
    var placeLocationOnMap: some View{
        
        let mapType = MKMapType.standard
        
        let lat = stockDet.latitude
        let longt = stockDet.longitude
        let title = stockDet.name
        
        return AnyView(MapView(mapType: mapType, latitude: lat, longitude: longt, delta: 10.0, deltaUnit: "degrees", annotationTitle: title, annotationSubtitle: ""))
            .navigationBarTitle(Text(title ), displayMode: .inline)
            .edgesIgnoringSafeArea(.all)
    }
    var stockBoughtAlert: Alert {
        Alert(title: Text("Stock Bought!"),
              message: Text("You have bought \(purchaseAmount) shares of \(stockDet.symbol) stock!"),
              dismissButton: .default(Text("OK")) )
    }

}

struct StockDetails_Previews: PreviewProvider {
    static var previews: some View {
        StockDetails(stockDet: apiGetStockData(stockSymbol: "AAPL"))
    }
}
