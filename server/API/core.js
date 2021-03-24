const fetch = require('node-fetch');
var Base64 = require('js-base64').Base64;

async function getGmailAdress(token) {
    var res = await fetch("https://www.googleapis.com/gmail/v1/users/me/profile", {
        method: "GET",
        headers: {
            Authorization: "Bearer " + token,
            'Content-Type': 'application/json'
        }
    });
    var parsed = await res.json();
    console.log(parsed)
    return (parsed.emailAddress);
}

async function executeGmail(userId, reactionId, actionId, var1, var2, token, tokenEvent) {
    console.log("Gmail Reaction with")
    console.log("var1 :" + var1)
    console.log("var2 :" + var2)
    if (reactionId == 2) {
        let email = ["Content-Type: text/plain; charset=\"UTF-8\"\n",
            "MIME-Version: 1.0\n",
            "Content-Transfer-Encoding: 7bit\n",
            "to: ", var2, "\n",
            "from: ", tokenEvent, "\n",
            "subject: ", "Receive From AREA", "\n\n",
            var1
        ].join('');
        var base64EncodedEmail = Base64.encodeURI(email);

        fetch("https://www.googleapis.com/gmail/v1/users/me/messages/send",
        {
            method:"POST",
            headers:{
                Authorization: "Bearer " + token,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                raw : base64EncodedEmail
            })
        })
        .then(re => re.json())
        .then((json) => {
            console.log(json)
        })
    }
}