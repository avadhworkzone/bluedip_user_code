enum APIType { aPost, aGet, aDelete, aPut }

enum APIHeaderType {
  fileUploadWithToken,
  fileUploadWithoutToken,
  jsonBodyWithToken,
  jsonBodyWithoutToken,
  onlyToken
}

enum ValidationType {
  Password,
  Email,
  PNumber,
  IfscCode,
  Account,
  bankName,
  Link,
  FirstLastName
}

enum FileExt { Image, Video, Doc, Audio, Card }

enum IncomingChatStatus { AcceptSession, RejectSession }
