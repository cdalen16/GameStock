//
//  Settings.swift
//  GameStock
//
//  Created by CS3714 on 4/20/21.
//

import SwiftUI
 
struct Settings: View {
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
   
    //user input
    @State private var passwordEntered = ""
    @State private var passwordVerified = ""
    //alerts
    @State private var showEnteredValues = false
    @State private var showUnmatchedPasswordAlert = false
    @State private var showPasswordSetAlert = false
    
    @State private var questionAnswer = ""
    
    @State private var depoAmount = 0.0
    @State private var showDepoAlert = false
    
    
    // Define formatter before it is used
        let costFormatter: NumberFormatter = {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.usesGroupingSeparator = true
            numberFormatter.groupingSize = 3
            return numberFormatter
        }()
   
    var amountDepoFormatter: Text {
        let inAmount = self.depoAmount
           
            // Add thousand separators to trip cost
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.usesGroupingSeparator = true
            numberFormatter.groupingSize = 3
           
            let amountString = "$" + numberFormatter.string(from: inAmount as NSNumber)!
            return Text(amountString)
        }
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Deposit Funds")){
                    HStack {
                        TextField("Enter amount", value: $depoAmount, formatter: costFormatter)
                                    .keyboardType(.numbersAndPunctuation)
                        
                        Button(action: {
                            //main user balance
                            let currAmount = UserDefaults.standard.double(forKey: "balance")
                            userData.userBalance = currAmount + self.depoAmount
                            UserDefaults.standard.set(self.depoAmount + currAmount, forKey: "balance")
                            
                            //total amount the user has added over the course of using the app
                            let currAddedAmount = UserDefaults.standard.double(forKey: "addedBalance")
                            userData.addedBalance = currAddedAmount + self.depoAmount
                            UserDefaults.standard.set(self.depoAmount + currAddedAmount, forKey: "addedBalance")
                            
                            showDepoAlert = true
                        }) {
                            Text("Deposit")
                        }                    }
                }//End of Section
                Section(header: Text("Show / Hide Entered Values")){
                    Toggle(isOn: $showEnteredValues) {
                        Text("Show Entered Values")
                            .font(.system(size: 14, weight: .medium))
                    }
                }//End of Section
                Section(header: Text("Select a Security Question")){
                    NavigationLink(destination: QuestionList()) {
                        HStack {
                            Text("Selected: ")
                                .font(.system(size: 14, weight: .medium))
                                .padding(.trailing, 10)
                            Text(userData.securityQ)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.gray)
                        }
                    }
                }//End of Section
                
                Section(header: Text("Enter Answer To Selcted Security Question")) {
                    HStack {
                        if self.showEnteredValues{
                            TextField("Enter Answer", text: $questionAnswer)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }else {
                            SecureField("Enter Answer", text: $questionAnswer)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                       
                        // Button to clear the text field
                        Button(action: {
                            self.questionAnswer = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                       
                    }   // End of HStack
                        .frame(minWidth: 300, maxWidth: 500)
                }//End of Section
                Section(header: Text("Enter Password")) {
                    HStack {
                        if self.showEnteredValues{
                            TextField("Enter Password", text: $passwordEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }else {
                            SecureField("Enter Password", text: $passwordEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                        }
                       
                        // Button to clear the text field
                        Button(action: {
                            self.passwordEntered = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                       
                    }   // End of HStack
                        .frame(minWidth: 300, maxWidth: 500)
                }//End of Section
                
                Section(header: Text("Verify Password")) {
                    HStack {
                        if self.showEnteredValues{
                            TextField("Verify Password", text: $passwordVerified)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }else {
                            SecureField("Verify Password", text: $passwordVerified)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                        }
                       
                        // Button to clear the text field
                        Button(action: {
                            self.passwordVerified = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                       
                    }   // End of HStack
                        .frame(minWidth: 300, maxWidth: 500)
                }//End of Section
                
                Section(header: Text("Set Password")) {
                    Button(action: {
                        if !passwordEntered.isEmpty {
                            if (passwordVerified != passwordEntered) {
                                self.showUnmatchedPasswordAlert = true
                            } else {
                                UserDefaults.standard.set(self.passwordEntered, forKey: "Password")
                                UserDefaults.standard.set(userData.securityQ, forKey: "Question")
                                UserDefaults.standard.set(self.questionAnswer, forKey: "QA")
                                
                                self.showPasswordSetAlert = true
                            }
                        }
                    }) {
                        Text("Set Password to Unlock App")
                            .frame(width: 275, height: 36, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.black, lineWidth: 1))
                    }
                    .frame(width:350, height: 40, alignment: .leading)
                }//End of Section
                .alert(isPresented: $showDepoAlert, content: { self.depoAlert})
                
            }  // End of Form
            .navigationBarTitle(Text("Settings"), displayMode: .large)
            .alert(isPresented: $showPasswordSetAlert, content: { self.passwordSetAlert })
        }//End of Nav View
        .alert(isPresented: $showUnmatchedPasswordAlert, content: { self.unmatchedPasswordAlert })
    }   // End of var
   
    /*
     --------------------------
     MARK: - Password Set Alert
     --------------------------
     */
    var passwordSetAlert: Alert {
        Alert(title: Text("Password Set!"),
              message: Text("Password you entered is set to unlock the app!"),
              dismissButton: .default(Text("OK")) {
                self.passwordVerified = ""
                self.passwordEntered = ""
                self.questionAnswer = ""
              })
    }
   
    /*
     --------------------------------
     MARK: - Unmatched Password Alert
     --------------------------------
     */
    var unmatchedPasswordAlert: Alert {
        Alert(title: Text("Unmatched Password!"),
              message: Text("Two entries of the password must match!"),
              dismissButton: .default(Text("OK")))
    }
    
    /*
     --------------------------
     MARK: - deposit alert
     --------------------------
     */
    var depoAlert: Alert {
        Alert(title: Text("Funds Deposited!"),
              message: Text("The amount of \(amountDepoFormatter) has been deposited to your account."),
              dismissButton: .default(Text("OK")) {
                self.showDepoAlert = false
              })
    }
}
 
struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings().environmentObject(UserData())
    }
}
 
