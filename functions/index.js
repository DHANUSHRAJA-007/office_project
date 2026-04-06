const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendOrderNotification = functions.firestore
  .document("orders/{orderId}")
  .onCreate(async (snap, context) => {

    const order = snap.data();

    const message = {
      notification: {
        title: "🛒 New Order",
        body: `Order Amount ₹${order.total}`,
      },

      // 🔥 IMPORTANT: paste your token here
      token: "cSv54PoZS1a3eARtRFw1ml:APA91bGyetUVL4qkmHq6Rt3hrODJ06mHGWj9_5jTgVIE_6mVP1oI5rqClpAO0aAui24njRaCf3V-CslRO-JNd3pUF3rcEP7rWYCUp4Ct7FYVJXeYohveLHw",
    };

    try {
      await admin.messaging().send(message);
      console.log("✅ Notification sent");
    } catch (error) {
      console.log("❌ Error:", error);
    }
  });