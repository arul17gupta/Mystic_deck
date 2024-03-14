import SwiftUI

struct LandingPage: View {
    @State private var showSignUp = false
    @State private var showLogin = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("themebk")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("LD")
                        .resizable()
                        .scaledToFit()
                        .padding(.top, -80)
                    
                    Spacer()
                    
                    Text("MysticDeck")
                        .font(.system(size: 50, weight: .bold, design: .serif))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hue: 0.728, saturation: 0.953, brightness: 0.741))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        NavigationLink(destination: LoginView()) {
                            Text("Login")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 100.0)
                                .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.628, saturation: 0.553, brightness: 0.841), Color(red: 75/255, green: 0/255, blue: 130/255)]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(10)
                        }
                        
                        
                        NavigationLink(destination: SignupView()) {
                            Text("Sign up")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 100.0)
                                .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.628, saturation: 0.553, brightness: 0.841), Color(red: 75/255, green: 0/255, blue: 130/255)]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(10)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    
    var body: some View {
        ZStack {
            // Background Image
            Image("themebk")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Image("LD")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, -80)
                
                Spacer(minLength: -500) // Add space after the LD image
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .frame(width: 300, height: 40)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .frame(width: 300, height: 40)
                
                HStack {
                    CheckBoxView(checked: $rememberMe)
                    Text("Remember Me")
                        .font(.system(size: 14))
                    
                        .foregroundColor(Color(hue: 0.728, saturation: 0.953, brightness: 0.741))
                }
                
                NavigationLink(destination: NavigationBarView()) {
                    Text("Login")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 200.0)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.628, saturation: 0.553, brightness: 0.841), Color(red: 75/255, green: 0/255, blue: 130/255)]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                }
                
                Spacer() // Add a Spacer to push the "Forgot Password?" text to the center
                
                HStack {
                    Spacer()
                    NavigationLink(destination: ForgotPasswordView()) {
                        Text("Forgot Password?")
                            .font(.system(size: 12))
                            .foregroundColor(Color(hue: 0.728, saturation: 0.953, brightness: 0.741))
                            .padding(.top, 10)
                    }
                    Spacer()
                }
            }
            .padding()
        }
    }
}

struct ForgotPasswordView: View {
    var body: some View {
        Text("Forgot Password View")
            .padding()
    }
}


struct SignupView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    
    var body: some View {
        ZStack {
            // Background Image
            Image("themebk")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Image("LD")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, -30)
                
                Text("Login:")
                    .font(.system(size: 24, weight: .light, design: .serif))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hue: 0.728, saturation: 0.953, brightness: 0.741))
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .frame(width: 300, height: 40)
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .frame(width: 300, height: 40)
                    .padding(.horizontal)
                
                HStack {
                    CheckBoxView(checked: $rememberMe)
                    Text("Remember Me")
                        .foregroundColor(Color(hue: 0.728, saturation: 0.953, brightness: 0.741))
                }
                .padding(.top, 10)
                
                NavigationLink(destination: NavigationBarView()) {
                    Text("Sign up")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 100.0)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(hue: 0.628, saturation: 0.553, brightness: 0.841), Color(red: 75/255, green: 0/255, blue: 130/255)]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                }

                
                Rectangle()
                    .fill(Color.purple)
                    .frame(height: 2)
                    .padding(.vertical, 10)
                
                Text("Or SignUp with")
                    .foregroundColor(Color(hue: 0.728, saturation: 0.953, brightness: 0.741))
                
                HStack(spacing: 20) {
                    Button(action: {
                        // Handle Google Login
                    }) {
                        Image("googleIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                    }
                    
                    
                    Button(action: {
                        // Handle Apple Login
                    }) {
                        Image("appleIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct CheckBoxView: View {
    @Binding var checked: Bool
    
    var body: some View {
        Button(action: {
            self.checked.toggle()
        }) {
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(checked ? Color.blue : Color.gray)
        }
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
