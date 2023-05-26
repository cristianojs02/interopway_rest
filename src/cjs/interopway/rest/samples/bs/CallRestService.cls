/// <p style='text-align: justify;'>
///   <b>2023-05-12 - Cristiano José da Silva</b><br/>
///   Samples Business Service that call the Business Operation class <class>cjs.interopway.rest.bo.Operation</class>
/// </p>
Class cjs.interopway.rest.samples.bs.CallRestService Extends Ens.BusinessService
{

Parameter SETTINGS = "TargetBusinessHost";

/// The type of adapter used to communicate with external systems
Parameter ADAPTER = "Ens.Adapter";

/// The adapter instance
Property Adapter As Ens.Adapter;

/// Name of Business Operation to Call.
Property TargetBusinessHost As Ens.DataType.ConfigName;

/// Call Business Operation 
Method OnProcessInput(input As cjs.interopway.rest.bo.BaseRequest, Output output As cjs.interopway.rest.bo.BaseResponse, ByRef pHint As %String) As %Status
{
	Return ..SendRequestSync(..TargetBusinessHost, input, .output, 30)
}

}
