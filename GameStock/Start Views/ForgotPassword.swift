//
//  ForgotPassword.swift
//  GameStock
//
//  Created by CS3714 on 4/20/21.
//

import SwiftUI


struct ForgotPassword: View {
    //environment
    @EnvironmentObject var userData: UserData
    
    //user input
    @State private var showEnteredValues = false
    @State private var questionAnswer = ""
    let validQ = ""
    let validA = ""
    
    var body: some View {
        Form {
            Section(header: Text("Show / Hide Entered Values")){
                Toggle(isOn: $showEnteredValues) {
                    Text("Show Entered Values")
                        .font(.system(size: 14, weight: .medium))
                }
            }
            Section(header: Text("Security Question")){
                if let validQ = UserDefaults.standard.string(forKey: "Question") as String? {
                    Text(validQ)
                }
                
            }
            Section(header: Text("Enter Answer To Selected Security Question")) {
                if self.showEnteredValues{
                    TextField("Enter Answer", text: $questionAnswer)
                        .disableAutocorrection(true)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                }else {
                    SecureField("Enter Answer", text: $questionAnswer)
                        .disableAutocorrection(true)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
            }
            if let validA = UserDefaults.standard.string(forKey: "QA") as String? {
                if (self.questionAnswer != validA) {
                    Section(header: Text("Incorrect Answer")){
                        Text("Answer to the Security Question is Incorrect")
                    }
                }//end if
                else {
                    Section(header: Text("Go to Settings to Reset Password")){
                        NavigationLink(destination: Settings()) {
                            HStack {
                                Image(systemName: "gear")
                                Text("Show Settings")
                            }
                        }
                    }
                }
            }
            
        }//End Form
        .navigationBarTitle(Text("Password Reset"), displayMode: .inline)
    }//End body
    
}

struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPassword().environmentObject(UserData())
    }
}
