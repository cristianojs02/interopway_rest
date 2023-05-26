Class cjs.interopway.rest.bo.GetRequest Extends (%Persistent, cjs.interopway.rest.bo.BaseRequest)
{

Parameter RESPONSECLASSNAME As STRING = "cjs.interopway.rest.bo.GetResponse";

Storage Default
{
<Data name="GetRequestDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>RequestDTO</Value>
</Value>
</Data>
<DataLocation>^cjs.interopway.r6BF.GetRequestD</DataLocation>
<DefaultData>GetRequestDefaultData</DefaultData>
<IdLocation>^cjs.interopway.r6BF.GetRequestD</IdLocation>
<IndexLocation>^cjs.interopway.r6BF.GetRequestI</IndexLocation>
<StreamLocation>^cjs.interopway.r6BF.GetRequestS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
