Class cjs.concurso.CustomQuery
{

Query ListarDados() As %Query(ROWSPEC = "ID:%Integer,Coluna1:%String,Coluna2:%String,Coluna3:%String,Coluna4:%String") [ SqlProc ]
{
}

ClassMethod ListarDadosExecute(ByRef qHandle As %Binary) As %Status
{
	// Define a global que contém os dados
	Set qHandle		= "^CustomQueryTest"
	// Define o último nó acessado
	Set qHandle(1)	= ""
	//
	Return $System.Status.OK()
}

ClassMethod ListarDadosClose(ByRef qHandle As %Binary) As %Status [ PlaceAfter = ListarDadosExecute ]
{
	// Limpa o handle
	Kill qHandle
	//
	Return $System.Status.OK()
}

ClassMethod ListarDadosFetch(ByRef qHandle As %Binary, ByRef Row As %List, ByRef AtEnd As %Integer = 0) As %Status [ PlaceAfter = ListarDadosExecute ]
{
	#Dim statusCode	As %Status	= $System.Status.OK()
	// Recupera o próximo nó a ser acessado
	#Dim indice		As %Integer	= $Order(@qHandle@(qHandle(1)))
	// Caso não tenha mais dados set aflag indicando que os dados acabaram e retorna
	If (indice = "")
	{
		Set AtEnd	= 1
		Set Row		= ""
		//
		Return statusCode
	}
	// Recupera os dados da global
	#Dim linha As %String = $Get(@qHandle@(indice))
	// Define a linha a ser retorna
	Set Row			= $ListBuild(indice, $Piece(linha, "^", 1), $Piece(linha, "^", 2), $Piece(linha, "^", 2), $Piece(linha, "^", 2))
	// Definie último nó acessado
	Set qHandle(1)	= indice
	//
	Return statusCode
}

}
