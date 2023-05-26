/// <p >
///   <b>2023-05-12 - Cristiano José da Silva</b><br/>
///   Production that shows how to use the REST classes with few lines of code e and 
///   configurations, to achieve interoperability with external REST APIs.
/// </p>
Class cjs.interopway.rest.samples.InteropProducion Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="cjs.interopway.rest.samples.InteropProducion" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>1</ActorPoolSize>
  <Item Name="Reqres REST Operation" Category="REST" ClassName="cjs.interopway.rest.bo.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="SSLConfig">ISC.FeatureTracker.SSL.Config</Setting>
  </Item>
  <Item Name="Call Reqres Service" Category="REST" ClassName="cjs.interopway.rest.samples.bs.CallRestService" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
