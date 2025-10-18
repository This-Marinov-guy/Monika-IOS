import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authService: AuthService
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showValidationError = false
    @State private var validationError = ""
    @FocusState private var focusedField: Field?
    
    enum Field {
        case email, password, confirmPassword
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            VStack(spacing: 8) {
                Image(systemName: "person.badge.plus.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Create Account")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Sign up to get started")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 20)
            
            // Email field
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
            
            // Password field
            VStack(alignment: .leading, spacing: 8) {
                Text("Password")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                SecureField("Enter your password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.newPassword)
                    .focused($focusedField, equals: .password)
                #if os(iOS)
                    .submitLabel(.next)
                #endif
                    .onSubmit {
                        focusedField = .confirmPassword
                    }
            }
            
            // Confirm password field
            VStack(alignment: .leading, spacing: 8) {
                Text("Confirm Password")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                SecureField("Confirm your password", text: $confirmPassword)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.newPassword)
                    .focused($focusedField, equals: .confirmPassword)
                #if os(iOS)
                    .submitLabel(.go)
                #endif
                    .onSubmit {
                        handleSignUp()
                    }
            }
            
            // Password requirements
            VStack(alignment: .leading, spacing: 4) {
                Text("Password must be at least 6 characters")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Error message
            if showValidationError {
                Text(validationError)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
            
            if let errorMessage = authService.errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
            
            // Sign up button
            Button {
                handleSignUp()
            } label: {
                HStack {
                    if authService.isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.white)
                    }
                    Text("Sign Up")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .disabled(authService.isLoading || !isFormValid)
        }
        .padding()
    }
    
    private var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty
    }
    
    private func handleSignUp() {
        showValidationError = false
        validationError = ""
        
        // Validate email
        guard email.contains("@") && email.contains(".") else {
            validationError = "Please enter a valid email address"
            showValidationError = true
            return
        }
        
        // Validate password length
        guard password.count >= 6 else {
            validationError = "Password must be at least 6 characters"
            showValidationError = true
            return
        }
        
        // Validate passwords match
        guard password == confirmPassword else {
            validationError = "Passwords do not match"
            showValidationError = true
            return
        }
        
        Task {
            await authService.signUp(email: email, password: password)
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthService())
}

