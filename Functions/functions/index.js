const functions = require('firebase-functions');

exports.emojify = functions.database.ref('/messages/{pushId}/text').onWrite(event =>{
    //write includes new, modified, or deleted nodes
    
    //!event.data.val() is a deleted event
    //event.data.previous.val() is a modified event
    if(!event.data.val() || event.data.previous.val()){
        console.log("not a new write event");
        return;
    }

    console.log("Emojifying!");

    const originalText = event.data.val();
    const emojifyText = emojifyText(originalText);
    return event.data.ref.set(emojifyText);
});

function emojifyText(text) {
    var emojifyText = text;
    emojifyText = emojifyText.replace(/\blol\b/ig, "😂");
    emojifyText = emojifyText.replace(/\bcat\b/ig, "😸");
    return emojifyText;
}
