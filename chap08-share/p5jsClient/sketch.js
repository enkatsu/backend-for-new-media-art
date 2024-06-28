let socket = null

function setup() {
    createCanvas(windowWidth, windowHeight)
    socket = new WebSocket("ws://localhost:5001")
}

function draw() {
    background(0)
    
    if (mouseIsPressed) {
        noStroke()
        fill(255, 255, 200)
        circle(mouseX, mouseY, 50)
    }
}

function touchStarted() {
    if (!socket) {
        return
    }

    socket.send(JSON.stringify({
        type: 'lightup',
        x: mouseX,
        y: mouseY,
    }))
}

function touchMoved() {
    if (!socket) {
        return
    }
    
    socket.send(JSON.stringify({
        type: 'move',
        x: mouseX,
        y: mouseY,
    }))
}

function touchEnded() {
    if (!socket) {
        return
    }

    socket.send(JSON.stringify({
        type: 'lightoff',
        x: mouseX,
        y: mouseY,
    }))
}
