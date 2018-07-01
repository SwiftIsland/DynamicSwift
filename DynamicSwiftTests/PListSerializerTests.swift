import XCTest
import DynamicSwift

class PListSerializerTests: XCTestCase {
    func testBasicTypes() {
        let conferences: Any = [
            [
                "name": "Swift Island",
                "startDate": Date(year: 2018, month: 7, day: 4),
                "endDate": Date(year: 2018, month: 7, day: 5),
                "isFull": true,
                "longitude": 53.079758,
                "latitude": 4.802859,
                "secret": Data(base64Encoded: "aHR0cHM6Ly95b3V0dS5iZS9kUXc0dzlXZ1hjUQ==")!
            ], [
                "name": "Swift Alps",
                "date": Date(year: 2018, month: 11),
                "numberOfDays": 2,
                "isFull": false,
                "longitude": 46.305125,
                "latitude": 7.462249,
                "secret": Data(base64Encoded: "aHR0cHM6Ly95b3V0dS5iZS9WaGhfR2VCUE9ocw==")!
            ]
        ]

        let serializer = PListSerializer()
        var output = ""
        serializer.serialize(conferences, to: &output)

        XCTAssertEqual(output, """
            <?xml version="1.0" encoding="UTF-8"?>
            <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
            <plist version="1.0">
            <array>
                <dict>
                    <key>endDate</key>
                    <date>2018-07-04T22:00:00Z</date>
                    <key>isFull</key>
                    <true/>
                    <key>latitude</key>
                    <real>4.802859</real>
                    <key>longitude</key>
                    <real>53.079758</real>
                    <key>name</key>
                    <string>Swift Island</string>
                    <key>secret</key>
                    <data>aHR0cHM6Ly95b3V0dS5iZS9kUXc0dzlXZ1hjUQ==</data>
                    <key>startDate</key>
                    <date>2018-07-03T22:00:00Z</date>
                </dict>
                <dict>
                    <key>date</key>
                    <date>2018-10-31T23:00:00Z</date>
                    <key>isFull</key>
                    <false/>
                    <key>latitude</key>
                    <real>7.462249</real>
                    <key>longitude</key>
                    <real>46.305125</real>
                    <key>name</key>
                    <string>Swift Alps</string>
                    <key>numberOfDays</key>
                    <integer>2</integer>
                    <key>secret</key>
                    <data>aHR0cHM6Ly95b3V0dS5iZS9WaGhfR2VCUE9ocw==</data>
                </dict>
            </array>
            </plist>
            """)
    }

    func testArbitraryTypes() {
        let bestTopics = [
            Topic(name: "Machine Learning", mentors: [
                Mentor(
                    name: "Meghan Kane",
                    picture: URL(string: "https://swiftisland.nl/assets/images/speakers/speaker-meghan.png")!)
            ]),
            Topic(name: "ARKit", mentors: [
                Mentor(
                    name: "Kate Castellano",
                    picture: URL(string: "https://swiftisland.nl/assets/images/speakers/speaker-kate.png")!),
                Mentor(
                    name: "Manu Rink",
                    picture: URL(string: "https://swiftisland.nl/assets/images/speakers/speaker-manu.png")!),
            ]),
            Topic(name: "Playgrounds", mentors: [
                Mentor(
                    name: "Marijn Schilling",
                    picture: URL(string: "https://swiftisland.nl/assets/images/speakers/speaker-marijn.png")!)
            ])
        ]

        let serializer = PListSerializer()
        var output = ""
        serializer.serialize(bestTopics, to: &output)

        XCTAssertEqual(output, """
            <?xml version="1.0" encoding="UTF-8"?>
            <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
            <plist version="1.0">
            <array>
                <dict>
                    <key>mentors</key>
                    <array>
                        <dict>
                            <key>name</key>
                            <string>Meghan Kane</string>
                            <key>picture</key>
                            <string>https://swiftisland.nl/assets/images/speakers/speaker-meghan.png</string>
                        </dict>
                    </array>
                    <key>name</key>
                    <string>Machine Learning</string>
                </dict>
                <dict>
                    <key>mentors</key>
                    <array>
                        <dict>
                            <key>name</key>
                            <string>Kate Castellano</string>
                            <key>picture</key>
                            <string>https://swiftisland.nl/assets/images/speakers/speaker-kate.png</string>
                        </dict>
                        <dict>
                            <key>name</key>
                            <string>Manu Rink</string>
                            <key>picture</key>
                            <string>https://swiftisland.nl/assets/images/speakers/speaker-manu.png</string>
                        </dict>
                    </array>
                    <key>name</key>
                    <string>ARKit</string>
                </dict>
                <dict>
                    <key>mentors</key>
                    <array>
                        <dict>
                            <key>name</key>
                            <string>Marijn Schilling</string>
                            <key>picture</key>
                            <string>https://swiftisland.nl/assets/images/speakers/speaker-marijn.png</string>
                        </dict>
                    </array>
                    <key>name</key>
                    <string>Playgrounds</string>
                </dict>
            </array>
            </plist>
            """)
    }

