import Foundation
import MongoSwift

/// The result of an `insertOne` command on a `RemoteMongoCollection`.
public struct RemoteInsertOneResult: Decodable {
    /// The identifier that was inserted. If the document doesn't have an identifier, this value
    /// will be generated by the Stitch server and added to the document before insertion.
    private let _insertedId: AnyBSONValue
    public var insertedId: BSONValue {
        return _insertedId.value
    }

    internal init(insertedId: BSONValue) {
        self._insertedId = AnyBSONValue(insertedId)
    }

    internal enum CodingKeys: String, CodingKey {
        // swiftlint:disable identifier_name
        case _insertedId = "insertedId"
    }
}

public struct SyncInsertOneResult {
    public let insertedId: BSONValue?

    internal init(insertedId: BSONValue?) {
        self.insertedId = insertedId
    }
}

extension InsertOneResult {
    var toSyncInsertOneResult: SyncInsertOneResult {
        return SyncInsertOneResult(insertedId: self.insertedId)
    }
}
