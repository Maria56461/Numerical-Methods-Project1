## Partea I :

  Am observat ca matricea sistemului este una simetrica, patratica, de tip 
Toeplitz, iar daca labirintul are "rows" randuri, matricea sistemului va avea 
"1 + 2 + ... + rows" randuri/coloane. Am observat ca elementele de pe diagonala 
principala se pot aranja sub forma de triunghi care are cifra "4" in fiecare 
dintre cele 3 colturi, "5" pe laturi si "6" pe interior. Fiecare element din 
acest triunghi corespunde unei linii din matricea sistemului. Niciodata  
diagonala principala nu va contine alte elemente in afara de "4", "5" si "6"  
deoarece soricelul poate avea maxim 6 cai pe care sa o ia in labirint. Ca sa   
pozitionez pe diagonala cifrele de "5" de pe laturile diferite de baza ale  
triunghului, mi-am construit doi vectori ajutatori, "k" si "p", care contin  
pozitiile acestor cifre. Pentru cifrele de pe baza triunghiului, am dedus destul 
de usor pozitiile lor in functie de "rows" si nu am avut nevoie de alti vectori 
auxiliari. Odata ce am format diagonala principala, matricea fiind simetrica, am 
format jumatatea de deasupra diagonalei principale, pentru ca in final am putut 
cu usurinta sa construiesc transpusa si sa formez intreaga matrice. In afara 
diagonalei principale sunt doar elemente de "-1" si "0", in principal "0", de 
aceea mai intai initializasem matricea cu o matrice nula, iar apoi am pozitionat 
corespunzator numerele "-1". Pentru a pozitiona numerele "-1", am observat 
urmatorul lucru: in triunghiul format din elementele de pe diagonala principala,
fiecare element are pe linia sa in matricea sistemului elemente de "-1" exact pe 
pozitiile vecinilor sai din triunghi. De exemplu, o linie din matrice care 
contine "4" va avea doar doi de "-1", pentru ca "4" are doar doi vecini in 
triunghi. Similar, o linie care contine "5" va avea 4 de "-1", pentru ca "5" are 
mereu 4 vecini in triunghi. Mai mult, acei "-1" se vor pozitiona in linia 
matricei exact pe pozitiile vecinilor respectivului "5" in triunghi. Pentru a
forma jumatatea de sus a matricei, am inserat pe fiecare linie toate elementele 
de "-1" de pe pozitii mai mari in triunghi decat elementul corespunzator acelei 
linii. 
  La "matrix_to_csr" am parcurs matricea A element cu element si, cand am gasit
un element nenul, l-am introdus in vectorul "values". Automat am introdus si 
indicele coloanei sale in vectorul "colind". Am folosit un index ca sa retin 
daca elementul respectiv este si primul din randul sau, iar in caz pozitiv am
inserat in "rowptr" indicele sau in "values". La final, am adaugat ca ultim 
element in "rowptr" numarul de valori nenule din matrice plus 1. 
  Pentru "Jacobi_factorization" am observat ca aveam nevoie de inversa matricei
diagonale care contine elementele de pe diagonala principala a lui A, iar 
aceasta este tot o matrice diagonala, in care fiecare element nenul este 
inversat (ridicat la (-1)). Tot la matricea de iteratie aveam nevoie de A cu 
diagonala principala nula si toate elementele negate si am folosit 
"diag(diag(A))" pentru a forma o matrice diagonala cu diagonala lui A. 
  La functia "Jacobi_sparse" am folosit "csr_multiplication" pentru a face 
produsul dintre x la pasul i si matricea de iteratie, cu scopul de a afla x la 
pasul i + 1. Am iterat intr-un "while" pana cand norma erorii absolute este
mai mica decat toleranta (acesta este criteriul de convergenta ales). 

## Partea a II-a : 

  Pentru initializare am parcurs lista de resturi posibile la impartirea unui 
numar la NC si la fiecare pas am pus intr-un vector toti indicii punctelor din 
"points" care dau restul respectiv la impartirea cu NC. Punctele cu indicii din 
acest vector le-am introdus intr-un vector de clustere "cluster_list" (care e de 
fapt o matrice de dimensiunile lui "points", dar care contine punctele altfel 
ordonate). Practic, la finalul iteratiei "i", clusterul "i" este umplut si am 
putut sa-i aflu centroidul facand suma clusterului pe coloane si impartind 
fiecare element al vectorului-suma la numarul de puncte din cluster. In urma 
tuturor acestor iteratii, am obtinut toti cei NC centroizi initiali, pe care 
i-am asezat intr-un vector de centroizi numit "centroids" (care e de fapt o 
matrice cu NC linii si D coloane). 
  Am reinitializat "cluster_list" ca fiind nula, 
