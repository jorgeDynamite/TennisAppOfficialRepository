const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const stripe = require("stripe")(functions.config().stripe.testkey);

exports.stripePayment = functions.https.onRequest(async (req, res) => {
    
    const fee = Number(req.query.amounts) | 0;
    const namecode = req.query.namecode;
    
     paymentIntent = await stripe.paymentIntents.create({
        amount: fee,
        currency: "usd",
        description: namecode
    },
    function (err, paymentIntent){
if(err!=null){
    console.log(err);
} else {
    res.json({
        paymentIntent: paymentIntent.client_secret
    })
}
    }
    )

})
