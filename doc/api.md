## Here we define user-facing APIs

### Overview
For all the api interfaces, the server will return json format data by default.
However, if you specify a "jsonp" parameter in the request, the server will return a jsonp format data.

----
###### Path:
/a/get_tests

###### Description:
Get a list of tests.

###### Method:
Get

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
      "test_id": "id_tpo1",
      
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
