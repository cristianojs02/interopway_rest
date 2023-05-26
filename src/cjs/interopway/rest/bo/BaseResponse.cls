/// <p style='text-align: justify;'>
/// 	<b>2020-06-17 - Cristiano José da Silva</b><br/>
/// 	Base response to the Business Operation <class>cjs.interopway.rest.bo.Operation</class><br/>
/// 	This class can not be instantiated. Use one of the following subclasses:<br>
/// 	<ul>
/// 		<li><class>cjs.interopway.rest.bo.DeleteResponse</class> - Response of a call REST using HTTP DELETE<li>
///         <li><class>cjs.interopway.rest.bo.GetResponse</class> - Response of a call REST using HTTP GET<li>		
///         <li><class>cjs.interopway.rest.bo.PatchResponse</class> - Response of a call REST using HTTP PATCH<li>
/// 		<li><class>cjs.interopway.rest.bo.PostResponse</class> - Response of a call REST using HTTP POST<li>
/// 		<li><class>cjs.interopway.rest.bo.PutResponse</class> - Response of a call REST using HTTP PUT<li>
/// 	</ul>
/// </p>
Class cjs.interopway.rest.bo.BaseResponse Extends (%Persistent, Ens.Response)
{

Property ResponseDTO As cjs.interopway.rest.dto.Response;

/// Subclass responsablity
Method DoSpecificAction(args...)
{
}

Storage Default
{
<Data name="BaseResponseDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ResponseDTO</Value>
</Value>
</Data>
<DataLocation>^cjs.interopway6BF.BaseResponseD</DataLocation>
<DefaultData>BaseResponseDefaultData</DefaultData>
<IdLocation>^cjs.interopway6BF.BaseResponseD</IdLocation>
<IndexLocation>^cjs.interopway6BF.BaseResponseI</IndexLocation>
<StreamLocation>^cjs.interopway6BF.BaseResponseS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
