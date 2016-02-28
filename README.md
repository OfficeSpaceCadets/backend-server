#Backend Server

##API

The API calls will require authentication via a token in the HTTP header of each request.

### PUT /ping

This is the session creation and keep alive for all pairing sessions.

    {
      "user_ids": [ 1, 2, 3 ]
    }


### GET /settings

This is the means of pushing out settings to any and all devices attached to this server.

    {
    	"first property": "first property's value"
       	"second property": "second property's value"
    	...
    }

