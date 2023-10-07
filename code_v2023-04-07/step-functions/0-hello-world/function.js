export const handler = async (event, context, callback) => {
    callback(null, "Hello, " + event.who + "!");
};