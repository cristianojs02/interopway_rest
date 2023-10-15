[English](/README.md)
---
# Interopway REST

Quantas vezes nos deparamos em reconstruir, copiar, colar adpatar, _Businesss Operations_ que fazem chamadas para serviços REST, e apenas adaptamos uma ou outra parte do código final. Isso incomada e muito. Para resolver esse nosso incoveniente apresento para vocês Interopway REST, um conjunto de classes (um micro framework) que nos permite apenas adicionar o _Business Operation à Production_ e  utilizar.

Vamos entender como isso funciona.

## Objetos de Transporte

Os objetos responsáveis por transportar os dados estão agrupados no pacote **cjs.interopway.rest.dto**. Abaixo vemos um diagrama de classes de sua estrutura.

![RestDTO](/images/cjs_interopway_rest_dto.png)

Neste pacote encontramos 3 classes:

*   **cjs.interopway.rest.dto.Base**: Classe base para a troca de informações agrupando proriedades de requisição e resposta HTTP.
    *   **Body**: Um stream contendo o corpo da requisição/resposta.
    *   **Headers**: Um array de chave:valor com os cabeçalhos da requisição/resposta.
    *   **JSONPayload**: Um objeto dinâmico, para caso o conteúdo seja um JSON, possamos acessá-lo de forma mais amigável.
*   **cjs.interopway.rest.dto.Request:** Objeto de transporte usado para as requisições, estende a classe **cjs.interopway.rest.dto.Base** adiconando a propriedade:
    *   **URL**: Endreço do endpoint a ser chamado.
*   **cjs.interopway.rest.dto.Response:** Objeto de transporte usado para as resposta, estende a classe **cjs.interopway.rest.dto.Base** adiconando as propriedades:
    *   **HTTPStatus**: Código de status HTTP do processamento da requisição.
    *   **InternalStatus**: Código do status interno do IRIS.
    *   **InternalStatusText:** Decomposição da propriedade InternalStatus em string de forma legível.

## Mensagens

As mensagens de _Request/Response_ estão definidas no pacote **cjs.interopway.rest.bo.** No diagrama de classes abaixo apresentamos apenas as mensagens mais genéricas na hierarquia que definem a estrutura padrão.

![BaseMessages](/images/cjs_interopway_rest_bo_BaseRequest-cjs_interopway_rest_bo_BaseResponse.png)

Existem 12 classes de mensagens neste pacote. 

*   **cjs.interopway.rest.bo.BaseRequest:** Classe abstrata para as requisições contendo uma referência de **cjs.interopway.rest.dto.Request.**
*   **cjs.interopway.rest.bo.BaseResponse:** Classe abstrata para as respostas contendo uma referência de **cjs.interopway.rest.dto.Response.**
*   **cjs.interopway.rest.bo.DeleteRequest:** Estende a classe **cjs.interopway.rest.bo.BaseRequest** é utilizada para fazer um **DELETE.**
*   **cjs.interopway.rest.bo.DeleteResponse:** Estende a classe **cjs.interopway.rest.bo.BaseResponse** recebe a resposta de um **DELETE.**
*   **cjs.interopway.rest.bo.GetRequest:** Estende a classe **cjs.interopway.rest.bo.BaseRequest** é utilizada para fazer um **GET.**
*   **cjs.interopway.rest.bo.GetResponse:** Estende a classe **cjs.interopway.rest.bo.BaseResponse** recebe a resposta de um **GET.**
*   **cjs.interopway.rest.bo.PatchRequest:** Estende a classe **cjs.interopway.rest.bo.BaseRequest** é utilizada para fazer um **PATCH.**
*   **cjs.interopway.rest.bo.PatchResponse:** Estende a classe **cjs.interopway.rest.bo.BaseResponse** recebe a resposta de um **PATCH.**
*   **cjs.interopway.rest.bo.PostRequest:** Estende a classe **cjs.interopway.rest.bo.BaseRequest** é utilizada para fazer um **POST.**
*   **cjs.interopway.rest.bo.PostResponse:** Estende a classe **cjs.interopway.rest.bo.BaseResponse** recebe a resposta de um **POST.**
*   **cjs.interopway.rest.bo.PutRequest:** Estende a classe **cjs.interopway.rest.bo.BaseRequest** é utilizada para fazer um **PUT.**
*   **cjs.interopway.rest.bo.PutResponse:** Estende a classe **cjs.interopway.rest.bo.BaseResponse** recebe a resposta de um **PUT.**

## Business Operation

![Operation](/images/cjs_interopway_rest_bo_Operation.png)

A classe  **cjs.interopway.rest.bo.Operation** estende o Business Operation padrão  **EnsLib.REST.Operation** que possui alguns métodos utilitários e já vem configurado com o adaptador **EnsLib.HTTP.OutboundAdapter.**

