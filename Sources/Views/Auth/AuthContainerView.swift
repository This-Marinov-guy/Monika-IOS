import SwiftUI

struct AuthContainerView: View {
    @EnvironmentObject var authService: AuthService
    @State private var selectedTab: AuthTab = .login
    
    enum AuthTab {
        case login, signup
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Tab selector
                Picker("Auth Type", selection: $selectedTab) {
                    Text("Login").tag(AuthTab.login)
                    Text("Sign Up").tag(AuthTab.signup)
                }
                .pickerStyle(.segmented)
                .padding()
                
                // Content
                TabView(selection: $selectedTab) {
                    LoginView()
                        .tag(AuthTab.login)
                    
                    SignUpView()
                        .tag(AuthTab.signup)
                }
            #if os(iOS)
                .tabViewStyle(.page(indexDisplayMode: .never))
            #endif
            }
            .navigationTitle("Monika Swift")
        #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
        }
    }
}

#Preview {
    AuthContainerView()
        .environmentObject(AuthService())
}

