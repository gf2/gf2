## Here we define user-facing APIs

### Overview
For all the api interfaces, the server will return json format data by default.
However, if you specify a "jsonp" parameter in the request, the server will return a jsonp format data.


Use GET method by default, unless specified as POST.


For login requred APIs, return { "status": "LOGGED_OUT" } if user not logged in. 

----
###### Path:
/a/check_email

###### Require login:
No

###### Parameters:
email: string

###### Returns:
<pre><code>
{
  "available": False,
}
</code></pre>

----
###### Path (POST):
/a/signup

###### Require login:
No

###### Parameters:
email: Required

nickname: Optional

password


###### Returns:
<pre><code>
{
  "result": "SUCCESS", // or "EMAIL_USED", "INVALID_EMAIL", "INVALID_PASSWORD"
  // UserObject
  "user": {
    "nickname": "Zero",
    "email": "zero@gmail.com",
    "language": "en",  // Display language, can be changed by user.
    "country": "CN"  // Country is determined by IP->Geo lookup, for potential legal contraints.
  }
}
</code></pre>

----
###### Path (POST):
/a/set_language

###### Require login:
Yes

###### Parameters:
language: string  // Such as "en", "us"

###### Returns:
<pre><code>
{
  "result": "SUCCESS" // Or "FAILURE", "NOT_SUPPORTED"
}
</code></pre>

----
###### Path (POST):
/a/login

###### Require login:
No

###### Parameters:
email: string

password: string


###### Returns:
<pre><code>
// Success
{
  "result": "SUCCESS",
  "user": UserObject, // See above for definition.
  "status": "OK",
}

// Failure:
{
  "result": "FAILURE",
  "status": "LOGGED_OUT"
}
</code></pre>


----
###### Path:
/a/get_user_info

###### Require login:
Yes

###### Parameters:
No params, check user session.

###### Returns:
<pre><code>
// Logged in user:
{
  "user": UserObject, // See above for definition.
  "status": "OK"
}

// Logged out user:
{
  "status": "LOGGED_OUT"
}
</code></pre>

----
###### Path:
/a/get_problemsets

###### Description:
Get a list of ProblemSets.

###### Require login:
Yes

###### Parameters:
offset: Optional, default 0, integral offset for paging.

limit: Optional, default 10, num of tests to return.

###### Returns:
<pre><code>
{
  "results": [
    {
      "problemset_id": "id_tpo1",
      
      "name": "TPO 1 - The Official Test",
      
      // Whether this is a free test.
      "is_free": False,
      
      // Whether the user has paid for this test.
      "has_paid": True,
      
      // Whether the user has completed the test before. If so, we'll show a link to view test history.
      "has_completed": True,
      
      // How many retries left 
      "remain_retry": 2,
    },
    {
      ...
    }
  ],
  
  // total num of results, for paging.
  "num_results": 24,
  
  // TODO: StatusCode definition
  "status": "OK",
}
</code></pre>
