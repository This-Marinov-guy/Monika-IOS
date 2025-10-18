import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authService: AuthService
    @State private var email = ""
    @State private var password = ""
    @State private var showingForgotPassword = false
    @FocusState private var focusedField: Field?
    
    enum Field {
        case email, password
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Header with animations
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(DesignTokens.Colors.primarySubtle)
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(DesignTokens.Gradients.primary)
                }
                .scaleOnAppear(delay: 0.1)
                .pulseEffect()
                
                Text("Welcome Back")
                    .font(.title)
                    .fontWeight(.bold)
                    .slideInFromTop(delay: 0.2)
                
                Text("Sign in to continue")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .slideInFromTop(delay: 0.3)
            }
            .padding(.bottom, 20)
            
            // Email field with animation
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                TextField("Enter your email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.emailAddress)
                #if os(iOS)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .submitLabel(.next)
                #endif
                    .focused($focusedField, equals: .email)
                    .onSubmit {
                        focusedField = .password
                    }
            }
            .slideInFromLeft(delay: 0.4)
            .shakeEffect(trigger: authService.errorMessage != nil)
            
            // Password field with animation
            VStack(alignment: .leading, spacing: 8) {
                Text("Password")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                SecureField("Enter your password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.password)
                    .focused($focusedField, equals: .password)
                #if os(iOS)
                    .submitLabel(.go)
                #endif
                    .onSubmit {
                        Task {
                            await authService.signIn(email: email, password: password)
                        }
                    }
            }
            .slideInFromLeft(delay: 0.5)
            .shakeEffect(trigger: authService.errorMessage != nil)
            
            // Forgot password
            HStack {
                Spacer()
                Button {
                    showingForgotPassword = true
                } label: {
                    Text("Forgot Password?")
                        .font(.subheadline)
                }
            }
            
            // Error message
            if let errorMessage = authService.errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
            
            // Sign in button
            Button {
                Task {
                    await authService.signIn(email: email, password: password)
                }
            } label: {
                HStack {
                    if authService.isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.white)
                    }
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .disabled(authService.isLoading || email.isEmpty || password.isEmpty)
            
            Divider()
                .padding(.vertical, 10)
            
            // Google Sign In (Placeholder)
            Button {
                // Google Sign-In will be implemented later
            } label: {
                HStack {
                    Image(systemName: "globe")
                    Text("Sign in with Google")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.1))
                .foregroundColor(.primary)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }
            .disabled(true)
            .opacity(0.6)
            
            Text("Google Sign-In coming soon for iOS")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .sheet(isPresented: $showingForgotPassword) {
            ForgotPasswordView()
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthService())
}

