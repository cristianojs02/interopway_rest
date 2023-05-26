/// <p>
/// <class>%SerialObject</class> to be used by the requests to be send to the Business Operations
/// </p>
Class cjs.interopway.rest.dto.Request Extends (%SerialObject, %XML.Adaptor, cjs.interopway.rest.dto.Base)
{

/// URL to the end point to be called by the Business Operation.
Property URL As %String(MAXLEN = "");

Storage Default
{
<Data name="RequestState">
<Value name="1">
<Value>Headers</Value>
</Value>
<Value name="2">
<Value>Body</Value>
</Value>
<Value name="3">
<Value>URL</Value>
</Value>
</Data>
<State>RequestState</State>
<StreamLocation>^cjs.interopway.res6DED.RequestS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
