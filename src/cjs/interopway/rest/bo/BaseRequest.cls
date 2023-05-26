/// <p style='text-align: justify;'>
/// 	<b>2020-06-17 - Cristiano José da Silva</b><br/>
/// 	Base request to the Business Operation <class>cjs.interopway.rest.bo.Operation</class><br/>
/// 	This class can not be instantiated. Use one of the following subclasses:<br>
/// 	<ul>
/// 		<li><class>cjs.interopway.rest.bo.DeleteRequest</class> - To call a REST endpoint using HTTP DELETE<li>
///         <li><class>cjs.interopway.rest.bo.GetRequest</class> - To call a REST endpoint using HTTP GET<li>		
///         <li><class>cjs.interopway.rest.bo.PatchRequest</class> - To call a REST endpoint using HTTP PATCH<li>
/// 		<li><class>cjs.interopway.rest.bo.PostRequest</class> - To call a REST endpoint using HTTP POST<li>
/// 		<li><class>cjs.interopway.rest.bo.PutRequest</class> - To call a REST endpoint using HTTP PUT<li>
/// 	</ul>
/// </p>
Class cjs.interopway.rest.bo.BaseRequest Extends (%Persistent, Ens.Request) [ Abstract ]
{

Parameter RESPONSECLASSNAME As STRING = "cjs.interopway.rest.BaseResponse";

Property RequestDTO As cjs.interopway.rest.dto.Request;

Storage Default
{
<Data name="BaseRequestDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>RequestDTO</Value>
</Value>
</Data>
<DataLocation>^cjs.interopway6BF.BaseRequestD</DataLocation>
<DefaultData>BaseRequestDefaultData</DefaultData>
<IdLocation>^cjs.interopway6BF.BaseRequestD</IdLocation>
<IndexLocation>^cjs.interopway6BF.BaseRequestI</IndexLocation>
<StreamLocation>^cjs.interopway6BF.BaseRequestS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
