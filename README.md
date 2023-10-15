[Português Brasil](/README.pt-br.md)
---
# Interopway REST

How many times do we find ourselves rebuilding, copy-pasting, adapting, _Business Operations_ that make calls to REST services, and only adapting one or another part of the final code. This is annoying a lot. To resolve this our inconvenience, I present to you **Interopway REST,** a set of classes (a micro framework) that allows us to just add _Business Operation to Production_ and use it.

Let's understand how this works.

## Transport Objects

The objects responsible for transporting the data are grouped in the **cjs.interopway.rest.dto** package. Below we see a class diagram of its structure.

![RestDTO](/images/cjs_interopway_rest_dto.png)

In this package we find 3 classes:

*   **cjs.interopway.rest.dto.Base**: Base class for exchanging information by grouping HTTP request and response properties.
    *   **Body**: A stream containing the body of the request/response.
    *   **Headers**: A key:value array with the request/response headers.
    *   **JSONPayload**: A dynamic object, so if the content is a JSON, we can access it in a more user-friendly way.
*   **cjs.interopway.rest.dto.Request:** Transport object used for requests, extends class **cjs.interopway.rest.dto.Base** adding the property:
    *   **URL**: Endpoint address to call.
*   **cjs.interopway.rest.dto.Response:** Transport object used for requests, extends class **cjs.interopway.rest.dto.Base** adding the properties:
    *   **HTTPStatus**: Request processing HTTP status code.
    *   **InternalStatus**: IRIS internal status code.
    *   **InternalStatusText:** Decomposition of the InternalStatus property into a readable string.

## Messages

The Request/Response messages are defined in the package **cjs.interopway.rest.bo.** In the class diagram below we present only the most generic messages in the hierarchy that define the standard structure.

![BaseMessages](/images/cjs_interopway_rest_bo_BaseRequestCcjs_interopway_rest_bo_BaseResponse.png)

There are 12 message classes in this package.

*   **cjs.interopway.rest.bo.BaseRequest:** Abstract class for requests containing a reference to **cjs.interopway.rest.dto.Request.**
*   **cjs.interopway.rest.bo.BaseResponse:** Abstract class for responses containing a reference to **cjs.interopway.rest.dto.Response.**
*   **cjs.interopway.rest.bo.DeleteRequest:** Extends the class **cjs.interopway.rest.bo.BaseRequest** is used to do a **DELETE.**
*   **cjs.interopway.rest.bo.DeleteResponse:** Extends the class **cjs.interopway.rest.bo.BaseResponse** recebe a resposta de um **DELETE.**
*   **cjs.interopway.rest.bo.GetRequest:** Extends the class **cjs.interopway.rest.bo.BaseRequest** is used to do a **GET.**
*   **cjs.interopway.rest.bo.GetResponse:** Extends the class **cjs.interopway.rest.bo.BaseResponse** recebe a resposta de um **GET.**
*   **cjs.interopway.rest.bo.PatchRequest:** Extends the class **cjs.interopway.rest.bo.BaseRequest** is used to do a **PATCH.**
*   **cjs.interopway.rest.bo.PatchResponse:** Extends the class **cjs.interopway.rest.bo.BaseResponse** receives a response from a **PATCH.**
*   **cjs.interopway.rest.bo.PostRequest:** Extends the class **cjs.interopway.rest.bo.BaseRequest** is used to do a **POST.**
*   **cjs.interopway.rest.bo.PostResponse:** Extends the class **cjs.interopway.rest.bo.BaseResponse** receives a response from a **POST.**
*   **cjs.interopway.rest.bo.PutRequest:** Extends the class **cjs.interopway.rest.bo.BaseRequest** is used to do a **PUT.**
*   **cjs.interopway.rest.bo.PutResponse:** Extends the class **cjs.interopway.rest.bo.BaseResponse** receives a response from a **PUT.**

## Business Operation

![Operation](/images/cjs_interopway_rest_bo_Operation.png)

The class  **cjs.interopway.rest.bo.Operation** extends the default Business Operation **EnsLib.REST.Operation** which has some utility methods and is already configured with then **EnsLib.HTTP.OutboundAdapter** adapter.

This Business Operation has 5 Business Operation Methods, which are the methods that are in the MessageMap and are triggered when request messages are received:

*   **Delete**
*   **Get**
*   **Patch**
*   **Post**
*   **Put**

These 5 methods only dispatch the call to the **CallEndPoint** method, which is responsible for invoking the REST service according to each HTTP verb associated with each message.

