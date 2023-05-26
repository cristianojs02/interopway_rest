/// <p style='text-align: justify;'>
///   <b>2022-03-26 - Cristiano José da Silva</b><br/>
///   Base class with comom properties to dto objects used by the messages to call REST end points.
/// </p>
Class cjs.interopway.rest.dto.Base [ Abstract ]
{

/// HTTP Headers to send/receive to/from the end point.
Property Headers As array Of %String(MAXLEN = "");

/// JSON Stream with the content to send/receive to/from the end point.
Property Body As %Stream.GlobalCharacter;

/// Calculated property to do a simple way to access the <property>Body</property> via a instance 
/// of <class>%DynamicAbstractObject</class> because could be a JSON Objec or a JSON array.
Property JSONPayload As %DynamicAbstractObject(XMLPROJECTION = "NONE") [ Transient ];

/// <p>
/// Getter Method to the property <property>JSONPayload</property>, read the raw content of the property <property>Body</property> and returns a 
/// instance of <class>%DynamicAbstractObject</class>
/// </p>
Method JSONPayloadGet() As %DynamicAbstractObject
{
	#Dim exception	As %Exception.General	= ""
	Try
	{
		If (..Body.Size = 0)
		{
			Return ""
		}
		If ('$IsObject(i%JSONPayload))
		{
			Set i%JSONPayload = {}.%FromJSON(..Body)
		}
		Return i%JSONPayload
	}
	Catch (exception)
	{
		Return ""
	}
	Return ""
}

/// <p>
/// Setter Method to the property <property>JSONPayload</property>, export JSON structure the property <property>Body</property>.
/// </p>
Method JSONPayloadSet(jsonPayload As %DynamicAbstractObject) As %Status
{
	#Dim exception	As %Exception.General	= ""
	#Dim statusCode	As %Status				= $System.Status.OK()
	Try
	{
		Set i%JSONPayload	= jsonPayload
		Set statusCode		= jsonPayload.%ToJSON(..Body)
	}
	Catch (exception)
	{
		Return exception.AsStatus()
	}
	Return statusCode
}

}
