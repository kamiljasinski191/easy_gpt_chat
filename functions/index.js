const functions = require("firebase-functions");

const admin = require("firebase-admin");
admin.initializeApp();

const db = admin.firestore();

exports.createUserDocument = functions.auth.user().onCreate((user) => {
    const userId = user.uid;
    const userEmail = user.email;
    const userName = user.displayName;
    db.doc("users/" + userId).set({
        "email": userEmail, "free_tokens": 2, "display_name": userName,
    });
});

exports.deleteUserDocument = functions.auth.user().onDelete((user) => {
    const userId = user.uid;
    const userEmail = user.email;
    const userName = user.displayName;
    db.doc("users/" + userId).delete();
});
