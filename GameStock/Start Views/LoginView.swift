//
//  Created by CS3714 on 3/14/21.
//  Copyright © 2021 Campbell Dalen. All rights reserved.
//
import LocalAuthentication
import SwiftUI
 
struct LoginView : View {
   
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
   
    //user input
    @State private var enteredPassword = ""
    @State private var showInvalidPasswordAlert = false
    @State private var isUnlocked = false
    
   
    var body: some View {
        // Retrieve the password from the user’s defaults database under the key "Password"
        let validPassword = UserDefaults.standard.string(forKey: "Password")
        
        NavigationView{
            ZStack {
                Color(red: 227/255, green: 228/255, blue: 223/255).edgesIgnoringSafeArea(.all)
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Image("GameStock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 300, maxWidth: 600)
                        .padding(.trailing, 30)
//                        .padding(.top, 30)
                   
                    SecureField("Password", text: $enteredPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300, height: 36)
                        .padding()
                    
                    HStack {
                        Button(action: {
                           //checks if password has been set
                            if validPassword == nil || self.enteredPassword == validPassword {
                                userData.userAuthenticated = true
                                self.showInvalidPasswordAlert = false
                            } else {
                                self.showInvalidPasswordAlert = true
                            }
                           
                        }) {
                            Text("Login")
                                .frame(width: 100, height: 36, alignment: .center)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(Color.black, lineWidth: 1)
                                )
                        }
                        .alert(isPresented: $showInvalidPasswordAlert, content: { self.invalidPasswordAlert })
                        
                        if (validPassword != nil) {
                            NavigationLink(destination: ForgotPassword()) {
                                Text("Forgot Password")
                                        .foregroundColor(.blue)
                                        .frame(width: 175, height: 36, alignment: .center)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                            .strokeBorder(Color.black, lineWidth: 1))
                            }
                            .padding(.leading, 70)
                        } //End of if
                    } //End of HStack
                    .frame(width:350, height: 40, alignment: .leading)
                }   // End of VStack
            }   // End of ScrollView
            }   // End of ZStack
            .onAppear(perform: {
                authenticate()
            })
        }
        
    }   // End of var
   
    /*
     ------------------------------
     MARK: - Invalid Password Alert
     ------------------------------
     */
    var invalidPasswordAlert: Alert {
        Alert(title: Text("Invalid Password!"),
              message: Text("Please enter a valid password to unlock the app!"),
              dismissButton: .default(Text("OK")) )
       
        // Tapping OK resets @State var showInvalidPasswordAlert to false.
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                        self.userData.userAuthenticated = true
                    } else {
                        // there was a problem
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
}
 
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

