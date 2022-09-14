//
//  LoginForm.swift
//  TodoBox
//
//  Created by Ayush Kumar on 1/22/22.
//

import SwiftUI
import Firebase

struct LoginForm: View {
    @State var email: String = ""
    @State var password: String = ""

    @State var token: String = ""
    @State var loggedIn: Bool = false

    init() {
        FirebaseApp.configure()
    }

    var body: some View {
        Form {
            TextField("Email", text: $email)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)

            SecureField("Password", text: $password)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)

            Button(action: {
                if email == "" || password == "" {
                    return
                }

                Auth.auth().signIn(withEmail: email, password: password) { res, err in
                    if (err != nil) {
                        print("err: \(String(describing: err))")
                        return
                    }

                    let currentUser = Auth.auth().currentUser

                    currentUser?.getIDTokenForcingRefresh(true) { idToken, err in
                        if err != nil {
                            print("err: \(String(describing: err))")
                            return
                        }

                        token = idToken!;
                        loggedIn = true
                    }
                }
            }) {
                NavigationLink(destination: SectionsList(token: token), isActive: $loggedIn) {
                    Text("Log In")
                }
            }
        }.navigationTitle("Log In")
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm()
    }
}
