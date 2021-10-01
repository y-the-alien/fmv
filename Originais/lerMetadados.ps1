param($arquivo,$arquivodestino) # primeira linha

Write-Host "Essse comando terá como saída um arquivo Pickle com extensão pkl que preserva todo o objeto python serializado extraido do arquivo binário .TS"
if ($arquivo -and $arquivodestino){
python C:\ScriptsPowerShell\metadataToPickle.py $arquivo $arquivodestino
} else {
Write-Host "Arquivo não informado. Por favor execute:"
Write-Host "----------------------------------------------"
Write-Host ".\lerMetadados.ps1 <caminho e nome do arquivo binario aqui> <caminho e nome do arquivo destino aqui>"
}