    func testEnums() {
        let companions: Any = [
            "companions": [
                Companion(
                    name: "Fuki",
                    age: 8,
                    race: .dog,
                    picture: URL(string: "https://www.dropbox.com/s/u62nkgipj9wsnss/fuki.jpg?dl=0")!),
                Companion(
                    name: "Gizmo",
                    age: 11,
                    race: .cat,
                    picture: URL(string: "https://www.dropbox.com/s/vryipy7yy6n27ui/gizmo.jpg?dl=0")!),
            ]
        ]

        let serializer = PListSerializer()
        var output = ""
        serializer.serialize(companions, to: &output)

        XCTAssertEqual(output, """
            <?xml version="1.0" encoding="UTF-8"?>
            <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
            <plist version="1.0">
            <dict>
                <key>companions</key>
                <array>
                    <dict>
                        <key>age</key>
                        <integer>8</integer>
                        <key>name</key>
                        <string>Fuki</string>
                        <key>picture</key>
                        <string>https://www.dropbox.com/s/u62nkgipj9wsnss/fuki.jpg?dl=0</string>
                        <key>race</key>
                        <string>dog</string>
                    </dict>
                    <dict>
                        <key>age</key>
                        <integer>11</integer>
                        <key>name</key>
                        <string>Gizmo</string>
                        <key>picture</key>
                        <string>https://www.dropbox.com/s/vryipy7yy6n27ui/gizmo.jpg?dl=0</string>
                        <key>race</key>
                        <string>cat</string>
                    </dict>
                </array>
            </dict>
            </plist>
            """)
    }

    func testTypeComments() {
        let companions: Any = [
            "companions": [
                Companion(
                    name: "Fuki",
                    age: 8,
                    race: .dog,
                    picture: URL(string: "https://www.dropbox.com/s/u62nkgipj9wsnss/fuki.jpg?dl=0")!),
                Companion(
                    name: "Gizmo",
                    age: 11,
                    race: .cat,
                    picture: URL(string: "https://www.dropbox.com/s/vryipy7yy6n27ui/gizmo.jpg?dl=0")!),
            ]
        ]

        let serializer = PListSerializer(shouldAnnotateTypes: true)
        var output = ""
        serializer.serialize(companions, to: &output)

        XCTAssertEqual(output, """
            <?xml version="1.0" encoding="UTF-8"?>
            <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
            <plist version="1.0">
            <dict>
                <key>companions</key>
                <array>
                    <dict> <!-- Companion -->
                        <key>age</key>
                        <integer>8</integer>
                        <key>name</key>
                        <string>Fuki</string>
                        <key>picture</key>
                        <string>https://www.dropbox.com/s/u62nkgipj9wsnss/fuki.jpg?dl=0</string> <!-- URL -->
                        <key>race</key>
                        <string>dog</string> <!-- Race -->
                    </dict>
                    <dict> <!-- Companion -->
                        <key>age</key>
                        <integer>11</integer>
                        <key>name</key>
                        <string>Gizmo</string>
                        <key>picture</key>
                        <string>https://www.dropbox.com/s/vryipy7yy6n27ui/gizmo.jpg?dl=0</string> <!-- URL -->
                        <key>race</key>
                        <string>cat</string> <!-- Race -->
                    </dict>
                </array>
            </dict>
            </plist>
            """)
    }

