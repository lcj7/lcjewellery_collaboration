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

var videos = 1;

var publisher;
var publisherObj;

var subscribers = {};
var subscriberObj = {};

function sessionConnectedHandler(event) {
  publish();

  for (var i = 0; i < event.streams.length; i++) {
    addStream(event.streams[i]);
  }
}

function streamCreatedHandler(event) {
  for (var i = 0; i < event.streams.length; i++) {
    addStream(event.streams[i]);
  }
}

//--------------------------------------
function addStream(stream) {
  // Check if this is the stream that I am publishing. If not
  // we choose to subscribe to the stream.
  if (stream.connection.connectionId == session.connection.connectionId) {
    return;
  }

  videos++;

  var div = document.createElement('div');
  var divId = stream.streamId;
  div.setAttribute('id', divId);
  var elementID = "publisher" + videos;
  console.log(elementID);
  document.getElementById(elementID).appendChild(div);
  subscriberObj[stream.streamId] = div;
  subscribers[stream.streamId] = session.subscribe(stream, divId);
}

  function streamDestroyedHandler(event) {
    videos--;
  }

function publish() {
  if (!publisher) {
    var parentDiv = document.getElementById("publisher" + videos);
    publisherObj = document.createElement('div');
    publisherObj.setAttribute('id', 'opentok_publisher');
    parentDiv.appendChild(publisherObj);
    publisher = session.publish('opentok_publisher');
  }
}