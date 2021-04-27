//
//  StockItem.swift
//  GameStock
//
//  Created by CS3714 on 4/25/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI

struct StockItem: View {
    
    let stock: StockStruct
    
    var body: some View {
        HStack(spacing: 20) {
            getImageFromUrl(url: stock.imgURL, defaultFilename: "")
                .resizable()
                .frame(width: 80.0, height: 80.0, alignment: .leading)
                
            VStack {
                Text(stock.name)
//                Text(stock.symbol)
            }
            .frame(width: 120, height: 50, alignment: .leading)
            .padding(.trailing, 10)
            .padding(.leading, 10)
            VStack {
                Text("$\(String(stock.latestPrice))")
                if stock.percentChange > 0 {
                    Text("\(String(format: "%.2f", stock.percentChange * 100))%")
                        .foregroundColor(.green)
                       
                } else {
                    Text("\(String(format: "%.2f", stock.percentChange * 100))%")
                        .foregroundColor(.red)
                        
                }
            }
//            .frame(maxWidth: .infinity)
            .frame(width: 80, height: 50, alignment: .leading)
            
        }.alignmentGuide(.trailing) {d in d[.trailing]}
    }
}

struct StockItem_Previews: PreviewProvider {
    static var previews: some View {
        StockItem(stock: apiGetStockData(stockSymbol: "AAPL"))
    }
}
