import Pusher from "pusher-js";

const UPDATE_CHANNEL = 'updates-channel'
const client = new Pusher("e27b9c59403188b30484", {
  cluster: "eu",
  forceTLS: true
});

client.subscribe(UPDATE_CHANNEL)

export default client