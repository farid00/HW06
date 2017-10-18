// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

//ATRRIBUTED to the NUMART REPO

import socket from "./socket"
let handlebars = require("handlebars");
let channel = socket.channel("updates:all", {})
$(function() {
  if (!$("#likes-template").length > 0) {
    // Wrong page.
    return;
  }

  let tt = $($("#likes-template")[0]);
  let code = tt.html();
  let tmpl = handlebars.compile(code);

  let dd = $($("#post-likes")[0]);
  let path = dd.data('path');
  let p_id = dd.data('post_id');

  let bb = $($("#like-button")[0]);

  // let bb = $($("#review-add-button")[0]);
  // let u_id = bb.data('user-id');

  function fetch_likes() {
    function got_likes(data) {
      let html = tmpl(data);
      dd.html(html);
    }

    $.ajax({
      url: path,
      data: {post_id: p_id},
      contentType: "application/json",
      dataType: "json",
      method: "GET",
      success: got_likes,
    });
  }

  function add_like() {

    let data = {like: {post_id: p_id}};
    var csrf = $('meta[name=csrf]').attr("content")
    $.ajax({
      url: path,
      data: JSON.stringify(data),
      headers: {
      	"X-CSRF-TOKEN": csrf
      },
      contentType: "application/json",
      dataType: "json",
      method: "POST",
      success: fetch_likes,
    });
  }


  bb.click(add_like);

  fetch_likes();
});

$(function() {

  let pt = $($("#post-template")[0]);
  let postCode = pt.html();
  let postTmpl = handlebars.compile(postCode);
  let postButton = $($("#post-add-button")[0])

  let target = $($("#post-target")[0]);



  function fetch_posts() {
    function got_posts(data) {
      let html = postTmpl(data);
      target.html(html);
    }

    $.ajax({
      url: "/api/posts",
      dataType: "json",
      method: "GET",
      conentType: "application/json",
      success: got_posts,
    });
  }

  function add_post() {
    let postData = $("#post-text").val();
    console.log('here')
    let pdata = JSON.stringify({post: {text: postData}});
    let csrf = $('meta[name=csrf]').attr("content")
    $.ajax({
      url: "/api/posts",
      data: pdata,
      headers: {
        "X-CSRF-TOKEN": csrf
      },
      contentType: "application/json",
      dataType: "json",
      method: "POST"
    });
  }

  channel.on("new_message", payload => {
    $("#postTable > tbody").prepend("<td>" + payload.username + "</td><td>" + payload.text + 
      "</td><td><a href=/posts/" + payload.id + " class= \"btn btn-primary\">Show</a></td>")
  });


  postButton.click(add_post);

  fetch_posts();
});