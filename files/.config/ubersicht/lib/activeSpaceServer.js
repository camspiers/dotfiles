const express = require('express');
const {spawn} = require('child_process');
const EventEmitter = require('events');

// We only want one ActivesSpaces command running
class ActiveSpaceEventEmitter extends EventEmitter {}

// Set up and event emitter for the actives spaces process
const activeSpaceEvents = new ActiveSpaceEventEmitter();
const activeSpaces = spawn(
  'stdbuf', //the stdbuf command
  [
    '-i0',
    '-o0',
    '-e0', //disable all buffering
    'activespace',
  ],
);

activeSpaces.stdout.on('data', data => {
  activeSpaceEvents.emit('changed', data.toString());
});

const app = express();

// Setup cors
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  next();
});

// SSE Events API
app.get('/', (req, res) => {
  res.writeHead(200, {
    'Content-Type': 'text/event-stream',
    'Cache-Control': 'no-cache',
    Connection: 'keep-alive',
  });

  function onChanged(data) {
    res.write(`data: ${data}\n\n`);
  }

  // When the active space changes, send the SSE
  activeSpaceEvents.on('changed', onChanged);

  req.on('close', () => activeSpaceEvents.removeListener('changed', onChanged));
});

// Port chosen randomly
app.listen(15997);
