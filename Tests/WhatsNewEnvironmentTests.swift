import XCTest
@testable import WhatsNewKit

// MARK: - WhatsNewEnvironmentTests

/// The WhatsNewEnvironmentTests
final class WhatsNewEnvironmentTests: WhatsNewKitTestCase {
    
    func testInitial() {
        let version_1_0_0: WhatsNew.Version = "1.0.0"
        let whatsNew_1_0_0 = self.makeWhatsNew(from: version_1_0_0)
        let versionStore = InMemoryWhatsNewVersionStore()
        let environment = WhatsNewEnvironment(
            currentVersion: version_1_0_0,
            versionStore: versionStore,
            whatsNew: [whatsNew_1_0_0]
        )
        XCTAssertEqual(
            version_1_0_0,
            environment.getPresentableWhatsNew()?.version
        )
    }
    
    func testInitialReopen() {
        let version_1_0_0: WhatsNew.Version = "1.0.0"
        let whatsNew_1_0_0 = self.makeWhatsNew(from: version_1_0_0)
        let versionStore = InMemoryWhatsNewVersionStore()
        versionStore.save(presentedVersion: version_1_0_0)
        let environment = WhatsNewEnvironment(
            currentVersion: version_1_0_0,
            versionStore: versionStore,
            whatsNew: [whatsNew_1_0_0]
        )
        XCTAssertNil(
            environment.getPresentableWhatsNew()
        )
    }
    
    func testUpdate() {
        let version_1_0_0: WhatsNew.Version = "1.0.0"
        let whatsNew_1_0_0 = self.makeWhatsNew(from: version_1_0_0)
        let version_1_0_1: WhatsNew.Version = "1.0.1"
        let whatsNew_1_0_1 = self.makeWhatsNew(from: version_1_0_1)
        let versionStore = InMemoryWhatsNewVersionStore()
        versionStore.save(presentedVersion: version_1_0_0)
        let environment = WhatsNewEnvironment(
            currentVersion: version_1_0_1,
            versionStore: versionStore,
            whatsNew: [
                whatsNew_1_0_0,
                whatsNew_1_0_1
            ]
            .shuffled()
        )
        XCTAssertEqual(
            version_1_0_1,
            environment.getPresentableWhatsNew()?.version
        )
    }
    
    func testInitialAfterUpdates() {
        let version_1_0_0: WhatsNew.Version = "1.0.0"
        let whatsNew_1_0_0 = self.makeWhatsNew(from: version_1_0_0)
        let version_1_1_0: WhatsNew.Version = "1.1.0"
        let whatsNew_1_1_0 = self.makeWhatsNew(from: version_1_1_0)
        let versionStore = InMemoryWhatsNewVersionStore()
        let environment = WhatsNewEnvironment(
            currentVersion: "1.1.1",
            versionStore: versionStore,
            whatsNew: [
                whatsNew_1_0_0,
                whatsNew_1_1_0
            ]
            .shuffled()
        )
        XCTAssertEqual(
            version_1_1_0,
            environment.getPresentableWhatsNew()?.version
        )
    }
    
    func testInitialAfterUpdatesReopen() {
        let version_1_0_0: WhatsNew.Version = "1.0.0"
        let whatsNew_1_0_0 = self.makeWhatsNew(from: version_1_0_0)
        let version_1_1_0: WhatsNew.Version = "1.1.0"
        let whatsNew_1_1_0 = self.makeWhatsNew(from: version_1_1_0)
        let versionStore = InMemoryWhatsNewVersionStore()
        versionStore.save(presentedVersion: version_1_1_0)
        let environment = WhatsNewEnvironment(
            currentVersion: "1.1.1",
            versionStore: versionStore,
            whatsNew: [
                whatsNew_1_0_0,
                whatsNew_1_1_0
            ]
            .shuffled()
        )
        XCTAssertNil(
            environment.getPresentableWhatsNew()
        )
    }
    
}