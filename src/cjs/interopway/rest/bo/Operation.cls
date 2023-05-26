Class cjs.interopway.rest.bo.Operation Extends EnsLib.REST.Operation
{

Parameter ADAPTER As STRING = "EnsLib.HTTP.OutboundAdapter";

Property Adapter As EnsLib.HTTP.OutboundAdapter;

/// Execute a HTTP DELETE
Method Delete(request As cjs.interopway.rest.bo.DeleteRequest, Output response As cjs.interopway.rest.bo.DeleteResponse) As %Status
{
	Return ..CallEndPoint("DELETE", request, .response)
}

/// Execute a HTTP GET
Method Get(request As cjs.interopway.rest.bo.GetRequest, Output response As cjs.interopway.rest.bo.GetResponse) As %Status
{
	Return ..CallEndPoint("GET", request, .response)
}

/// Execute a HTTP PATCH
Method Patch(request As cjs.interopway.rest.bo.PatchRequest, Output response As cjs.interopway.rest.bo.PatchResponse) As %Status
{
	Return ..CallEndPoint("PATCH", request, .response)
}

/// Execute a HTTP POST
Method Post(request As cjs.interopway.rest.bo.PostRequest, Output response As cjs.interopway.rest.bo.PostResponse) As %Status
{
	Return ..CallEndPoint("POST", request, .response)
}

/// Execute a HTTP PUT
Method Put(request As cjs.interopway.rest.bo.PutRequest, Output response As cjs.interopway.rest.bo.PutResponse) As %Status
{
	Return ..CallEndPoint("PUT", request, .response)
}

/// Call the REST endpoint according to the httpMethod
Method CallEndPoint(httpMethod As %String, request As cjs.interopway.rest.bo.BaseRequest, Output response As cjs.interopway.rest.bo.BaseResponse) As %Status [ Private ]
{
	#Dim statusCode	As %Status						= $System.Status.OK()
	#Dim exception	As %Exception.StatusException	= ""
	Try
	{
		Do request.NewResponse(.response)
		Do ..BeforeCallEndPoint(request)
		//
		#Dim requestDTO			As cjs.interopway.rest.dto.Request	= request.RequestDTO
		#Dim responseDTO		As cjs.interopway.rest.dto.Response	= ##Class(cjs.interopway.rest.dto.Response).%New()
		#Dim httpRequestBody	As %String							= 1
		#Dim httpRequest		As %Net.HttpRequest					= ..GetHttpRequest(requestDTO.Headers)
		#Dim httpResponse		As %Net.HttpResponse				= ""
		//
		Set response.ResponseDTO		= responseDTO
		Set httpRequestBody(1)			= request.RequestDTO.Body
		Set responseDTO.InternalStatus	= ..Adapter.SendFormDataArray(.httpResponse, httpMethod, httpRequest , "", .httpRequestBody , requestDTO.URL)
		If ($System.Status.IsError(responseDTO.InternalStatus)) 
		{
			$$$LOGSTATUS(statusCode)
		}
		If ($IsObject(httpResponse))
		{
			Set responseDTO.Headers		= ..GetResponseHeaders(httpResponse)
			Set responseDTO.Body		= httpResponse.Data
			Set responseDTO.HTTPStatus	= httpResponse.StatusCode
		}
		Do ..AfterCallEndPoint(request, .response)
	}
	Catch(exception)
	{
		Set responseDTO.InternalStatus	= exception.AsStatus()
		Set statusCode					= responseDTO.InternalStatus
	}
	Return statusCode
}

/// Return a instance of <class><%ArrayOfDataTypes/class> with HTTP response headers
Method GetResponseHeaders(httpResponse As %Net.HttpResponse) As %ArrayOfDataTypes [ Private ]
{
	#Dim headers	As %ArrayOfDataTypes	= ##Class(%ArrayOfDataTypes).%New()
	#Dim headerName	As %String				= ""
	While (1)
	{
		Set headerName = httpResponse.GetNextHeader(headerName)
		If (headerName = "")
		{
			Quit
		}
		Do headers.SetAt(httpResponse.GetHeader(headerName), headerName)
	}
	Return headers
}

/// Create an instance of <class>%Net.HttpRequest</class> with basic headers and set your headers as needed.
Method GetHttpRequest(headerArray As %ArrayOfDataTypes) As %Net.HttpRequest [ Private ]
{
	#Dim httpRequest	As %Net.HttpRequest	= ##Class(%Net.HttpRequest).%New()
	#Dim header			As %String			= ""
	#Dim indexHeaders	As %Integer			= 0
	For indexHeaders = 1 : 1 : headerArray.Count()
	{
		#Dim value	As %String	= headerArray.GetNext(.header)
		//
		Do httpRequest.SetHeader(header, value)
	}
	Return httpRequest
}

/// Subclass responsibility, commom used to do login or other logic need befor call endpoint.
Method BeforeCallEndPoint(request As Ens.Request) [ Private ]
{
}

/// Subclass responsibility, commom used to liberate some resource like a token or to process response.
Method AfterCallEndPoint(request As Ens.Request, response As Ens.Response) [ Private ]
{
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="cjs.interopway.rest.bo.GetRequest"> 
		<Method>Get</Method>
	</MapItem>
	<MapItem MessageType="cjs.interopway.rest.bo.PostRequest"> 
		<Method>Post</Method>
	</MapItem>
	<MapItem MessageType="cjs.interopway.rest.bo.PutRequest"> 
		<Method>Put</Method>
	</MapItem>
	<MapItem MessageType="cjs.interopway.rest.bo.PatchRequest"> 
		<Method>Patch</Method>
	</MapItem>
	<MapItem MessageType="cjs.interopway.rest.bo.DeleteRequest"> 
		<Method>Delete</Method>
	</MapItem>
</MapItems>
}

}
