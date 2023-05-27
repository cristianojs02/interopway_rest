/// <p style='text-align: justify;'>
/// 	<b>2023-05-11 - Cristiano José da Silva</b><br/>
/// 	Tests set for Business Opeation class: <class>cjs.interopway.rest.bo.Operation</class>
/// 	<br/><br/>
/// 	The tests are executed aganist a test API: https://reqres.in/
/// </p>
Class cjs.interopway.rest.tests.InteropProduction Extends %UnitTest.TestProduction
{

/// Class name of the production.  It must contain the production class name.
Parameter PRODUCTION As STRING = "cjs.interopway.rest.samples.InteropProducion";

/// Name of target Business Operation
Parameter TARGETOPERATION As STRING = "Reqres REST Operation";

/// Base API URL
Parameter APIURL As STRING = "https://reqres.in/";

/// Endpoint para tratativa de usuário, é utilizda em todos os verbos, POST, GET, PUT, PATCH, DELETE
Parameter USERENDPOINT As STRING = "api/users";

/// Id do usuário a ser usado nos testes. É um número baixo porque a base se renova constantemente
Parameter IDUSUARIO As INTEGER = 1;

/// Run by <B>RunTest</B> once <a href="#OnBeforeAll">before any test methods</a> in the test class are run. Can be used to set up a 
/// test environment that will be later cleaned up by <B>OnAfterAllTests</B>. 
/// <br>NOTE: OnBeforeAllTests does not currently support skipping tests.  Calls to $$$AssertSkipped in
/// OnBeforeAllTests may result in tests appearing to pass rather than being skipped.
/// <br><br>Example: Setup and Cleanup of an environment: 
/// <pre>
/// Method OnBeforeAllTests() As %Status
/// {
/// 	//do setup stuff here
///  	set ^inputMessage = "input message"
/// 	quit $$$OK
/// }
/// Method OnAfterAllTests() As %Status
/// {
/// 	//do clean up stuff here
/// 	kill ^inputMessage
/// 	quit $$$OK
/// }</pre>
/// 
Method OnBeforeAllTests() As %Status
{
	Return ..IsProductionRunning()
}

/// TestMethod for Business Operation Method Get
Method TestGetUser() As %Status
{
	#Dim request		As cjs.interopway.rest.bo.GetRequest	= ##Class(cjs.interopway.rest.bo.GetRequest).%New()
	#Dim response		As cjs.interopway.rest.bo.GetResponse	= ""
	#Dim requestDTO	As cjs.interopway.rest.dto.Request		= ##Class(cjs.interopway.rest.dto.Request).%New()
	//
	Set requestDTO.URL			= ..#APIURL _ ..#USERENDPOINT _ "/" _ ..#IDUSUARIO
	Set request.RequestDTO	= requestDTO
	//
	Return ..CallBusinesService(..#TARGETOPERATION, request, .response)
}

/// Método para a criação de um novo usuário.
Method TestPostUser() As %Status
{
	#Dim statusCode	As %Status = ..IsProductionRunning()
	If ($System.Status.IsError(statusCode))
	{
		Return statusCode
	}
	#Dim request		As cjs.interopway.rest.bo.PostRequest		= ##Class(cjs.interopway.rest.bo.PostRequest).%New()
	#Dim response		As cjs.interopway.rest.bo.PostResponse	= ""
	#Dim requestDTO	As cjs.interopway.rest.dto.Request			= ##Class(cjs.interopway.rest.dto.Request).%New()
	#Dim user				As %DynamicObject												= {}
	//
	Set user.email							= "cristiano.js@gmail.com"
	Set user."first_name"				= "Cristiano José"
	Set user."last_name"				= "Silva"
	Set requestDTO.JSONPayload	= user
	Set requestDTO.URL					= ..#APIURL _ ..#USERENDPOINT
	Set request.RequestDTO			= requestDTO
	Set statusCode							= ..CallBusinesService(..#TARGETOPERATION, request, .response)
	If ($System.Status.IsOK(statusCode))
	{
		Do ..LogMessage("Usuário criado com uscesso: " _  response.ResponseDTO.JSONPayload.id)
	}
	Return statusCode
}

/// Método para a atualização de usuário.
Method TestPutUser() As %Status
{
	#Dim statusCode	As %Status = ..IsProductionRunning()
	If ($System.Status.IsError(statusCode))
	{
		Return statusCode
	}
	#Dim request		As cjs.interopway.rest.bo.PutRequest		= ##Class(cjs.interopway.rest.bo.PutRequest).%New()
	#Dim response		As cjs.interopway.rest.bo.PutResponse		= ""
	#Dim requestDTO	As cjs.interopway.rest.dto.Request			= ##Class(cjs.interopway.rest.dto.Request).%New()
	#Dim user				As %DynamicObject												= {}
	//
	Set user."name"							= "Cristiano José"
	Set user."job"							= "Architect"
	Set requestDTO.JSONPayload	= user
	Set requestDTO.URL					= ..#APIURL _ ..#USERENDPOINT _ "/" _ ..#IDUSUARIO
	Set request.RequestDTO			= requestDTO
	//
	Return ..CallBusinesService(..#TARGETOPERATION, request, .response)
}

/// Método para a atualização de usuário.
Method TestPatchUser() As %Status
{
	#Dim statusCode	As %Status = ..IsProductionRunning()
	If ($System.Status.IsError(statusCode))
	{
		Return statusCode
	}
	#Dim request		As cjs.interopway.rest.bo.PatchRequest		= ##Class(cjs.interopway.rest.bo.PatchRequest).%New()
	#Dim response		As cjs.interopway.rest.bo.PatchResponse	= ""
	#Dim requestDTO	As cjs.interopway.rest.dto.Request			= ##Class(cjs.interopway.rest.dto.Request).%New()
	#Dim user				As %DynamicObject												= {}
	//
	Set user."name"							= "Cristiano Silva"
	Set user."job"							= "Engineer"
	Set requestDTO.JSONPayload	= user
	Set requestDTO.URL					= ..#APIURL _ ..#USERENDPOINT _ "/" _ ..#IDUSUARIO
	Set request.RequestDTO			= requestDTO
	//
	Return ..CallBusinesService(..#TARGETOPERATION, request, .response)
}

/// Método para a exclusão de usuário.
Method TestDeleteUser() As %Status
{
	#Dim statusCode	As %Status = ..IsProductionRunning()
	If ($System.Status.IsError(statusCode))
	{
		Return statusCode
	}
	#Dim request		As cjs.interopway.rest.bo.DeleteRequest		= ##Class(cjs.interopway.rest.bo.DeleteRequest).%New()
	#Dim response		As cjs.interopway.rest.bo.DeleteResponse	= ""
	#Dim requestDTO	As cjs.interopway.rest.dto.Request			= ##Class(cjs.interopway.rest.dto.Request).%New()
	//
	Set requestDTO.URL			= ..#APIURL _ ..#USERENDPOINT _ "/" _ ..#IDUSUARIO
	Set request.RequestDTO	= requestDTO
	//
	Return ..CallBusinesService(..#TARGETOPERATION, request, .response)
}

/// <p style='text-align: justify;'>
///  Dispatch message to Business Service.
/// <p style='text-align: justify;'>
Method CallBusinesService(targetBusinessOperation As %String, request As cjs.interopway.rest.bo.BaseRequest, ByRef response As cjs.interopway.rest.bo.BaseResponse) As %Status [ Private ]
{
	#Dim statusCode	As %Status						= $System.Status.OK()
	#Dim exception	As %Exception.General	= ""
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

/// <p style='text-align: justify;'>
/// 	Check if Production is running, in case of Production is stopped I start it.
/// </p>
Method IsProductionRunning() As %Boolean [ Private ]
{
	#Dim statusCode As %Status = $System.Status.OK()
	If ('##Class(Ens.Director).IsProductionRunning())
	{
		Do ..LogMessage("Production stopped! Starting...")
		//
		Set statusCode = ##Class(Ens.Director).StartProduction()
		//
		Do $$$AssertStatusOK(statusCode, "Status start Production!")
	}
	Return statusCode
}

}
