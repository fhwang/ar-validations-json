ar-validations-json
===================

A library that serializes ActiveRecord validations into JSON, to be used
by rich-client apps in helping them do some validation work before
trying to send data to the Rails server. 

The goal is to keep validation logic in one place -- the server -- while
also allowing clients to know about that validation logic and use it for
better user feedback and fewer wasted HTTP requests.

