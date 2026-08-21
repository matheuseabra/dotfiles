import net from "node:net";

const SOURCE = "herdr:opencode";
const AGENT = "opencode";
const RETRY_DELAYS = [100, 400, 1_000];

function report(sessionID) {
  const paneId = process.env.HERDR_PANE_ID;
  const socketPath = process.env.HERDR_SOCKET_PATH;
  if (!paneId || !socketPath) return Promise.resolve();

  return new Promise((resolve) => {
    const socket = net.createConnection(socketPath, () => {
      socket.write(`${JSON.stringify({
        id: `${SOURCE}:tui:${Date.now()}`,
        method: "pane.report_agent_session",
        params: {
          pane_id: paneId,
          source: SOURCE,
          agent: AGENT,
          agent_session_id: sessionID,
          session_start_source: "select",
        },
      })}\n`);
    });
    const finish = () => {
      socket.destroy();
      resolve();
    };
    socket.setTimeout(500, finish);
    socket.on("data", finish);
    socket.on("error", finish);
    socket.on("end", finish);
    socket.on("close", resolve);
  });
}

export default {
  id: "herdr.opencode.session-selection",
  tui: async (api) => {
    if (process.env.HERDR_ENV !== "1" || !process.env.HERDR_SOCKET_PATH || !process.env.HERDR_PANE_ID) return;

    let selected;
    let retry = 0;
    let nextReport = 0;
    let pending = false;
    const sync = async () => {
      const route = api.route.current;
      const sessionID = route?.name === "session" ? route.params?.sessionID : undefined;
      const session = typeof sessionID === "string" && sessionID ? api.state.session.get(sessionID) : undefined;
      if (!session || session.parentID) {
        selected = undefined;
        retry = 0;
        nextReport = 0;
        return;
      }
      if (sessionID !== selected) {
        selected = sessionID;
        retry = 0;
        nextReport = 0;
      }
      if (pending || Date.now() < nextReport) return;
      pending = true;
      try { await report(sessionID); } finally { pending = false; }
      if (selected !== sessionID) return;
      const delay = RETRY_DELAYS[retry++];
      nextReport = delay === undefined ? Number.POSITIVE_INFINITY : Date.now() + delay;
    };

    await sync();
    const timer = setInterval(() => void sync(), 100);
    api.lifecycle.onDispose(() => clearInterval(timer));
  },
};
