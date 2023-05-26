Include Ensemble

Class cjs.interopway.rest.dto.Response Extends (%SerialObject, %XML.Adaptor, cjs.interopway.rest.dto.Base)
{

/// HTTP Status code sent by the called endpoint.
Property HTTPStatus As %String;

Property InternalStatus As %Status(XMLPROJECTION = "NONE") [ InitialExpression = {$System.Status.OK()} ];

/// <class>%Status</class> result of the call to the endpoint.
/// Text data of <property>InternalStatus</property>
Property InternalStatusText As %String(MAXLEN = "") [ Calculated, SqlComputeCode = { Set {InternalStatusText} = ##Class(cjs.interopway.rest.dto.Response).GetInternalStatusText({InternalStatus})}, SqlComputed, Transient ];

Method InternalStatusTextGet() As %String
{
    Return ..GetInternalStatusText(..InternalStatus)
}

ClassMethod GetInternalStatusText(statusCode As %Status) As %String
{
    If ($System.Status.IsError(statusCode))
    {
        Return $System.Status.GetErrorText(statusCode)
    }
    Return "OK"
}

Storage Default
{
<Data name="ResponseState">
<Value name="1">
<Value>HTTPStatus</Value>
</Value>
<Value name="2">
<Value>Body</Value>
</Value>
<Value name="3">
<Value>Headers</Value>
</Value>
<Value name="4">
<Value>InternalStatus</Value>
</Value>
</Data>
<State>ResponseState</State>
<StreamLocation>^cjs.interopway.re6DED.ResponseS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
