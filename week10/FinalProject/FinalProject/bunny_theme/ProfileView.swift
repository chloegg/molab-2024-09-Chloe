//
//  ProfileView.swift
//  FinalProject
//
//  Created by Keying Guo on 12/10/24.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var gender: String = ""
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var showLogoutMenu = false // State for logout menu

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.60, green: 0.83, blue: 0.88)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 20) {
                            HeaderSection(
                                selectedImage: $selectedImage,
                                showImagePicker: $showImagePicker,
                                showLogoutMenu: $showLogoutMenu
                            )

                            ProfileDetailsSection(name: name, age: age, gender: gender)

                            ActivitySection()

                            BadgesSection()
                        }
                        .padding(.top, 10)
                    }

                    Spacer()

                    ZStack {
                        Color(red: 154 / 255, green: 201 / 255, blue: 225 / 255)
                            .ignoresSafeArea(edges: .bottom)
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: -2)

                        VStack {
                            Spacer()
                                .frame(height: 15)
                            HStack(spacing: 0.5) {
                                NavigationLink(destination: HomeScreen().navigationBarHidden(true)) {
                                    NavigationsBarItem(icon: "house.fill", label: "home", isActive: false)
                                }
                                NavigationLink(destination: ActivitiesView().navigationBarHidden(true)) {
                                    NavigationsBarItem(icon: "list.bullet", label: "todos", isActive: false)
                                }
                                NavigationLink(destination: TimerView().navigationBarHidden(true)) {
                                    NavigationsBarItem(icon: "timer", label: "timer", isActive: false)
                                }
                                NavigationLink(destination: CalendarView().navigationBarHidden(true)) {
                                    NavigationsBarItem(icon: "book.fill", label: "cal..", isActive: false)
                                }
                                NavigationsBarItem(icon: "person.fill", label: "profile", isActive: true)
                            }
                            Spacer()
                                .frame(height: 5)
                        }
                    }
                    .frame(height: 55)
                }
            }
            .onAppear {
                loadUserData()
                loadProfileImage()
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }

    private func loadUserData() {
        name = UserDefaults.standard.string(forKey: "name") ?? "Name"
        age = UserDefaults.standard.string(forKey: "age") ?? "Age"
        gender = UserDefaults.standard.string(forKey: "gender") ?? "Gender"
    }

    private func loadProfileImage() {
        if let imageData = UserDefaults.standard.data(forKey: "profileImage") {
            selectedImage = UIImage(data: imageData)
        }
    }
}

struct ProfileDetailsSection: View {
    let name: String
    let age: String
    let gender: String

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Profile Details")
                .font(.custom("Saira Stencil One", size: 24))
                .foregroundColor(.black)

            VStack(spacing: 10) {
                DetailRow(label: "Name", value: name)
                DetailRow(label: "Age", value: age)
                DetailRow(label: "Gender", value: gender)
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(15)
            .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 4)
        }
        .padding(.horizontal, 20)
    }
}

struct DetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.custom("Saira Stencil One", size: 18))
                .foregroundColor(.black)

            Spacer()

            Text(value)
                .font(.custom("Saira Stencil One", size: 18))
                .foregroundColor(.gray)
        }
    }
}

struct ActivitySection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Recent Activities")
                .font(.custom("Saira Stencil One", size: 24))
                .foregroundColor(.black)

            VStack(spacing: 10) {
                ActivityRow(activity: "Completed Task 1")
                ActivityRow(activity: "Checked Calendar")
                ActivityRow(activity: "Set Timer")
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(15)
            .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 4)
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

struct HeaderSection: View {
    @Binding var selectedImage: UIImage?
    @Binding var showImagePicker: Bool
    @Binding var showLogoutMenu: Bool
    @State private var username: String = ""

    var body: some View {
        ZStack {
            Color(red: 0.98, green: 0.91, blue: 0.98, opacity: 0.9)
                .ignoresSafeArea(edges: .top)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .padding(.top, -75)

            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showLogoutMenu.toggle()
                    }) {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.black.opacity(0.8))
                            .padding(.trailing, 20)
                            .padding(.top, -23)
                    }
                }

                ZStack {
                    Circle()
                        .strokeBorder(Color(red: 0.81, green: 0.85, blue: 0.50), lineWidth: 8)
                        .frame(width: 140, height: 140)
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 124, height: 124)
                            .clipShape(Circle())
                    } else {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 124, height: 124)
                    }

                    Button(action: {
                        showImagePicker = true
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                            .background(Circle().fill(Color.white).frame(width: 30, height: 30))
                    }
                    .offset(x: 50, y: 50)
                }
                .padding(.top, 15)

                Text(username)
                    .font(.custom("Saira Stencil One", size: 28))
                    .foregroundColor(Color(red: 0.30, green: 0.30, blue: 0.30))

                HStack(spacing: 20) {
                    Text("0 followers")
                    Text("0 following")
                }
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.30, green: 0.30, blue: 0.30, opacity: 0.7))
            }
            .padding(.vertical, 28)
        }
        .sheet(isPresented: $showImagePicker) {
            PhotoPicker(selectedImage: $selectedImage)
        }
        .onAppear {
            loadUsername()
        }
        .popover(isPresented: $showLogoutMenu) {
            VStack(spacing: 20) {
                Text("Are you sure you want to log out?")
                    .font(.custom("Saira Stencil One", size: 15))
                    .multilineTextAlignment(.center)
                    .padding()

                Button(action: {
                    UIApplication.shared.windows.first?.rootViewController = UIHostingController(rootView: ContentView())
                }) {
                    Text("Log Out")
                        .font(.custom("Saira Stencil One", size: 20))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(15)
                }
            }
            .padding()
            .frame(width: 300, height: 200)
            .background(Color.white)
            .cornerRadius(20)
        }
        .onChange(of: selectedImage) { newImage in
            if let newImage = newImage, let imageData = newImage.pngData() {
                UserDefaults.standard.set(imageData, forKey: "profileImage")
            }
        }
    }

    private func loadUsername() {
        username = UserDefaults.standard.string(forKey: "username") ?? "Username"
    }
}

struct ActivityRow: View {
    let activity: String

    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .frame(width: 20, height: 20)

            Text(activity)
                .font(.custom("Saira Stencil One", size: 16))
                .foregroundColor(.black)
        }
    }
}

struct BadgesSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Achievements")
                .font(.custom("Saira Stencil One", size: 24))
                .foregroundColor(.black)

            HStack(spacing: 20) {
                BadgeView(icon: "star.fill", label: "Beginner")
                BadgeView(icon: "star.fill", label: "Intermediate")
                BadgeView(icon: "star.fill", label: "Expert")
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

struct BadgeView: View {
    let icon: String
    let label: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.yellow)

            Text(label)
                .font(.custom("Saira Stencil One", size: 14))
                .foregroundColor(.black)
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 4)
    }
}


struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else { return }
            provider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    self.parent.selectedImage = image as? UIImage
                }
            }
        }
    }
}

struct NavigationsBarItem: View {
    let icon: String
    let label: String
    let isActive: Bool

    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: icon)
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.white)
            Text(label)
                .font(.custom("Saira Stencil One", size: 14))
                .foregroundColor(.white)
        }
        .padding(.vertical, 7)
        .padding(.horizontal, 16)
        .background(isActive ? Color.black.opacity(0.2) : Color.clear)
        .cornerRadius(8)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
