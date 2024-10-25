//
//  ContentView.swift
//  Week07
//
//  Created by Keying Guo on 10/24/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var processedImageData: Data?
    @State private var filterIntensity = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @State private var userText = ""
    @State private var showTextOverlay = false
    @State private var showingFilters = false
    @State private var userName = ""
    @State private var showPhotoPicker = false

    @State private var currentFilter: CIFilter = CIFilter.pixellate()
    let context = CIContext()
    @State private var inputImage: CIImage?

    var body: some View {
        NavigationStack {
            ZStack {
                // Opaque gradient background
                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.7), Color.blue.opacity(0.6)]),
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    if let image = processedImage {
                        ZStack {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 300, maxHeight: 300)
                                .cornerRadius(20)
                                .shadow(radius: 10)
                                .padding()

                            if showTextOverlay {
                                Text(userText)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .shadow(radius: 5)
                                    .padding()
                            }
                        }
                    } else {
                        Text("No picture selected")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .onTapGesture {
                                showPhotoPicker = true
                            }
                    }

                    Spacer()

                    TextField("Enter text to overlay...", text: $userText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)

                    Button("Toggle Text Overlay") {
                        showTextOverlay.toggle()
                    }
                    .font(.headline)
                    .padding()
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)

                    HStack {
                        Text("Intensity")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        
                        Slider(value: $filterIntensity, in: 0...1)
                            .accentColor(.pink)
                            .onChange(of: filterIntensity) { _ in
                                applyProcessing()
                            }
                            .padding(.horizontal)
                    }
                    .padding()

                    // Action Buttons
                    HStack(spacing: 20) {
                        Button("Change Filter") {
                            showingFilters = true
                        }
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .disabled(processedImage == nil)

                        Button("Random Filter") {
                            applyRandomFilter()
                        }
                        .font(.headline)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .disabled(processedImage == nil)
                    }
                    .padding(.horizontal, 40)
                }
            }
            .padding()
            .navigationTitle("CreativeFilter")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView(processedImage: processedImage, processedImageData: processedImageData, userText: userText)) {
                        Text("Next")
                    }
                    .disabled(processedImage == nil)
                }
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
            .photosPicker(isPresented: $showPhotoPicker, selection: $selectedItem, matching: .images)
            .onChange(of: selectedItem) { _ in
                loadImage()
            }
        }
    }

    func applyRandomFilter() {
        let filters: [CIFilter] = [
            CIFilter.crystallize(), CIFilter.edges(), CIFilter.gaussianBlur(),
            CIFilter.pixellate(), CIFilter.sepiaTone(), CIFilter.unsharpMask(),
            CIFilter.vignette()
        ]
        setFilter(filters.randomElement() ?? CIFilter.pixellate())
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        applyProcessing()
    }

    func loadImage() {
        Task {
            guard let imageData = try? await selectedItem?.loadTransferable(type: Data.self),
                  let uiImage = UIImage(data: imageData) else { return }

            inputImage = CIImage(image: uiImage)
            currentFilter.setValue(inputImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }

    func applyProcessing() {
        guard let inputImage = inputImage else { return }

        currentFilter.setValue(inputImage, forKey: kCIInputImageKey)

        if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }

        if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }

        if currentFilter.inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputScaleKey)
        }

        guard let outputImage = currentFilter.outputImage,
              let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

        processedImageData = UIImage(cgImage: cgImage).jpegData(compressionQuality: 0.8)
        processedImage = Image(decorative: cgImage, scale: 1.0)
    }
}


struct ProfileView: View {
    let processedImage: Image?
    let processedImageData: Data?
    let userText: String
    @State private var userName = ""
    @State private var isSaved = false

    var body: some View {
        VStack(spacing: 20) {
            if let image = processedImage {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.pink, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding()

                Text(userText)
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            }

            TextField("Enter your name", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(10)
                .padding(.horizontal, 40)

            Button("Save Profile") {
                saveProfile()
            }
            .font(.headline)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .disabled(userName.isEmpty || processedImageData == nil)
            
            if isSaved {
                Text("Profile Saved!")
                    .foregroundColor(.green)
                    .font(.headline)
            }

            NavigationLink(destination: ProfilesListView()) {
                Text("View Saved Profiles")
                    .font(.headline)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
        }
        .navigationTitle("Profile Setup")
    }
    
    func saveProfile() {
        if let processedImageData {
            let profile = Profile(imageData: processedImageData, imageText: userText, userName: userName)
            ProfileManager.shared.saveProfile(profile)
            isSaved = true
        }
    }
}

struct Profile: Codable {
    let imageData: Data?
    let imageText: String
    let userName: String
}

struct ProfilesListView: View {
    @State private var profiles: [Profile] = []
    
    var body: some View {
        VStack {
            Text("Saved Profiles")
                .font(.largeTitle)
                .padding()
            
            List(profiles, id: \.userName) { profile in
                HStack {
                    if let imageData = profile.imageData,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } else {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 50, height: 50)
                            .overlay(Text(profile.imageText.prefix(1)))
                    }
                    
                    VStack(alignment: .leading) {
                        Text(profile.userName)
                            .font(.headline)
                        Text(profile.imageText)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onAppear {
                profiles = ProfileManager.shared.loadProfiles()
            }
        }
        .navigationTitle("Profiles")
    }
}

class ProfileManager {
    static let shared = ProfileManager()
    
    func saveProfile(_ profile: Profile) {
        var profiles = loadProfiles()
        profiles.append(profile)
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(profiles) {
            UserDefaults.standard.set(encoded, forKey: "userProfiles")
        }
    }
    
    func loadProfiles() -> [Profile] {
        if let savedProfiles = UserDefaults.standard.data(forKey: "userProfiles") {
            let decoder = JSONDecoder()
            if let loadedProfiles = try? decoder.decode([Profile].self, from: savedProfiles) {
                return loadedProfiles
            }
        }
        return []
    }
}

#Preview {
    ContentView()
}
