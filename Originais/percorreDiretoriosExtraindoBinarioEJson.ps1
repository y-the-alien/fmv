param($driveOrigem,$driveDestino) # primeira linha

#Mede o tempo da execução da varredura
Measure-Command {


#verifica se já existe. Se não, cria
if(-Not (Test-Path -Path $driveDestino\TS_binarios)) {
mkdir $driveDestino\TS_binarios;
mkdir $driveDestino\TS_audios;
mkdir $driveDestino\TS_dados;
}


$extensaopkl=".pkl";
$pathDados=$driveDestino+"\TS_dados\";
$pathAudio=$driveDestino+"\TS_audios\";
$pathBinario=$driveDestino+"\TS_binarios\";

#itera a lista de diretórios na pasta
Get-ChildItem -Recurse -Path $driveOrigem\ -Exclude TS_* | where {$_.psiscontainer} | 
  ForEach-Object -Process {
	
		""
        #concatena o caminho completo para o destino
        $audio=$pathAudio+$_.FullName.substring(3);
        $dados=$pathDados+$_.FullName.substring(3);
        $binario=$pathBinario+$_.FullName.substring(3);

        #verifica se já existe. Se não, cria
        if(-Not (Test-Path -Path $audio)) {
        "Criando pasta: " + $_.Name;
        New-Item -ItemType directory -Path $audio
        New-Item -ItemType directory -Path $dados
        New-Item -ItemType directory -Path $binario
        }else {
             write-host("Pasta " + $_.Name + " já criada.")
            }
        
		""
}
 
        #itera a lista de arquivos na pasta
		Get-ChildItem -Recurse -Path $driveOrigem -File |
            ForEach-Object -Process {
           
            if($_.Extension -eq ".ts") {
                "Arquivo a ser processado: "+$_.Name;
            
                $destinobin=$pathBinario+$_.FullName.substring(3);
                $destinojson=$pathDados+$_.FullName.substring(3);
 
                #Verifica se Arquivo já existe, caso sim não reprocessa
                if(Test-Path -Path $destinobin) {
                    "Arquivo "+ $destinobin + " já existente! Nada a ser feito."
                    
                    
                }else {
                    $arquivoorigem=$_.FullName;
                    $arquivodestino=$destinobin
                    "Processa bin a partir de: " +$arquivoorigem +  " DESTINO: " + $destinobin;
                    C:\ScriptsPowerShell\extrairKLVBinario.ps1 $arquivoorigem $arquivodestino

                    
                }



                if(Test-Path -Path $destinojson) {
                    "Arquivo "+ $destinojson + " já existente! Nada a ser feito."

                    
                }else {
                    $arquivoorigem=$destinobin;
                    $arquivodestino=$destinojson;
                    "Processa json a partir de: "  +$arquivoorigem +  " DESTINO: " + $destinojson;
                    C:\ScriptsPowerShell\converterParaJSON.ps1 $arquivoorigem'.bin' $arquivodestino

                    
                }





             }


            }	
            	
 
 }
 