Este _Business Operation_ possui 5 _Business Operatino Methods,_ que são os métodos que estão no _MessageMap_ e são disparados no momento da recepção das mensagens de request, sendo eles:

*   **Delete**
*   **Get**
*   **Patch**
*   **Post**
*   **Put**

Estes 5 métodos apenas despacham a chamada para o método **CallEndPoint** que é responsável por invocar o seviço REST de acordo com cada verbo HTTP associado a cada mensagem.

O método **GetHttpRequest** instância um objeto do tipo  **%Net.HttpResponse** e preenche os cabeçalhos HTTP.

O método **GetResponseHeaders** recupera todos os cabeçalhos retornados na resposta da requisição.

Os métodos **BeforeCallEndPoint** e **AfterCallEndPoint**, são métodos ganchos a serem implementados em subclasses do Business Operation para executarem ações respectivamente, antes e depois de invocar o _EndPoint_. Um exemplo de uso seria fazer uma chamada a um  método de login antes das requisições, e processar o objeto de response.

## Instalação

A instalação se dá via studio importando o arquivo xml com os fontes do projeto contido no diretório **/src/xmlexport/Interopway_REST.xml.**

O pacote IPM  também está diponível para instalação:

```objectscript
zpm "install interopway_rest"
```

## Exemplo de Uso

No projeto existe uma _Production_  de testes  **cjs.interopway.rest.samples.InteropProducion** e uma classe com testes unitários  **cjs.interopway.rest.tests.InteropProduction. Apenas o** Business Operation é utilizado nos testes pois ele é quem faz todo o trabalho.

![productionConfiguration](/images/productionConfiguration.png)

Para execução dos testes unitários copie o arquivo **/src/xmlexport/Interopway\_REST.xml** para algum diretório, como por exemplo, C:\\temp\\test.

Abra uma sessão de terminal e atribua o caminho na global **^UnitTestRoot**

```objectscript
Set ^UnitTestRoot = "C:\temp\tests"
```

Após definir a global execute o teste unitário:

```objectscript
Do ##Class(%UnitTest.Manager).RunTest("", "/nodelete") 
```

Essa linha de código ira importar, compilar, executar a classe contendo os testes unitários. A flag _/nodelete,_ mantém o fonte da classe no servidor.

Acesse a URL apresentada ao final da execução e veja o resultado dos testes.

![unitTestResult](/images/unitTestResult.png)

Se tudo correu bem, deverá ser algo pareceido com a imagem abaixo.

![unitTests](/images/images/unitTests.png)

Abaixo o código do método **TestPostUser** e **CallBusinessService**:

```objectscript
Method TestPostUser() As %Status
{
  #Dim statusCode As %Status                              = ..IsProductionRunning()
  #Dim request    As cjs.interopway.rest.bo.PostRequest   = ##Class(cjs.interopway.rest.bo.PostRequest).%New()
  #Dim response   As cjs.interopway.rest.bo.PostResponse  = ""
  #Dim requestDTO As cjs.interopway.rest.dto.Request      = ##Class(cjs.interopway.rest.dto.Request).%New()
  #Dim user       As %DynamicObject                       = {}
  //
  Set user.email              = "cristiano.js@gmail.com"
  Set user."first_name"       = "Cristiano José"
  Set user."last_name"        = "Silva"
  Set requestDTO.JSONPayload  = user
  Set requestDTO.URL          = ..#APIURL _ ..#USERENDPOINT
  Set request.RequestDTO      = requestDTO
  Set statusCode              = ..CallBusinesService(..#TARGETOPERATION, request, .response)
  If ($System.Status.IsOK(statusCode))
  {
    Do ..LogMessage("Usuário criado com uscesso: " _  response.ResponseDTO.JSONPayload.id)
  }
  Return statusCode
}

Method CallBusinesService(targetBusinessOperation As %String, request As cjs.interopway.rest.bo.BaseRequest, ByRef response As cjs.interopway.rest.bo.BaseResponse) As %Status [ Private ]
{
  #Dim statusCode As %Status            = $System.Status.OK()
  #Dim exception  As %Exception.General = ""
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
```

O método **TestPostUser** intancia uma mensagem para fazer o post do tipo **cjs.interopway.rest.bo.PostRequest** e preenche o corpo com um objeto dinâmico conento o JSON  a ser enviado para o Serviço REST, atribui a _URL_ do serviço e invoca o método **CallBusinessService** que invoca o serviço de testes e despacha a mensagem para o _Business Operation._ Note que todos os outros métodos de teste seguem o mesmo princípio, exceto para o método **GET** e **DELETE** que não possuem corpo.

Com **Interopway REST** apenas adicionamos o _Business Operation à Production,_ configuaramos ou os passamos via mensagens os dados de acesso e nos preocupamos com a implementação das regras de negócio das integrações e não mais com o código para fazer a conexão com os serviços externos.