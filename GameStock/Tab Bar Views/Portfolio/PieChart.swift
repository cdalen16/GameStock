//
//  PieChart.swift
//  GameStock
//
//  Created by CS3714 on 4/27/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import Foundation

import SwiftUI



struct PieChart : View {
    var body: some View {
        GeometryReader{g in
            ZStack {
                ForEach(0..<data.count) {i in
                    Draw(center: CGPoint(x: g.frame(in: .global).width / 2, y: g.frame(in: .global).height / 2), index: i)
                }
            }
        }
        .frame(height: 360)
        .padding(.top, 20)
        .clipShape(Circle())
        .shadow(radius: 8)
        
        VStack {
            ForEach(data) {aData in
                HStack {
                    Text(aData.name)
                        .frame(width: 100)
                        .offset(y: -45)
                    
                    GeometryReader{g in
                        HStack {
                            
                            Spacer(minLength: 0)
                            
                            Rectangle()
                                .fill(aData.color)
                                .frame(width: self.getWidth(width: g.frame(in: .global).width, value: aData.percent), height: 10)
                            
                            Text(String(format: "\(aData.percent)", "%.0f"))
                                .fontWeight(.bold)
                                .padding(.leading, 10)
                        }
                    }
                }
                .padding(.top, 18)
            }
        }
        .padding()
       
        
    }
    
    func getWidth(width: CGFloat, value: CGFloat) -> CGFloat {
        let t = value / 100
        return t * width
    }
    
   
}

struct PieElement: Identifiable {
    var id: UUID
    var percent: CGFloat
    var color: Color
    var name: String
}
struct Draw : View {
    var center: CGPoint
    var index : Int
    var body: some View {
        Path{path in
            path.move(to: self.center)
            path.addArc(center: self.center, radius: 180, startAngle: .init(degrees: self.startAngle()),
                        endAngle: .init(degrees: self.endAngle()), clockwise: false)
        }
        .fill(data[index].color)
    }
    
    func startAngle() -> Double {
        
        if index == 0 {
            return 0
        }
        
        var t: Double = 0
        for i in 0...index-1 {
            t += Double(data[i].percent / 100) * 360
            
        }
        return t
    }
    
    func endAngle() -> Double {
        var t: Double = 0
        for i in 0...index {
            t += Double(data[i].percent / 100) * 360
            
        }
        return t
    }
}
var data = [
    PieElement(id: UUID(), percent: 75, color: Color.red, name: "Test1"),
    PieElement(id: UUID(), percent: 25, color: Color.yellow, name: "Test2")
]
