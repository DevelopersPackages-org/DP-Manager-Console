import "package:firebase_node/admin.dart";
import "package:firebase_node/functions.dart";

void main() {
  functions["onCreateUser"] = functions.auth.user().onCreate(onCreateUser);

  functions["onDeleteUser"] = functions.auth.user().onDelete(onDeleteUser);

  functions["storageFunctions"] =
      functions.storage.bucket("my-bucket").object().onFinalize(onFinalize);

  // non-Future function
  functions["documentUpdate"] =
      functions.firestore.document("my-document").onUpdate((change, context) {
    print(context.auth.uid);
    return 0;
  });
}

final app = initializeApp();

//Future function must have literal
Future<int> onDeleteUser(UserRecord user, EventContext context) async {
  final ref = app.firestore().collection("userdata").doc(user.uid);
  await ref.delete();
  return 0; //Every function must return value so that Firebase functions know when the function end.
}

Future<int> onFinalize(ObjectMetadata metadata, EventContext context) async {
  final ref = app.firestore().collection("tracker").doc("my-bucket");
  final fieldsAndValues = [
    FieldPath("file", metadata.name),
    metadata.size,
    "file_count",
    FieldValue.increment(1),
  ];
  await ref.update(fieldsAndValues: fieldsAndValues);
  return 0;
}

Future<int> onCreateUser(UserRecord user, EventContext context) async {
  final ref = app.firestore().collection("userdata").doc(user.uid);
  final data = {
    "name": user.displayName,
    "email": user.email,
    "timestamp": FieldValue.serverTimestamp(),
  };
  await ref.set(data);
  return 0;
}