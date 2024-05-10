const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendNotificationOnDatabaseChange = functions.firestore
    .document("yourCollection/{docId}")
    .onWrite((change, context) => {
      const newValue = change.after.data();
      const payload = {
        notification: {
          title: "New Database Change",
          body: `New data: ${newValue.yourField}`,
        },
      };

      const tokens = ["your-device-token"];

      return admin
          .messaging()
          .sendToDevice(tokens, payload)
          .then((response) => {
            console.log("Notification sent successfully:", response);
          })
          .catch((error) => {
            console.error("Error sending notification:", error);
          });
    });
