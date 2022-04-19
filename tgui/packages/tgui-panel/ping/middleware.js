/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

<<<<<<< HEAD
import { pingSuccess } from './actions';
import { PING_INTERVAL } from './constants';
=======
import { pingFail, pingReply, pingSoft, pingSuccess } from './actions';
import { PING_QUEUE_SIZE, PING_TIMEOUT } from './constants';
>>>>>>> fd0f398d6f9 (tgui-panel: Soft ping (#66299))

export const pingMiddleware = store => {
  let initialized = false;
  let index = 0;
  const pings = [];
<<<<<<< HEAD
  const sendPing = () => { /* SKYRAT EDIT START - Trying to fix the chat
=======

  const sendPing = () => {
>>>>>>> fd0f398d6f9 (tgui-panel: Soft ping (#66299))
    for (let i = 0; i < PING_QUEUE_SIZE; i++) {
      const ping = pings[i];
      if (ping && Date.now() - ping.sentAt > PING_TIMEOUT) {
        pings[i] = null;
        store.dispatch(pingFail());
      }
    }
    const ping = { index, sentAt: Date.now() };
    pings[index] = ping;
    sendMessage({
      type: 'ping',
      payload: { index },
    });
    index = (index + 1) % PING_QUEUE_SIZE;*/ // SKYRAT EDIT END
  };

  return next => action => {
    const { type, payload } = action;

    if (!initialized) {
      initialized = true;
      sendPing();
    }

    if (type === pingSoft.type) {
      const { afk } = payload;
      // On each soft ping where client is not flagged as afk,
      // initiate a new ping.
      if (!afk) {
        sendPing();
      }
      return next(action);
    }

    if (type === pingReply.type) {
      const { index } = payload;
      const ping = pings[index];
      // Received a timed out ping
      if (!ping) {
        return;
      }
      pings[index] = null;
      return next(pingSuccess(ping));
    }

    return next(action);
  };
};