The **GetHttpRequest** method instantiates an object of type **%Net.HttpResponse** and fills in the HTTP headers.

The **GetResponseHeaders** method retrieves all headers returned in the request response.

The **BeforeCallEndPoint** and **AfterCallEndPoint** methods are hook methods to be implemented in Business Operation subclasses, to perform actions before and after invoking the EndPoint, respectively. An example of use would be to call a login method before requests, and process the response object.

## Installation

Installation takes place via studio by importing the xml file with the project sources contained in the **/src/xmlexport/Interopway_REST.xml.**

The IPM package is also available for installation:

```objectscript
zpm "install interopway_rest"
```

## Example of Use

The project has a Test Production **cjs.interopway.rest.samples.InteropProducion** and a class with unit tests **cjs.interopway.rest.tests.InteropProduction**. Only the Business Operation is used in the tests, as he is the one who does all the work.

![productionConfiguration](/images/productionConfiguration.png)

To run the unit tests, copy the **/src/xmlexport/Interopway\_REST.xml**  
file to a directory, such as C:\\temp\\test.

Open a terminal session and assign the path in the global **^UnitTestRoot**

```objectscript
Set ^UnitTestRoot = "C:\temp\tests"
```

After defining the global run the unit test:

```objectscript
Do ##Class(%UnitTest.Manager).RunTest("", "/nodelete") 
```

This line of code will import, compile, run the class containing the unit tests. The /nodelete flag keeps the class source on the server.

Access the URL presented at the end of the execution and see the test results.

![unitTestResult](/images/unitTestResult.png)

If everything went well, it should look something like the image below.

![unitTests](/images/unitTests.png)

Below is the code for the **TestPostUser** and **CallBusinessService** method:

```objectscript
Method TestPostUser() As %Status
{
  #Dim statusCode As %Status                              = ..IsProductionRunning()
  #Dim request    As cjs.interopway.rest.bo.PostRequest   = ##Class(cjs.interopway.rest.bo.PostRequest).%New()
  #Dim response   As cjs.interopway.rest.bo.PostResponse  = ""
  #Dim requestDTO As cjs.interopway.rest.dto.Request      = ##Class(cjs.interopway.rest.dto.Request).%New()
  #Dim user       As %DynamicObject                       = {}
  //
  Set user.email              = "cristiano.js@gmail.com"
  Set user."first_name"       = "Cristiano José"
  Set user."last_name"        = "Silva"
  Set requestDTO.JSONPayload  = user
  Set requestDTO.URL          = ..#APIURL _ ..#USERENDPOINT
  Set request.RequestDTO      = requestDTO
  Set statusCode              = ..CallBusinesService(..#TARGETOPERATION, request, .response)
  If ($System.Status.IsOK(statusCode))
  {
    Do ..LogMessage("Usuário criado com uscesso: " _  response.ResponseDTO.JSONPayload.id)
  }
  Return statusCode
}

Method CallBusinesService(targetBusinessOperation As %String, request As cjs.interopway.rest.bo.BaseRequest, ByRef response As cjs.interopway.rest.bo.BaseResponse) As %Status [ Private ]
{
  #Dim statusCode As %Status            = $System.Status.OK()
  #Dim exception  As %Exception.General = ""
  Try
  {
    Set statusCode = ##Class(EnsLib.Testing.Service).SendTestRequest(targetBusinessOperation, request, .response,, 1)
    //
    Do $$$AssertStatusOK(statusCode, "Status Code from GetUser")
    //
    #Dim httpStatus As %Integer = $Extract(response.ResponseDTO.HTTPStatus, 1, 1)
    // Teste se o retorno é HTTPStatus está entre os status 200 é ok
    Do $$$AssertEquals(httpStatus, 2, "HTTP Status "_ response.ResponseDTO.HTTPStatus)
  }
  Catch (exception)
  {
    Set statusCode = exception.AsStatus()
  }
  Return statusCode
}
```

The **TestPostUser** method instantiates a message to make the post of type **cjs.interopway.rest.bo.PostRequest** and fills the body with a dynamic object containing the JSON to be sent to the REST Service, assigns the url of the service and invokes the **CallBusinessService** method which invokes the testing service and dispatches the message to Business Operation. Note that all other test methods follow the same principle, except for the **GET** and **DELETE** method which have no body.

With Interopway REST, we only add the Business Operation to Production, configure or pass the access data via messages and we worry about implementing the business rules of the integrations and no longer with the code to make the connection with external services.