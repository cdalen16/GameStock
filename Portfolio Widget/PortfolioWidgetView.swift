//
//  PortfolioWidgetView.swift
//  Portfolio WidgetExtension
//
//  Created by CS3714 on 5/3/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI

struct PortfolioWidgetView: View {
    
    let stock: StockStruct
    
    var body: some View {
        ZStack {
            Color(UIColor.systemIndigo)
            VStack {
                
                Text(stock.name)
                    .padding()
                Text(String(stock.latestPrice))
                if stock.percentChange > 0 {
                    Text("\(String(format: "%.2f", stock.percentChange * 100))%")
                        .foregroundColor(.green)
                } else {
                    Text("\(String(format: "%.2f", stock.percentChange * 100))%")
                        .foregroundColor(.red)
                }
            }
        }
        
    }
}

struct PortfolioWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioWidgetView(stock: apiGetStockData(stockSymbol: "AAPL"))
    }
}
