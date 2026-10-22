import AVFoundation
import XCTest
@testable import ExyteChat

final class RecordingPlayerAudioSessionTests: XCTestCase {
    @MainActor
    func testOpeningChatPreservesAudioSession() throws {
        let session = AVAudioSession.sharedInstance()
        let originalCategory = session.category
        let originalMode = session.mode
        let originalOptions = session.categoryOptions
        defer {
            try? session.setCategory(originalCategory, mode: originalMode, options: originalOptions)
        }

        // Cover a fresh app, mixing sound effects, and an existing voice chat.
        let configurations: [(AVAudioSession.Category, AVAudioSession.Mode, AVAudioSession.CategoryOptions)] = [
            (.soloAmbient, .default, []),
            (.ambient, .default, []),
            (.playAndRecord, .voiceChat, [.mixWithOthers, .defaultToSpeaker]),
        ]
        for (category, mode, options) in configurations {
            try session.setCategory(category, mode: mode, options: options)
            let expectedOptions = session.categoryOptions

            // This is the same initialization path used by every table's chat.
            let model = ChatViewModel()
            withExtendedLifetime(model) {
                XCTAssertEqual(session.category, category)
                XCTAssertEqual(session.mode, mode)
                XCTAssertEqual(session.categoryOptions, expectedOptions)
            }
        }
    }
}
