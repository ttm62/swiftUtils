import Foundation

public
extension Encodable {
    var toOptionalData: Data? {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            return encoded
        } else {
            print("[!] Unable to Encode \(self.self)")
            return nil
        }
    }
}

public
extension Data {
    func decode<T: Decodable>() -> T? {
        let decoder = JSONDecoder()
        if let encoded = try? decoder.decode(T.self, from: self) {
            return encoded
        } else {
            print("[!] Unable to Decode \(self.self)")
            return nil
        }
    }
}