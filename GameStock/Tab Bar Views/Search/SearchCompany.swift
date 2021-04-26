//
//  SearchCompany.swift
//  GameStock
//
//  Created by CS3714 on 4/25/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import SwiftUI

struct SearchCompany: View {
    
    @State private var searchFieldValue = ""
    @State private var showSearchFieldEmptyAlert = false
    @State private var searchCompleted = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header:
                    Text("Enter Company Stock Symbol to Search")
                        .padding(.top, 100)   // Put padding here to preserve form's background color
                ) {
                    HStack {
                        TextField("Enter Stock Symbol", text: $searchFieldValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.allCharacters)
                            .disableAutocorrection(true)
                            .frame(width: 240, height: 36)
                        
                        // Button to clear the text field
                        Button(action: {
                            self.searchFieldValue = ""
                            self.showSearchFieldEmptyAlert = false
                            self.searchCompleted = false
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                            .alert(isPresented: $showSearchFieldEmptyAlert, content: { self.searchFieldEmptyAlert })
                        
                    }   // End of HStack
                        .padding(.horizontal)
                }
                Section(header: Text("Search Company")) {
                    HStack {
                        Button(action: {
                            // Remove spaces, if any, at the beginning and at the end of the entered search query string
                            let queryTrimmed = self.searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            if (queryTrimmed.isEmpty) {
                                self.showSearchFieldEmptyAlert = true
                            } else {
                                self.searchApi()
                                self.searchCompleted = true
                            }
                        }) {
                            Text(self.searchCompleted ? "Search Completed" : "Search")
                        }
                            .frame(width: 240, height: 36, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.black, lineWidth: 1)
                            )
                    }   // End of HStack
                        .padding(.horizontal)
                }
                if searchCompleted {
                    Section(header: Text("Show Company Details")) {
                        NavigationLink(destination: showSearchResults) {
                            HStack {
                                Image(systemName: "list.bullet")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                    .foregroundColor(.blue)
                                Text("Show Company Details")
                                    .font(.system(size: 16))
                            }
                        }
                    }
                }
                
            }   // End of Form
                .navigationBarTitle(Text("Search a Company"), displayMode: .inline)
            
        }   // End of NavigationView
            .customNavigationViewStyle()  // Given in NavigationStyle.swift
        
    }   // End of body
    
    func searchApi() {
        
        // public func obtainCompanyDataFromApi is given in CompanyDataFromApi.swift
        apiGetStockData(stockSymbol: self.searchFieldValue)
    }
    
    var showSearchResults: some View {
        
//        let name = companyDataDictionaryFromApi["companyName"] as! String
//        if name.isEmpty {
//            return AnyView(NotFoundMessage(stockSymbol: self.searchFieldValue))
//        }
        
        return AnyView(SearchResult(stockSymbol: self.searchFieldValue))
    }
    
    var searchFieldEmptyAlert: Alert {
        Alert(title: Text("The Stock Symbol Field is Empty!"),
              message: Text("Please enter a stock symbol!"),
              dismissButton: .default(Text("OK")))
    }
    
}

struct SearchCompany_Previews: PreviewProvider {
    static var previews: some View {
        SearchCompany()
    }
}
