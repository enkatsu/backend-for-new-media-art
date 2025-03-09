const url = 'ws://localhost:1880/ws/paint';
let socket = null;

const lines = [];
const unfinishedLines = {};

function setup() {
    socket = new WebSocket(url);
    socket.addEventListener('open', (event) => {
    });  
    socket.addEventListener('message', (event) => {
        const data = JSON.parse(event.data);
        switch (data.type) {
            case 'start':
                unfinishedLines[data.painterId] = [];
                break;
            case 'add':
                unfinishedLines[data.painterId].push(data.point);
                break;
            case 'end':
                lines.push(unfinishedLines[data.painterId]);
                delete unfinishedLines[data.painterId];
                break;
            default:
                break;
        }
    });

    createCanvas(640, 480);
}

function draw() {
    background(0);

    stroke(255);
    noFill();
    for (const painterId in unfinishedLines) {
        beginShape();
        for (const p of unfinishedLines[painterId]) {
            vertex(p.x, p.y);
        }
        endShape();
    }

    for (const line of lines) {
        beginShape();
        for (const p of line) {
            vertex(p.x, p.y);
        }
        endShape();
    }
}

function mousePressed() {
    socket.send(JSON.stringify({type: 'start'}));
}

function mouseDragged() {
    socket.send(JSON.stringify({
        type: 'add',
        point: {
            x: mouseX,
            y: mouseY,
        }
    }));
}

function mouseReleased() {
    socket.send(JSON.stringify({type: 'end'}));
}