apoi am iterat prin lista de centroizi si am creat o matrice "distances" care 
contine pe linia "i" distantele de la fiecare punct din matricea "points" la 
centroidul "i". Am aflat minimul pe coloane, am parcurs matricea de distante 
linie cu linie si am introdus fiecare punct din points in clusterul fata de care 
are distanta minima. Parcurgand linia "i" din matrice, am umplut clusterul "i", 
apoi am calculat centroidul acestui cluster. Am repetat pasii din acest 
paragraf obtinand noi seturi de centroizi, pana cand la pasul "j" am obtinut 
aceiasi centroizi ca la pasul "j - 1". Pentru functia de cost, doar am recreat
matricea de distante pt. setul de centroizi primit ca parametru, am aflat 
minimul pe coloane si am sumat elementele vectorului obtinut. 

## Partea a III-a :

  Am folosit functia "imread" ca sa citesc imaginea ca matrice tridimensionala. 
Fiecare dintre cele trei dimensiuni reprezinta una dintre culorile rosu, verde 
si albastru. Am creat un vector de la 0 la 256 cu "count_bins + 1" elemente egal 
departate si am aplicat de 3 ori histc pe el, o data pentru fiecare culoare. 
"Histc" a returnat un vector care spune cate elemente din primul vector primit 
ca parametru se regasesc in subintervalele definite de al doilea vector. Solutia 
este vectorul care se obtine prin concatenarea celor 3 vectori obtinuti, dupa ce 
elimin din fiecare vector ultimul element (sol are lungimea "count_bins * 3"). 
La HSVHistogram am aplicat tot aceiasi pasi, doar ca vectorul pe care aplic 
histc merge de la 0 la 1.01 si am implementat in plus functia "rgbTOhsv". 
Pentru aceasta functie am utilizat "im2double" ca sa convertesc la double 
elementele fiecareia dintre culori. In rest am vectorizat algoritmul din enunt, 
folosind functia "intersect" pentru situatiile in care aveam doua "if"-uri unul 
in altul, de care trebuia sa tin cont. La Householder l-am construit pe sigma
intr-un mod vectorizat, apoi am construit vectorul "vp" care intra in 
componenta reflectorului Householder. M-am asigurat ca aplic algoritmul pe o
coloana doar daca nu am numai zerouri pe acea coloana, sub diagonala 
principala. Pentru eficienta, la coloana pe care vreau sa o modific nu am mai
efectuat inmultirile cu reflectorul (stiam deja, din algoritm, ce se va 
obtine). Pentru Q, am efectuat inmultiri succesive cu reflectori, iar la final 
am facut transpusa, exact cum spunea algoritmul. La SST am pornit de la ultima
componenta a lui x in sus si am rezolvat fiecare ecuatie. Algoritmul este 
similar cu cel de la matrice patratice, doar ca aici am exclus cazul cand
numarul de linii este mai mic strict decat numarul de coloane. Pentru
"preprocess" am construit o matrice cu toate caile spre poze cu pisici si alta
cu toate caile spre poze care nu contin pisici. Am parcurs mai intai matricea 
cu poze cu pisici si pe fiecare linie a lui X am adaugat histograma pozei 
respective (considerand cazurile cu amandoua tipurile de histograma, atat RGB 
cat si HSV). Similar am parcurs matricea cu poze fara pisici si am setat y-ul 
pe acele linii sa fie "-1". La "learn" doar am format X_tilda si am rezolvat 
sistemul din enunt utilizand SST si Householder. Pentru "evaluate" am folosit 
pe "w" aflat la functia "learn" pentru a afla "y_prezicere". In functie de
"path_to_testset" am scos numarul de imagini cu pisici si numarul de imagini 
fara pisici din director, pe care le-am folosit ca sa parcurg y_prezicere si sa
calculez numarul de imagini evaluate corect.  

## Partea a IV-a: 

	Am folosit 4 functii de la partea a III-a: "rgbHistogram", "rgbTOhsv", 
"hsvHistogram" si "preprocess". La "learn" am scalat pe X in mod vectorizat, 
am folosit functia "rand" ca sa generez un w random, functia "randperm" ca sa
aleg 64 de randuri random din X_tilda pe care sa le pun in X_batch, si functia
"ismember" impreuna cu "find" ca sa gasesc indicii randurilor din X_tilda care
se gasesc in X_batch. Functia de "evaluate" este similara celei de la partea a 
III-a, doar ca l-am scalat pe X la inceputul functiei. 

### Feedback:

	O tema foarte foarte interesanta care chiar m-a prins si din care am invatat 
lucruri. Au fost totusi parti din enunt care mi-au dat de gandit si a trebuit sa
intreb intr-o parte sau in alta ca sa imi clarific enuntul (ar fi putut fi un pic 
mai clar, sau cu mai multe exemple pe alocuri- mai ales la partile a doua si a
treia). Dar a fost o tema chiar interesanta si pe forum au fost o groaza de
discutii pe care le-am citit si care m-au ajutat. Multumiri lui Radu si tuturor
celor care s-au implicat sa conceapa tema asta, apoi sa ne raspunda cu destula
promptitudine la nelamuriri pe forum!      





   