    func testClasses() {
        let pets: Any = [
            "pets": [
                Dog(name: "Fuki",
                    age: 8,
                    picture: URL(string: "https://www.dropbox.com/s/u62nkgipj9wsnss/fuki.jpg?dl=0")!,
                    breed: .pug),
                Cat(name: "Gizmo",
                    age: 11,
                    picture: URL(string: "https://www.dropbox.com/s/vryipy7yy6n27ui/gizmo.jpg?dl=0")!,
                    numberOfLivesLeft: 4),
            ]
        ]

        let serializer = PListSerializer(shouldAnnotateTypes: true)
        var output = ""
        serializer.serialize(pets, to: &output)

        XCTAssertEqual(output, """
            <?xml version="1.0" encoding="UTF-8"?>
            <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
            <plist version="1.0">
            <dict>
                <key>pets</key>
                <array>
                    <dict> <!-- Dog -->
                        <key>age</key>
                        <integer>8</integer>
                        <key>breed</key>
                        <string>pug</string> <!-- Breed -->
                        <key>name</key>
                        <string>Fuki</string>
                        <key>picture</key>
                        <string>https://www.dropbox.com/s/u62nkgipj9wsnss/fuki.jpg?dl=0</string> <!-- URL -->
                    </dict>
                    <dict> <!-- Cat -->
                        <key>age</key>
                        <integer>11</integer>
                        <key>name</key>
                        <string>Gizmo</string>
                        <key>numberOfLivesLeft</key>
                        <integer>4</integer>
                        <key>picture</key>
                        <string>https://www.dropbox.com/s/vryipy7yy6n27ui/gizmo.jpg?dl=0</string> <!-- URL -->
                    </dict>
                </array>
            </dict>
            </plist>
            """)
    }

    func testCustomization() {
        let companions: Any = [
            Uppercased(Companion(
                name: "Fuki",
                age: 8,
                race: .dog,
                picture: URL(string: "https://www.dropbox.com/s/u62nkgipj9wsnss/fuki.jpg?dl=0")!)),
            Companion(
                name: "Gizmo",
                age: 11,
                race: .cat,
                picture: URL(string: "https://www.dropbox.com/s/vryipy7yy6n27ui/gizmo.jpg?dl=0")!),
        ]

        let serializer = PListSerializer()
        var output = ""
        serializer.serialize(companions, to: &output)

        XCTAssertEqual(output, """
            <?xml version="1.0" encoding="UTF-8"?>
            <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
            <plist version="1.0">
            <array>
                <dict>
                    <key>AGE</key>
                    <integer>8</integer>
                    <key>NAME</key>
                    <string>Fuki</string>
                    <key>PICTURE</key>
                    <string>https://www.dropbox.com/s/u62nkgipj9wsnss/fuki.jpg?dl=0</string>
                    <key>RACE</key>
                    <string>dog</string>
                </dict>
                <dict>
                    <key>age</key>
                    <integer>11</integer>
                    <key>name</key>
                    <string>Gizmo</string>
                    <key>picture</key>
                    <string>https://www.dropbox.com/s/vryipy7yy6n27ui/gizmo.jpg?dl=0</string>
                    <key>race</key>
                    <string>cat</string>
                </dict>
            </array>
            </plist>
            """)
    }
}

extension Date {
    init(year: Int, month: Int? = nil, day: Int? = nil) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        self = Calendar.current.date(from: components)!
    }
}
