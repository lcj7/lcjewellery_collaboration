// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

var publisher;
var subscribers = {};

function initSession() {
 session().addEventListener('sessionConnected', sessionConnectedHandler);
 session().addEventListener("streamCreated", streamCreatedHandler);
 session().addEventListener('streamDestroyed', streamDestroyedHandler);
}

function connectSession(apiKey, token) {
  session().connect(apiKey, token);
}

function streamCreatedHandler(event) {
  for (var i = 0; i < event.streams.length; i++) {
    addStream(event.streams[i]);
  }
}

function streamDestroyedHandler(event) {
  for (var i = 0; i < event.streams.length; i++) {
    removeStream(event.streams[i]);
  }
}

function removeStream(stream) {
  delete subscribers[stream.streamId];
}

function sessionConnectedHandler(event) {
  publish();

  for (var i = 0; i < event.streams.length; i++) {
    addStream(event.streams[i]);
  }
}

function publish() {
  if (!publisher) {
    var publisherObj;
    var parentDiv = document.getElementById("publisher" + numberOfStreams());
    publisherObj = document.createElement('div');
    publisherObj.setAttribute('id', 'opentok_publisher');
    parentDiv.appendChild(publisherObj);
    publisher = session().publish('opentok_publisher');
  }
}

//--------------------------------------
function addStream(stream) {
  // Check if this is the stream that I am publishing. If not
  // we choose to subscribe to the stream.
  if (stream.connection.connectionId == session().connection.connectionId) {
    return;
  }

  var div = document.createElement('div');
  var divId = stream.streamId;
  var streamNumber = numberOfStreams() + 1;
  div.setAttribute('id', divId);
  var elementID = "publisher" + streamNumber;
  document.getElementById(elementID).appendChild(div);
  subscribers[stream.streamId] = session().subscribe(stream, divId);
}

function numberOfStreams() {
  return Object.keys(subscribers).length + 1;
}

function session() {
  var sessionData = $("#session").data("session");

  if (!sessionData) {
    sessionData = TB.initSession($("#session").data("sessionIdent"));
    $("#session").data("session", sessionData);
  }

  return sessionData;
}