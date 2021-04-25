//
//  QuestionList.swift
//  GameStock
//
//  Created by CS3714 on 4/20/21.
//

import SwiftUI

let questions = ["In what city or town were you born?", "What did you want to be when you grew up?", "What is the name of the first school you attended?", "What is the name of your favorite childhood friend?", "What is the name of your first pet?", "What is your mother's maiden name?"]

struct QuestionList: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        List {
            ForEach(0 ..< questions.count, id: \.self)
            { item in
                Button(action: {    // Button 1
                    //sets user selected ingredient when clicked
                    userData.securityQ = questions[item]

                }) {
                    HStack {
                        Text(questions[item])
                            .frame(width: 320, height: 30, alignment: .leading)
                            .font(.system(size: 12, weight: .medium))
                            .padding(.trailing, 15)
                        
                        if (questions[item] == userData.securityQ) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                                .frame(width: 10, height: 10, alignment: .trailing)
                        }
                    }//End of Hstack
                }
            }//foreach
        } //list

    }
}

struct QuestionList_Previews: PreviewProvider {
    static var previews: some View {
        QuestionList()
    }
}
