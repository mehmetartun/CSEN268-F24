const { 
    logger,
    onCall,
} = require("./init.js");

exports.helloWorld = onCall(async (request) => {
    logger.info("Call to Hello World Function.");
    console.log(request.auth);
    return {message: "Hello World"};
})