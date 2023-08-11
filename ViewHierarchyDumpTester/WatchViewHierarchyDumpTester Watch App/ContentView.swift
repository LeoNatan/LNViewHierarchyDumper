//
//  ContentView.swift
//  WatchViewHierarchyDumpTester Watch App
//
//  Created by Leo Natan on 11/08/2023.
//

import SwiftUI
import MapKit

struct ContentView: View {
	@State var toggleState: Bool = true
	@State var sliderState: Double = 0.5
	@State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
	
	@State var error: Error? = nil
	@State var savedUrl: URL? = nil
	@State var alertPresented: Bool = false
	
	var body: some View {
		Form {
			Button("Button") {
				do {
					savedUrl = try dumpViewHierarchy()
				} catch let e {
					error = e
				}
				alertPresented = true
			}
			Toggle("Switch", isOn: $toggleState)
			Slider(value: $sliderState, in: 0...1)
			Map(coordinateRegion: $region)
		}
		.alert(error != nil ? "View Hierarchy Dump Failed" : "View Hierarchy Dumped", isPresented: $alertPresented) {
			Button("OK") {
				error = nil
				savedUrl = nil
				alertPresented = false
			}
		} message: {
			if let error {
				Text(error.localizedDescription)
			} else if let savedUrl {
				Text(savedUrl.path)
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
