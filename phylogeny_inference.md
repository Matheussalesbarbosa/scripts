## Análise de inferência filogenética

### - Arquivo multifasta com sequências-referência e sequências-alvo
```sh
#!/bin/bash

mkdir multifasta/

echo "set the output file name:"

read output

cat *.fasta > multifasta/$output.fasta

echo ""$output".fasta was saved in directory multifasta/"
```
---

### - Alinhamento múltiplo de sequências de nucleotídeos > [*Clustal Omega*](http://www.clustal.org/omega/)
```sh
nohup clustalo --in .fasta --out .aln --seqtype={Protein} --verbose
```
- ``--in`` arquivo de entrada
- ``--out`` arquivo de saída
- ``--seqtype={Protein}`` tipo de sequência
- ``--verbose`` saída detalhada da análise
---

### - Editar alinhamento múltiplo de sequências
- [BioEdit](http://www.mbio.ncsu.edu/BioEdit/bioedit.html/)
- [Custal](http://www.clustal.org/)
- [GeneDoc](https://github.com/karlnicholas/GeneDoc/)
- [Geneious Prime](https://www.geneious.com/academic/)
- [MAFFT](https://mafft.cbrc.jp/alignment/software/)
---

### - Evidência de sinal filogenético > [*IQ-TREE*](http://www.iqtree.org/)
---

### - Escolha do modelo evolutivo de substituição de nucleotídeos > [*jModelTest*](https://github.com/ddarriba/jmodeltest2)
```sh
nohup java -jar jModelTest.jar -d .fasta -a -AIC -AICc -BIC -DT -dLRT -f -g 4 -hLRT -i -n jmodeltest -p -t ML -tr 32 -uLnL -v -w
```
- ``-d`` arquivo de entrada
- ``-a`` calcula o modelo evolutivo filogenético para cada critério selecionado
- ``-AIC`` estima o melhor modelo evolutivo de acordo com o Critério de Informação de Akaike
- ``-AICc`` estima o melhor modelo evolutivo de acordo com o Critério de Informação de Akaike corrigido
- ``-BIC`` estima o melhor modelo evolutivo de acordo com o Critério de Informação Bayesiano
- ``-DT`` estima o melhor modelo evolutivo de acordo com o Critério de Teoria da Decisão
- ``-dLRT`` estima o melhor modelo evolutivo de acordo com Testes de Razão de Verossimilhança baseada em Distância
- ``-f`` inclui modelos evolutivos que calculam a frequência desigual para os nucleotídeos
- ``-g 4`` inclui modelos evolutivos que calculam a variação na taxa entre os sítios
- ``-hLRT`` realiza teste hierárquicos da Razão de Verossimilhança
- ``-i`` inclui modelos evolutivos que calculam a Proporção de Sítios Invariáveis
- ``-n`` nomeia a execução do log da análise
- ``-p`` calcula a importância dos parâmetros
- ``-S`` operação de busca da topologia da árvore filogenética de maior probabilidade
- ``-t ML`` árvore base para cálculos de verossimilhança
- ``-tr`` número de threads utilizados na execução da análise
- ``-uLnL`` calcula o valor de delta para AIC, AICc, BIC contra a estimativa de máxima verossimilhança sem restrição
- ``-v`` realiza a média do modelos e a importância dos parâmetros
- ``-w`` escreve o script para o [*PAUP**](https://paup.phylosolutions.com/)
---

### - Conversão de .fasta para .phylip > [*jModelTest*](https://github.com/ddarriba/jmodeltest2)
```sh
nohup java -jar jModelTest.jar -d .fasta -getPhylip
```
- ``-d`` arquivo de entrada
- ``-getPhylip`` converte o input para o formato .phylip
---

### - Constuir a árvore filogenética > [*PhyML*](http://www.atgc-montpellier.fr/phyml/)
```sh
nohup phyml --input .phy --datatype nt -b 1000 --no_gap -m 012345 -f m --ts/tv e -v e -c 4 --alpha e --no_memory_check -o tlr -s BEST
```
- ``--input`` arquivo de entrada
- ``--datatype`` tipo de sequência
	- ``nt`` para nucleotídeo
	- ``aa`` para aminoácido
- ``-b`` número de réplicas de bootstrap
	- ``-b 0`` nem o teste de Razão de Verossimilhança nem os valores de bootstrap são calculados
	- ``-b -1`` será realizado teste de Razão de Verossimilhança que retorna as estatísticas de aLRT.
	- ``-b -2`` será realizado teste de Razão de Verossimilhança retornando suporte de ramificação baseados em Chi2 paramétrico
	- ``-b -4`` será realizado apenas suporte de ramificação baseado em SH
	- ``-b -5`` será realizado suporte de ramificação baseado em critério Bayesiano
- ``--no_gap`` remove todos os sítios que contenham gaps
- ``-m`` modelo de substituição
	- ``012345`` caso queira aninhar outros modelos ao GTR
- ``-f`` frequência dos caracteres
	- ``e`` frequência estimada pela contagem da ocorrência das diferentes bases no alinhamento
	- ``m`` frequência estimada de acordo com a escolha do modelo evolutivo pelo *jModelTest*
- ``--ts/tv`` taxa transição e transversão
	- taxa definida de acordo com a escolha do modelo evolutivo pelo *jModelTest*
	- ``e`` taxa definida pela Máxima Verossimilhança
- ``-v`` proporção de sítios invariáveis
	- proporção definida de acordo com a escolha do modelo evolutivo pelo *jModelTest*
	- ``e`` proporção definida  pela Máxima Verossimilhança
- ``-c`` número de categorias de taxa de substituição
- ``--alpha`` distribuição do parâmetro gama
	- distribuição do parâmetro gama definida de acordo com a escolha do modelo evolutivo pelo *jModelTest*
	- distribuição do parâmetro gama definida pela Máxima Verossimilhança
- ``-s`` operação de busca da topologia em árvore filogenética de maior probabilidade
- ``-o`` otimização de parâmetros específicos da topoligia da árvore
	- ``tlr`` topologia da árvore (t), comprimento da ramificação (l) e parâmetros da taxa de substituição (r) são otimizados
	- ``tl`` topologia da árvore e comprimento da ramificação são otimizados
	- ``lr`` comprimento da ramificação e parâmetros da taxa de substituição são otimizados
	- ``l`` comprimento da ramificação são otimizados
	- ``r`` parâmetros da taxa de substituição são otimizados
	- ``n`` nenhum parâmetro é otimizado
- ``--no_memory_check`` não questionar sobre o uso da memória
---
