import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp(functions.config().firestore);


export const getUserData = functions.https.onCall(async (data, context) => {
    if (!context.auth) {
        return { "data": "Nenhum utilizador logado..." }
    }
    const snapshot = await admin.firestore().collection('users').doc(context.auth.uid).get();
    return { "data": snapshot.data() }
});


export const onOrderStatusChanged = functions.firestore.document("/orders/{orderId}").
    onUpdate(async (snapshot, context) => {
        const orderId = context.params.orderId;
        const beforeStatus = snapshot.before.data().status;
        const afterStatus = snapshot.after.data().status;

        if (beforeStatus !== afterStatus) {
            const tokenUser = await getDeviceToken(snapshot.after.data().userId);
            let uid: string = snapshot.after.data().userId;
            await sendPushFCM(
                tokenUser,
                'Pedido: ' + orderId,
                'Estado actualizado para: ' + afterStatus);

            await saveNotification(uid,
            'Pedido: ' + orderId,
            'Estado actualizado para: ' + afterStatus);
        }
    });

export const onNewOrder = functions.firestore.document("/orders/{orderId}").
    onCreate(async (snapshot, context) => {

        const orderId = context.params.orderId;

        const querySnapshot = await admin.firestore().collection("admins").get();

        const admins = querySnapshot.docs.map(doc => doc.id);

        let adminTokens: string[] = [];

        for (let i = 0; i < admins.length; i++) {
            const tokensAdmin: string[] = await getDeviceToken(admins[i]);
            adminTokens = adminTokens.concat(tokensAdmin);
        }

        await sendPushFCM(adminTokens, 'Novo Pedido', 'Nova compra realizada. Pedido: ' + orderId);


    });


async function saveNotification(uid: string, title: string, message:string) {
    let date: Date = new Date();
    await admin.firestore().collection("notifications").add({
    'title':title,
    'body':message,
    'user':uid,
    'date':date,
    });
}

async function getDeviceToken(uid: string) {
    const querySnapshot = await admin.firestore().collection("users").doc(uid).collection("tokens").get();
    const tokens = querySnapshot.docs.map(doc => doc.id);
    return tokens;
}

async function sendPushFCM(tokens: string[], title: string, message: string) {
    if (tokens.length > 0) {
        const payload = {
            notification: {
                title: title,
                body: message,
                click_action: 'FLUTTER_NOTIFICATION_CLICK'
            }
        };
        return admin.messaging().sendToDevice(tokens, payload);
    }
    return;
}

export const helloFunctions = functions.https.onRequest((request, response) => {
    functions.logger.info("Hello logs!", { structuredData: true });
    response.send("Hello from Firebase!");
});
