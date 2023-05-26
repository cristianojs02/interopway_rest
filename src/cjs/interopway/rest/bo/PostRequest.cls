Class cjs.interopway.rest.bo.PostRequest Extends (%Persistent, cjs.interopway.rest.bo.BaseRequest)
{

Parameter RESPONSECLASSNAME As STRING = "cjs.interopway.rest.bo.PostResponse";

Storage Default
{
<Data name="PostRequestDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>RequestDTO</Value>
</Value>
</Data>
<DataLocation>^cjs.interopway6BF.PostRequestD</DataLocation>
<DefaultData>PostRequestDefaultData</DefaultData>
<IdLocation>^cjs.interopway6BF.PostRequestD</IdLocation>
<IndexLocation>^cjs.interopway6BF.PostRequestI</IndexLocation>
<StreamLocation>^cjs.interopway6BF.PostRequestS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
