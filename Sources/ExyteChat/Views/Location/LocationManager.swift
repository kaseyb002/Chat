//
//  LocationManager.swift
//  Chat
//

import CoreLocation

@MainActor
final class LocationManager: ObservableObject {
    @Published var currentLocation: CLLocationCoordinate2D?

    /// Location acquisition is intentionally disabled in this fork. Host apps
    /// can still display location messages without linking permission-request APIs.
    func requestStaticLocation() { }

    func startUpdatingLiveLocation() { }

    func stopUpdatingLiveLocation() { }
}
