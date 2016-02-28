#Backend Server

This is the backend server for the Office Space Cadets' Hackathon project. This is currently deployed to: *https://osc-backend.herokuapp.com*

##Authentication

Authentcation requires an HTTP header to be present in each request. 

    Authorization: Token token=<token goes here>

The authorized tokens for production are found in the api\_tokens database. The database seed file provides the token '24ee441f6823271610ea6c4e57d8541b'.

##API

The API calls will require authentication via a token in the HTTP header of each request.

### POST /api/ping

This is the session creation and keep alive for all pairing sessions.

    {
      "user_ids": [ 1, 2, 3 ]
    }


### GET /api/settings (coming soon...)

This is the means of pushing out settings to any and all devices attached to this server.

    {
    	"first property": "first property's value"
       	"second property": "second property's value"
    	...
    }

