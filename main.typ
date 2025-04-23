#import "utils/template.typ": *
#import "utils/variables.typ": *
#import "@preview/theorion:0.3.3": *
#import cosmos.fancy: *
#show: show-theorion

#show: main-rules

= Repaso de probabilidades

- *¿Qué es una probabilidad?* Una probabilidad es una medida de incertidumbre.

- Tiene dos enfoques: frecuentista y bayesiano. Para el frecuentista, la probabilidad es algo inherente a la naturaleza, y su paradigma de cálculo es $"casos favorables"\/"casos totales"$. Para el bayesiano, la probabilidad es un invento del ser humano, y ya no se usa la fórmula anterior.

== Notaciones básicas

En el curso, usaremos $Omega$ para denotar el espacio muestral, $omega$ para los eventos, y $PP$ para la medida de probabilidad, que corresponde a una función que asigna una probabilidad a cualquier evento en $cal(F)$, donde $cal(F)$ es una colección de subconjuntos de $Omega$, no necesariamente una partición.

== Propiedades básicas de $PP$

1. La probabilidad del espacio muestral debe ser siempre $1$, es decir, $PP(Omega) = 1$.

2. La probabilidad es no negativa, es decir, para cualquier evento $A in cal(F)$, $PP(A) >= 0$.

3. La probabilidad de la unión de eventos disjuntos es la suma de sus probabilidades por separado, es decir, $PP(union.big_i A_i) = sum_i PP(A_i)$ cuando $forall i!=j, A_i inter A_j = emptyset$.

== Variables aleatorias

#note-box[Por convención, en este curso usaremos letras mayúsculas para denotar las variables aleatorias (en adelante, abreviadas como v. a.).]

Son funciones que toman elementos del espacio muestral, y les asigna a cada uno un número real. Podemos definir una v. a. $X$ como $X: Omega -> RR$. Por ejemplo, sea $X$ el número de caras en el lanzamiento de una moneda no cargada $3$ veces, entonces $X={0,1,2,3}$, porque son las distintas cantidades de caras que pueden salir.

=== Variables aleatorias discretas

Se dice que $X$ es una v. a. discreta si toma valores de un conjunto finito, o infinito numerable, y además $forall x$, $PP(X=x) != 0$.

=== Variables aleatorias continuas

Se dice que $X$ es una v. a. continua si $X$ toma cualquier valor real con probabilidad cero, es decir, $forall x, PP(X=x) = 0$.

=== Funciones de densidad

Existen dos funciones de densidad que permiten ver el comportamiento de una variable aleatoria.

- PDF: _Probability Density Function_ ($f(x)$). Describe cómo se distribuye la probabilidad a lo largo de los posibles valores de la v. a. En específico, $PP(a <= X <= b) = integral_a^b f(x) dif x$.

- CDF: _Cummulative Density Function_ ($F(x)$). Acumula la probabilidad desde $-infinity$ hasta un valor $x$ en el dominio. En específico, $F(x) = PP(X<=x)$.

Estas funciones están directamente relacionadas mediante la fórmula $F(x) = integral_(-infinity)^(x) f(t) dif t$, lo que puede ser observado gráficamente en la @fig-pdf-cdf.

#figure(
  caption: [Funciones "PDF" ($f(x)$) y "CDF" ($F(x)$).],
  image("images/classes/pdf_cdf.svg")
) <fig-pdf-cdf>

Si se conoce $F$, podemos conocer la probabilidad de un intervalo mediante la siguiente fórmula $PP(a <= X <= b) = F(b) - F(a)$.

=== Esperanza de una variable aleatoria

Definimos la esperanza de una variable aleatoria para las v. a. discretas y continuas como:

- $X$ discreta: $EE[X] = sum_(Omega) x dot PP(X = x)$.

- $X$ continua: $EE[X] = integral_(RR_X) x dot f(x) dif x$.

También se puede definir como el primer momento de distribución. Los momentos de distribución se definen como $EE[X], EE[X^2], EE[X^3]$, etc.

=== Varianza de una variable aleatoria

Definimos la varianza de una v. a. discreta y continua como:

- $X$ discreta: $var(X) = EE[(X-EE[X])^2]$.

- $X$ continua: $ var(X) = integral_RR_X (X-EE(X))^2 dot f(x) dif x$.

Con esto mismo podemos definir la desviación estándar de una variable aleatoria, la cual viene a ser la raíz cuadrada de su varianza. Se le conoce también como $sigma$ o #std[$X$].

=== Estandarización de una variable aleatoria

Sea $X$ una variable aleatoria, se define la variable $Z=(X-mu)\/sigma$ con $mu = EE[X]$ y $sigma = sqrt(var(X))$. Se dice que $Z$ es la estandarización de $X$, pues cumple $EE[Z] = 0$ y $var(Z) = 1$.

#warning-box[
  En algunas librerías de programación, la "estandarización" de una v. a. se considera como su "normalización", pero estos términos no son equivalentes.
]

== Distribuciones discretas

En el curso, veremos principalmente las siguientes distribuciones discretas:

+ Bernoulli: $X :=$ lanzamiento de una moneda sólo una vez. Entonces $X ~ Ber(p)$. Sus valores se definen como:

  $
    X = cases(
      1 "en el caso de éxito",
      0 "en el caso de fracaso"
    )
  $

  Además, $PP(X=1) = p$ (probabilidad de éxito) y $PP(X=0) = 1-p$ (probabilidad de fracaso). El éxito puede ser, por ejemplo, "obtener cara al lanzar la moneda".

+ Binomial: si realizamos el experimento anterior $n$ veces, entonces $X :=$ número de éxitos en $n$ ensayos independientes. Luego, $X ~ Bin(p, n)$. La probabilidad asociada a $k$ éxitos es la siguiente:

  $
    PP(X=k) = binom(n, k) dot p^k dot (1-p)^(n-k)
  $

  Además, $EE(X) = n p$ y $var(X) = n p dot (1-p)$. 
  
  Si $p$ es un vector multivariado $(p_1, p_2, dots, p_n)$, se transforma en una distribución multinomial, denominada $X ~ MultBin(p, n)$.

== Distribuciones continuas

+ Normal: $X ~ normal(mu, sigma^2)$. Su función de densidad es:

  $
    f(x) = 1/(sqrt(2 pi sigma^2)) e^(-(x-mu)^2/(2 sigma^2)); quad x in RR
  $

  - Normal estándar: si $X ~ normal(mu, sigma^2)$ y $Z = (X-mu)\/sigma$, entonces $Z ~ normal(0, 1)$.
+ "Chi cuadrado" ($chi^2$): si $Z ~ normal(0,1)$ entonces:

  $
    Y = Z^2 -> Y ~ chi^2_[1]
  $

  donde el subíndice $[1]$ denota los grados de libertad, que es algo que se tratará en las próximas secciones.

+ $t$-Student: si $Z ~ normal(0,1)$ e $Y ~ chi^2_[n]$. Entonces definimos $t$-Student como:
  $
  t= Z/sqrt(Y\/n) ~ t_[n]
  $

+ Fischer ($F$): combinamos dos $chi^2$ independientes:

  $
  X_1 ~ chi_[n_1]^2 and X_2 ~ chi_[n_2]^2 "entonces" F=(X_1\/n_1)/(X_2\/n_2)~F_(n_1,n_2)
  $

== Covarianza de dos variables aleatorias

Medida de cómo en promedio varían linealmente dos variables aleatorias entre sí.

$
  cov(X,Y) &= EE[(X-EE(X))(Y-EE(Y))] \
  &= EE(X Y)-EE(X)EE(Y)
$

Si estas variables $X, Y$ son independientes, entonces su covarianza será cero, pues $EE[X Y] = EE[X] dot EE[Y]$ por la propiedad heredada de la esperanza.

#warning-box[La implicancia $cov(X, Y) = 0 => X, Y "son independientes"$ es falsa, y es un error muy común asumir que es cierta.] 

== Correlación de dos variables aleatorias

Es una estandarización de la covarianza, para tener resultados interpretables en el rango $[-1, 1]$. Se calcula de la siguiente forma:

$
  corr(X, Y) = (cov(X, Y))/sqrt(var(X) dot var(Y)) = rho(X, Y)
$

= Repaso de probabilidades e inferencia estadística

Cuando decimos $corr(X,Y) = 0$, quiere decir que no hay información sobre la relación lineal entre $X$ e $Y$. Esto no quiere decir que $X$ e $Y$ sean independientes, porque pueden tener un tipo de relación no lineal, por ejemplo, cuadrática.

#example[Sea $X ~ "U"[-1, 1]$ e $Y = X^2$, con $"U"(a,b)$ una distribución uniforme. Como los momentos de una variable $Z$ que distribuye uniformemente en el intervalo $(a, b)$ se calculan mediante la expresión:

  $
    EE(Z^n) = (b^(n+1)-a^(n+1))/((n+1) dot (b-a))
  $

  y $X$ es uniforme en el intervalo $[-1, 1]$, entonces su primer momento, $EE(X)$, es nulo. Además, $EE(X^3) = 0$. Esta última expresión nos sirve para deducir la contradicción, pues:

  $
    cov(X, Y) &= EE(X Y) - EE(X) dot EE(Y) \
    &= EE(X Y) \
    &= EE(X dot X^2) \
    &= EE(X^3) = bold(0) 
  $

  pero $Y$ sí depende de $X$, entonces no pueden ser independientes.]

== Inferencia estadística <statistic-inference>

La inferencia estadística es una rama de la estadística que se encarga de hacer predicciones o caracterizaciones sobre una población a partir de una muestra.

Normalmente, habrá una variable $Y ~ f(X)$, con $f$ una función genérica llamada modelo, que encuentra una relación. $Y$ se llama variable endógena, porque depende de $X$. Será la variable que estudiaremos. Por otro lado, $X$ se llama variable exógena, porque en el mundo ideal no depende de nada.

#example[
  Definimos las variables aleatorias $Y :=$ demanda por poleras, y $X :=$ tallas (estaturas). Acá surge naturalmente un problema: necesitamos estudiar más a fondo el caso, pues nunca conoceremos la media o desviación estándar exacta de la población. Para esto, definiremos una herramienta que se verá en la @estimators.
]

== Estimadores <estimators>

En el caso anterior, no podemos conocer ni $mu$ ni $sigma$. Como habrán casos donde esto suceda, necesitamos instrumentos que "aproximen" estos valores para poder hacer la inferencia, por ejemplo:

$
  overline(X) = 1/N dot sum_(i=1)^N X_i
$

- *¿Por qué nos gusta el promedio?* El promedio cumple con propiedades que hacen que sea un buen estimador. Una de ellas se enlista a continuación:

  - _Insesgadez_. Sea $T(X)$ estimador del parámetro $theta$. $T(X)$ es #keyword[insesgado] si $EE[T(X)] = theta$. Esto significa que su valor esperado está completamente centrado en el parámetro que estoy buscando. Esta propiedad la cumple el promedio:

    $
    EE(overline(X)) &= EE(1/N dot sum_(i=1)^N X_i) \ 
      &= 1/N dot sum_(i=1)^N EE(X_i) & "(linealidad)" \
      &= 1/N dot N dot mu = bold(mu) & "(" X_i "i.i.d.)"
    $

    Definimos $var(T(X))$ como la medida de dispersión del estimador, es decir, qué tan lejos me encuentro del "centro". Para el promedio:

    $
      var(overline(X)) &= var(1/N dot sum_(i=1)^N X_i) \
      &= 1/N^2 dot var(sum_(i=1)^N X_i) \
      &= 1/N^2 dot sum_(i=1)^N var(X_i) & "(" X_i "i.i.d.)" \
      &= 1/N^2 dot N dot sigma^2 = bold(sigma^2/N)
    $

    A propósito, queremos que la varianza sea lo más cercana a cero posible, porque esto hace que el estimador esté concentrado en el valor central. Lo malo del resultado obtenido con el promedio, es que si $N$ es muy grande, no podré estimar $sigma$ (que sigue siendo desconocido), porque $N$ tiene influencias en el resultado al estar dividiendo.

    De esto, nace la necesidad de buscar un estimador insesgado de $sigma^2$. La expresión que toma es la que sigue:

    $
      S^2 = 1/(N-1) dot sum_(i=1)^N (X_i - overline(X))^2; quad EE(S^2) = sigma^2
    $

    De esta forma, ya tenemos una estimación de $sigma^2$, por lo tanto, podemos decir que $var(overline(X)) = S^2\/N$ con un error $std(overline(X)) = sqrt(S^2\/N)$.

#important-box[Para hacer las estimaciones, tomamos muestras aleatorias independientes e idénticamentte distribuidas (en adelante, denotado como i.i.d.). Así, la observación $i$ no depende de la $j$, y todas vienen de la misma distribución. En el curso trabajaremos sólo con distribuciones i.i.d., salvo que se diga lo contrario.]    

== Intervalos de confianza

Se anotan como $"IC"(X)$, $"CI"(X)$ o $"C"(X)$, siendo esta última la notación que usaremos en este apunte, y corresponden a un rango de valores que con cierta probabilidad contienen al parámetro de interés $theta$. En el caso particular de la media muestral, es decir, $"C"(overline(X))$, queremos capturar $mu$. Lo importante es notar que el parámetro de interés está fijo, lo que varía es justamente el intervalo de confianza.

$
  "C"(overline(X)) = overline(X) plus.minus Z_alpha dot std(overline(X))
$

El valor $Z_alpha$ es el que escojo para que con "$alpha$" nivel de confianza $mu in "C"(overline(X))$. 

$
  PP(mu in "C"(overline(X))) &= PP(overline(X) - Z_alpha dot std(overline(X)) <= mu <= overline(X) + Z_alpha dot std(overline(X))) \
  &= PP(-Z_alpha <= underbrace((overline(X) - mu)/(std(overline(X))), "estadístico" t) <= Z_alpha)
$

Para fijar la probabilidad de que el parámetro de interés esté en el intervalo de confianza, necesitamos saber cómo distribuye el estadístico $t$. Vamos a ver algunos ejemplos.

+ $X ~ normal(mu, sigma^2)$, y supondremos que conocemos $sigma^2$. Entonces $overline(X) ~ normal(mu, sigma^2 \/ N)$ por los cálculos que hicimos anteriormente. Luego,

  $
    Z ~ (overline(X) - mu)/(std(overline(X))) ~ normal(0, 1) quad "(es una normal estandarizada)"
  $

  Para una normal $normal(0, 1)$, el valor de $Z_alpha$ es aproximadamente $1.96$ para una estimación del $95 \%$ de confianza para $mu$ (o sea, $alpha = 1 - 0.95 = 0.05$). Este valor de $Z_alpha$ varía en función de la probabilidad asociada a la estimación.

+ $X ~ normal(mu, sigma^2)$, pero no conocemos $sigma^2$. Nuevamente, $overline(X) ~ normal(mu, sigma^2\/N)$. Luego, queremos conocer cómo distribuye $Z = (overline(X) - mu)\/sqrt(S^2\/N)$. Para esto, necesitamos escribir $Z$ de manera conveniente. Se escribirá de la siguiente forma:

  $
    lr(Z = (overline(X) - mu)/sqrt(sigma^2\/N) mid(\/) sqrt(((N-1) dot S^2/sigma^2) mid(\/) (N-1)))
  $

  Ya sabemos que $(overline(X)-mu)\/sqrt(sigma^2\/N) ~ normal(0, 1)$. Nos falta estimar el resto. Desarrollando:

  $
    (N-1) dot S^2/sigma^2 = 1/(N-1) sum_(i=1)^N [(X_i - overline(X))^2] dot (N-1)/sigma^2 = sum_(i=1)^N ((X_i - overline(X))/(sigma))^2
  $

  y además, $(X_i - overline(X))\/sigma ~ normal(0,1)$, entonces $(N-1) dot S^2\/sigma^2 ~ chi^2_[N-1]$, pues es una suma de normales al cuadrado. Finalmente, y por definición de la variable aleatoria $t$-Student, $Z$ distribuye $t_[N-1]$.
  
  #important-box[
    La suma de variables $chi^2$ independientes sigue siendo $chi^2$. Los grados de libertad de la variable resultante son la suma de los grados de libertad de las variables originales.
  ]

+ $X$ no distribuye $cal(N)(mu, sigma^2)$. Para este caso, es útil emplear una herramienta visual para descartar que su distribución se comporte de forma parecida a una normal. Una manera es usando un _Q-Q Plot_ que compara cuantil a cuantil una distribución empírica con una teórica. En este caso, la distribución empírica es $X$, y la teórica sería una normal.

  En la @qqplot que se muestra a continuación, mientras más cerca esté la línea de puntos azul de la recta, más parecidas son las distribuciones empírica y teórica. Estos roles los toman $X$ y $cal(N)(mu, sigma^2)$ respectivamente en el caso que estamos estudiando.

  #figure(
    caption: [Visualización simplificada de un _Q-Q Plot_.],
    image("images/classes/qqplot.svg", width: 70%)
  ) <qqplot>

  Si se logra confirmar visualmente que no distribuye normal, debemos buscar otras estrategias para entender la distribución del estadístico _t_. En este punto, introduciremos la teoría asintótica, que se definirá en la siguiente sección (@asymptotic-theory).

== Teoría asintótica <asymptotic-theory>

=== Convergencia en probabilidad

Una secuencia de variables aleatorias $X_n$ converge en probabilidad a la variable aleatoria $X$ si para todo $epsilon>0$, su límite cumple lo siguiente:

$
  lim_(n->infinity) PP(abs(X_n-X)<epsilon)=1
$

Esto se anotará como $X_n scripts(->)_(PP) X$ ó $scripts("plim")_(n -> infinity) X_n = X$.

#note-box[
  En la mayoría de los _datasets_ actuales se tiene que "$n -> infinity$", porque en la estadística clásica, un $n = 30$ ya era considerado muy grande. Esto es porque una $t$-Student con $30$ grados de libertad se empieza a parecer a una normal estándar en distribución.
]

Basándose en esto se puede definir una nueva propiedad para los estimadores, que extiende la propiedad de insesgadez que se vio en la @estimators:

- _Consistencia_: Un estimador $T(X_n)$ del parámetro $theta$ es #keyword("consistente") si converge en probabilidad al parámetro de interés, es decir:
 $
   lim_(n->infinity) PP(abs(T(X_n)-theta)<epsilon)=1
 $

=== Ejemplos de sesgo y consistencia

Un estimador puede ser insesgado y no consistente, o tener otro tipo de variaciones. A continuación, se enlistan ejemplos que dan cuenta de estas variaciones:

+ Estimador insesgado e inconsistente:

  $
    T'(X) = X_1 space and space EE(T'(X)) = EE(X_1) = mu
  $

  Este estimador de $mu$ es insesgado, porque su esperanza es igual al parámetro estimado, sin embargo, al aumentar la muestra ($n -> infinity$), el valor de $T'(X)$ no cambia, sigue siendo aleatorio e igual a $X_1$. Al ser un valor aleatorio, esto no se acerca una distancia arbitraria $epsilon > 0$ a $mu$ en el límite.

+ Estimador sesgado e inconsistente:

  $
    T''(X) = c in RR, c != theta
  $
  
  En este caso, al ser una constante, el valor esperado es la misma constante (distinta de $theta$), por lo tanto, cumple ser sesgado. Por otro lado, es inconsistente, ya que la sucesión siempre está concentrada en $c$, lo que hace imposible que esté centrado en $theta$, que es lo que se busca con el límite.

+ Estimador sesgado y consistente:

  $
    S'^2 = 1/N sum_(i=1)^N (X_i-overline(X))^2; space EE(S'^2) = sigma^2 - sigma^2/N != sigma^2
  $

  Este estimador tiene sesgo, porque su valor esperado no es igual al parámetro estimado $sigma^2$. Sin embargo, es consistente, porque converge en probabilidad al parámetro de interés. Esto último se confirma porque el sesgo es $-sigma^2\/N$, que tiende a $0$ cuando $N -> infinity$.

=== Caracterización de la consistencia

Si $T(X_n)$ es estimador insesgado de $theta$, es decir, $E(T(X_n)) = theta$, y además $var(T(X_n)) -> 0$ cuando $n -> infinity$, entonces $T(X_n)$ es un estimador consistente de $theta$. Matemáticamente:

$
  T(X_n) "insesgado" and var(T(X_n)) -> 0 ==> T(X_n) "consistente"
$

Por ejemplo, el promedio es un estimador consistente de $mu$, porque es un estimador insesgado ($E(overline(X)) = mu$), y además $var(overline(X)) = sigma^2\/N -> 0$ cuando $N -> infinity$.

=== Ley de los Grandes Números (LGN)

Sea ${X_i}_(i in NN)$ una muestra i.i.d. con $E(X_i) = mu < infinity$ y $var(X_i) = sigma^2 < infinity$ para todo $i in NN$. La Ley de los Grandes Números (también llamada LGN) establece que: 
$
  overline(X_n) = 1/n dot sum_(i=1)^n X_i
$
es un estimador consistente de $mu$, es decir, $overline(X_n) ->_(PP) mu$.


=== Convergencia en distribución

Sea $X_n$ es una secuencia de variables aleatorias con $X_n ~ f_n (dot)$, y además $X ~ f(dot)$. Si para cada $x$ donde $f(x)$ es continua se cumple que $f_n (x) -->_(n -> infinity) f(x)$ entonces decimos que $X_n$ converge en distribución a $X$, anotado $X_n ->_d X$. En palabras coloquiales, esta es una convergencia de histogramas.

= Teoría asintótica e introducción al test de hipótesis

== Teorema Central del Límite (TCL) <tcl>

Sea ${X_i}_(i=1)^N$ una muestra aleatoria i.i.d. con $EE(X_i) = mu < infinity$ y $var(X_i) = sigma^2 < infinity$ para todo $i in {1, 2, dots, N}$. Entonces:

$
  & 1/N dot sum_(i=1)^N (X_i - mu) ->_d normal(0, sigma^2) \
  ==>& (overline(X_n) - mu)/(sigma\/sqrt(N)) ->_d normal(0, 1)
$

donde $sigma\/sqrt(N)$ es la varianza de la variable aleatoria $overline(X_n)$.


La "gracia" de este teorema es que no importa cómo distribuyan las variables aleatorias ${X_i}_(i=1)^N$, siempre y cuando cumplan con las condiciones del TCL, la suma de ellas se comportará como una normal estándar. Una consecuencia directa es que cuando tenemos muestras grandes, podemos calcular los intervalos de confianza usando una $normal(0,1)$, dado que el estadístico $t$ converge a dicha distribución.

== Test de hipótesis <hypothesis-test>

El test de hipótesis es una herramienta clave en la inferencia estadística que nos ayuda a decidir si los datos muestrales proporcionan suficiente evidencia para apoyar una determinada afirmación sobre la población.

Realizaremos el siguiente experimento para hacer comparaciones: escogemos $N=30$ personas con COVID, divididas en dos grupos de $N_1=N_2=15$ personas. A un grupo le damos un medicamento y al otro un placebo, para anular el efecto psicológico. Luego, medimos los días que se demoró cada paciente en recuperarse. Los resultados del promedio por grupo son:

$
  overline(X_1) = 3.5 "días" quad and quad overline(X_2) = 4.5 "días"
$

Una pregunta que surge naturalmente es: ¿podemos afirmar que el medicamento es efectivo? La respuesta es no, porque a pesar de que puedo hacer que las muestras sean altamente homogéneas, siempre habrán factores que no podemos controlar, por ejemplo, situaciones personales de cada paciente, medicamentos extras que no fueron informados, etc. Para enfrentar esta problemática, se definen las siguientes herramientas matemáticas:

- Hipótesis nula ($H_0$): Plantea que "no existe un efecto", y se asume que es cierta hasta que tengamos evidencia suficiente para rechazar esta afirmación. Afecta el tipo de experimento o procedimiento, y los datos que son recopilados.

  #example[
    _Efectividad de la urgencia de un hospital._ Están las readmisiones, muertes hospitalarias, y la duración de la estadía. Si uno mira estos indicadores, suelen ser altos, entonces una conclusión apresurada sería decir que la urgencia funciona mal. Esto no necesariamente es cierto, porque los pacientes que entran a urgencia ya vienen con una situación grave previa.
  ]

- Hipótesis alternativa ($H_A$ ó $H_1$). Corresponde a lo opuesto a la hipótesis nula, pues representa la existencia de un efecto. Generalmente, es lo que queremos demostrar.

== P-valor <sec-p-value>
  
El $p$-valor corresponde a la probabilidad de que bajo la hipótesis nula los datos muestren la diferencia que observo. Con el ejemplo de la @hypothesis-test, esta "diferencia observada" sería el día adicional que tardó el segundo grupo en recuperarse. Un $p$-valor cercano a $0$ diría que la probabilidad de observar una diferencia de un día, siendo que el medicamento no es efectivo, es muy baja.

La @p-value muestra dos PDF: por un lado $f(overline(X) bar H_A)$, que representa la curva de distribución para el caso donde el medicamento es efectivo, y por otro, $f(overline(X) bar H_0)$, que representa la curva cuando el medicamento es inefectivo. En este mismo gráfico, se puede ver la representación gráfica de un $p$-valor sobre la cola derecha de la distribución de $overline(X) bar H_A$. Matemáticamente, corresponde al área de la región que define el valor observado del estadístico $t$.

#figure(image("images/classes/p_value.svg", width: 80%), caption: [Representación gráfica de un $p$-valor.]) <p-value>

#note-box[
  En la @p-value, el valor $t_"crítico"$ define la región de rechazo, que corresponde a la zona donde se rechaza la hipótesis nula. Esta región se define a partir de un umbral $alpha$ que se verá en la siguiente sección (@neyman-pearson).
]

=== Teorema de Neyman-Pearson <neyman-pearson>

Para realizar conclusiones sobre un test de hipótesis, se suele fijar un umbral que usualmente es $alpha in [0.01, 0.05]$. Si el $p$-valor es menor a $alpha$, se habla de la existencia de significancia estadística. Si el $p$-valor es mayor a $alpha$, se dice que no hay significancia estadística. Para el caso $p=alpha$ podemos decir que hay o no hay significancia dependiendo de cómo se realizó el experimento, dado que este umbral se fija de manera arbitraria.

Si tenemos significancia estadística, se rechaza la hipótesis nula $H_0$, es decir, puedo descartar que el medicamento no sea efectivo porque el experimento es riguroso. Si no hay significancia estadística, no se puede rechazar la hipótesis nula, y se dice que no hay evidencia suficiente para afirmar que el medicamento es efectivo.

#warning-box[
  Al rechazar la hipótesis nula, estamos aseverando que existe significancia estadística para decir que el medicamento es efectivo, sin embargo, existe una pequeña probabilidad de cometer un error, y está asociada al factor $alpha$ que escogimos, como se puede ver en la @table-neyman-pearson.
]

#figure(table(
  columns: 3,
  rows: auto,
  [Decisión], [$H_0$], [$H_A$],
  [$H_0$], {
    set text(fill: rgb("#046d04")) 
    [\u{2713}]
  }, [Error "Tipo $2$" ($beta$)],
  [$H_A$], [Error "Tipo $1$" ($alpha$)], {
    set text(fill: rgb("#046d04")) 
    [\u{2713}]
  }
), caption: [Tabla de decisiones para el test de hipótesis.]) <table-neyman-pearson>

El error tipo $1$ ($alpha$) corresponde a rechazar la hipótesis nula cuando es cierta, y el error tipo $2$ ($beta$) corresponde a no rechazar la hipótesis nula cuando es falsa.

== Tests clásicos

=== Test de diferencia de medias <difference-means>

El test de diferencia de medias, también denominado $t$-test, formula las siguientes hipótesis:

$
  H_0 &: mu_X = mu_Y \
  H_A &: mu_X != mu_Y
$

Asumimos que $X ~ normal(mu_X, sigma_X^2)$ e $Y ~ normal(mu_Y, sigma_Y^2)$. De estas variables aleatorias se generan las muestras aleatorias ${X_i}_(i=1)^N$ y ${Y_i}_(i=1)^M$, y además $sigma_X^2 = sigma_Y^2 = sigma^2$. Por otro lado, el estadístico $t$ se define como:

$
  t = (overline(X) - overline(Y))/(S_P dot sqrt(1\/N + 1\/M))
$

donde $S_P$ define una expresión que se genera a partir del estimador de la varianza de la diferencia de medias.

Para la hipótesis nula, es equivalente decir $H_0: overline(X)=overline(Y) <==> H_0: overline(X)-overline(Y)=0$. Esta diferencia distribuye como una resta de normales:

$
  overline(X)-overline(Y) ~ normal(mu_X - mu_Y #keyword[\= 0], sigma^2 dot (1/N + 1/M)) & "(hipótesis del test)"
$

La varianza de la resta se calcula de la siguiente forma, dado que son variables aleatorias i.i.d.:

$
  var(overline(X)-overline(Y)) = var(overline(X)) + var(overline(Y)) = sigma_X^2/N + sigma_Y^2/M = sigma^2 dot (1/N + 1/M)
$

Si $sigma^2$ es conocido, entonces podemos decir que:

$
  Z = (overline(X)-overline(Y) #keyword[-0])/(sigma dot sqrt(1\/N + 1\/M)) ~ normal(0, 1)
$

Pero como no lo conocemos, debemos estimar el parámetro. Como recuerdo, el estimador insesgado de la varianza es:

$
  S^2 = 1/(N-1) dot sum_(i=1)^N (X_i - overline(X))^2
$

Sin embargo, sabemos que $sigma_X^2 = sigma_Y^2$, entonces podemos decir que:

$
  S_P^2 &= 1/(N+M-2) dot (sum_(i=1)^N (X_i - overline(X))^2 + sum_(j=1)^M (Y_j - overline(Y))^2) \
  &= 1/(N+M-2) dot ((N-1) dot S_X^2 + (M-1) dot S_Y^2)
$

Haciendo la transformación que vimos en intervalos de confianza:

$
  t ~ lr(normal(0,1) mid(\/) sqrt(chi^2_[N+M-2]/(N+M-2)) = t_[N+M-2])
$

Es decir, $t$ distribuye como una $t$-Student de $N+M-2$ grados de libertad.

=== Test de diferencia en proporciones

Sea $p_i$ la probabilidad de éxito en la $i$-ésima población. Se define la hipótesis nula como:

$
  H_0: p_1 = p_2 <==> H_0: p_1 - p_2 = 0
$

Y se define $X_i = "n.° éxitos"\/"total de la muestra"$ con $EE[X_i] = n p$ para todo $i$. Bajo $H_0$, tenemos que $p_1=p_2=p$, y $var(hat(p_i)) = p dot (1-p)\/n_i$, con $hat(p_i) = X_i\/n_i$ (símil a $overline(X)$, pero en proporción)  y $hat(p) = (X_1+X_2)\/(n_1+n_2)$.  Entonces:

$
  Z = (hat(p_1) - hat(p_2))/sqrt(p dot (1-p) dot (1\/n_1+1\/n_2)) ~ normal(0, 1)
$

cuando $n_1$ y $n_2$ tienden a infinito.

== Análisis de un test de hipótesis


Hay tres formas de analizar un test de hipótesis, y todas son equivalentes. Para los ejemplos de a continuación, usaremos el test de diferencia de medias (@difference-means), pero se pueden aplicar a cualquier otro test.

+ Comparar el estadístico $t$ con el valor tabulado de la distribución.

  - #example[Si $alpha=0.05$, debo buscar el valor para $alpha\/2 = 0.025$ en la _tail probability_ de la tabla de distribución de una $t$-Student con $N+M-2$ grados de libertad. El valor de $alpha$ se divide en $2$ dado que el test de diferencia de medias es de $2$ colas. Si $t$ es mayor que el valor tabulado, se rechaza la hipótesis nula. Si $t$ es menor que el valor tabulado, no se puede rechazar la hipótesis nula.]

    #note-box[
      Si la hipótesis alternativa contiene $<$ o $>$, se dice que es un test de una cola. Si la condición es $!=$, entonces es un test de dos colas.
    ]

+ Calcular el $p$-valor y comparar con $alpha$.

  - #example[
    Es similar al método anterior, salvo que ahora tenemos los grados de libertad (`df`; filas) y el valor del estadístico $t$ (celdas de la tabla). Con esto, buscamos el $p$-valor más cercano en la tabla de la $t$-Student (_tail probability_; columnas). Si el $p$-valor es menor que $alpha$, se rechaza la hipótesis nula. Si el $p$-valor es mayor que $alpha$, no se puede rechazar la hipótesis nula.
  ]

+ Mirar el intervalo de confianza $"C"(overline(X)-overline(Y)) = overline(X)-overline(Y) plus.minus Z_alpha dot std(overline(X)-overline(Y))$

  - #example[¿Qué pasa si el intervalo de confianza del $95 \%$ no contiene el $0$? Entonces, se rechaza la hipótesis nula, porque esta asumía que la diferencia de medias era $0$. Si el intervalo de confianza contiene el $0$, no se puede rechazar la hipótesis nula.]

Si rechazamos la hipótesis nula, tomando el ejemplo, podemos aseverar que hay una diferencia de medias significativa entre los grupos.

= Ejemplos de tests de hipótesis

== Tests paramétricos y no paramétricos

Los tests de hipótesis paramétricos se usan cuando se conoce la distribución de las variables y se puede hacer inferencia sobre sus parámetros. Por ejemplo: $t$-test, test de diferencia en varianzas ($F$-Fisher), y ANOVA.

Por otro lado, los tests de hipótesis no paramétricos ("distribution-free test") son los que se hacen cuando no conocemos las distribuciones, o no se quiere hacer supuestos sobre las distribuciones. Por ejemplo: Mann-Whitney (U-test), Kruskal-Kallis (H-test), y Kolmogorov-Smirnov (KS-test).

=== Test de Kolmogorov-Smirnov

Este test se ocupa para ver si dos muestras empíricas se parecen o no. Esto permite, por ejemplo, hacer clasificaciones binarias. Su estadístico, $D_(n,m)$, se define como sigue:

$
  D_(n, m) = sup_x abs(F_(1,n) (x) - F_(2,m) (x))
$

donde $F_(1,n)$ es una distribución empírica acumulada (CDF) con una muestra de tamaño $n$, y $F_(2,m)$ otra distribución empírica acumulada, pero con una muestra de tamaño $m$. Este cálculo corresponde al supremo de las distancias entre las dos distribuciones, como se puede ver en el ejemplo de la @kolmogorov-smirnov a continuación:

#figure(image("images/classes/kolmogorov-smirnov.svg", width: 55%), caption: [Representación gráfica de $D_(n,m)$ en un test de Kolmogorov-Smirnov.]) <kolmogorov-smirnov>

La regla de rechazo es la siguiente:

$
  D_(n,m) > C(alpha) dot sqrt((n+m)/(n dot m)); quad C(alpha) = sqrt(-ln(alpha/2) dot 1/2)
$

#example[
  _Analizando fallas en equipos mineros._ Definamos las siguientes variables aleatorias:

  $
    X_i: i"-ésima presión sobre el equipo"; quad Y = cases(
      1 & "si el equipo falla",
      0 & "si no"
    )
  $

  y extraigamos las muestras $F_(1,N) = {X_i bar Y = 1}$ con $abs(F_(1,N)) = N$ y $F_(2,M)={X_i bar Y=0}$ con $abs(F_(2,M)) = M$, es decir, muestras de tamaño $N$ y $M$ cuando el equipo falla y no falla respectivamente. Nos gustaría que el test se rechazara, o sea, que las presiones sean distintas en modo falla y no falla. De esta manera, podemos establecer una correlación entre la presión y el estado de falla del equipo, lo que permite anticiparse a los defectos.
]

== Tests de hipótesis conjunta

Se dice que un test es de hipótesis conjunta si tiene más de una restricción lineal. Por ejemplo, el siguiente test cumple esta condición:

$
  H_0:& beta_1 = 0 \
  &beta_2 + beta_3 = 1
$

Esto es equivalente a decir $H_0: beta_1 = 0 and beta_2 + beta_3 = 1$, es decir, tenemos $2$ restricciones lineales. La hipótesis alternativa $H_A$ es la negación lógica de $H_0$. Tener más de una hipótesis nos hace siempre conectarla con un "y lógico", pues se trata de un conjunto de restricciones.

Estas hipótesis se pueden escribir como una ecuación matricial:

$
  H_0&: R dot bold(beta) = bold(r) \
  H_A&: R dot bold(beta) != bold(r)
$

Por ejemplo, usando el ejemplo anterior:

$
  underbrace(mat(
    1, 0, 0;
    0, 1, 1 
  ), R) dot underbrace(mat(beta_1; beta_2; beta_3), bold(beta)) = underbrace(mat(0; 1), bold(r))
$

Cuando rechazo $H_0$, se puede concluir que al menos una de las hipótesis no es cierta estadísticamente.

=== Test de ANOVA

La idea de este test es extender el $t$-test, o test de diferencia de medias, a más de dos grupos.

#example[
  Supongamos que queremos testear la efectividad de un medicamento. Tenemos $16$ regiones, y a cada una le envío el medicamento. Tenemos $I$ grupos ${1, dots, I}$ y $J$ observaciones ${1, dots, J}$, y además definimos $Y_(i j) : "Observación" j "del grupo" i$. Esta variable se define como:

  $
    Y_(i j) = mu + alpha_i + epsilon_(i j)
  $

  donde $mu$ es la media poblacional, $alpha_i$ es el efecto de estar en el grupo $i$, y $epsilon_(i j)$ son los "no observables", por ejemplo, factores externos no considerados.

  Nuestra hipótesis nula se define como sigue:

  $
    H_0:& alpha_0 = alpha_1 = alpha_2 = dots = alpha_I = 0
  $

  Aparte, se define $overline(Y)_(dot, dot)$ como el promedio sobre todo $i$ y sobre todo $j$, e $overline(Y)_(i, dot)$ como el promedio sobre $j$ del grupo $i$. El punto del subíndice denota que ese índice se mueve sobre todo el rango que abarca.

  Tenemos que considerar la "varianza" intragrupal (SSW) e intergrupal (SSB):
  
  $
    "SSW" &= sum_(i=1)^I sum_(j=1)^J (Y_(i j) - overline(Y)_(i, dot))^2 \
    "SSB" &= J dot sum_(i=1)^I (overline(Y)(i, dot) - overline(Y)(dot, dot))
  $

  A partir de esto, comparamos la varianza intragrupal con la intergrupal, y obtenemos el estadístico $F$ que se define como sigue:

  $
    F = ("SSB"\/(I-1))/("SSW"\/(I dot (J-1))) ~ F_(alpha, I-1, I dot (J-1))
  $

  Para rechazar o no rechazar la hipótesis nula, tenemos que ver qué tan lejos está $F$ de $1$. Si $F >> 1$, la rechazamos, porque quiere decir que la varianza intergrupo es mucho más grande, o sea, existe al menos una población que obtuvo efectos distintos con el medicamento a las demás.
]

=== Boxplot

Es un gráfico que me permite ver la distribución de una muestra, dividida por sus cuartiles. En el ejemplo anterior, este instrumento me permite caracterizar las poblaciones y los efectos que tiene el medicamento sobre ellas, y esto permite determinar cuáles son las poblaciones que son distintas a las demás en el caso $F >> 1$. 

Los distintos elementos que componen un _boxplot_, para $3$ grupos $G_1$, $G_2$ y $G_3$, se pueden ver en la @boxplot de a continuación:

#figure(image("images/classes/boxplot.svg", width: 70%), caption: [Representación gráfica de un _boxplot_.]) <boxplot>

#note-box[
  Un gráfico similar para ver la distribución de los datos es el _violinplot_. Lo importante es que está implementado en librerías populares de visualización de información como `seaborn` en Python.
]

= Estimación paramétrica

Hasta ahora, hemos trabajado sobre la identificación de fenómenos, sin embargo, no hemos visto cómo predecir. Esto es algo que se trabajará en esta sección. Se introduce entonces una notación que mencionamos en la @statistic-inference:

$
  Y = m(X)
$

donde $Y$ es la variable dependiente, $m$ el modelo, y $X$ las variables independientes. Un ejemplo podría ser $Y :=$ Tiempo de espera, $X_1 :=$ Género, $X_2 :=$ IDH (índice de desarrollo humano).

- ¿Cómo evaluamos si un modelo es bueno? Tenemos que mirar el error que tiene con respecto a $Y$. Existen métricas también que nos permiten cuantificar este error, como la métrica $R^2$.

== Función de pérdida/costo (_loss_)

Una función de pérdida intuitivamente determina el costo de estimar uno de los argumentos mediante otro. Normalmente, las funciones de pérdida se anotan con $L$ y tienen la siguiente firma:

$
  L = Omega times Omega -> RR 
$

#example[
  Sea $theta in Omega$ y $a in Omega$ un estimador, entonces el costo de estimar $theta$ mediante $a$ está dado por la función de costo $L(theta, a)$.
]

Una función de pérdida comunmente usada es la divergencia de Kullback-Leibler.

== Modelos lineales <linear-models>

Los modelos lineales son los modelos más simples que existen, y se definen como:

$
    Y = X dot beta + epsilon; quad Y, epsilon in RR^n, X in cal(M)_(n times (k+1)) (RR), beta in RR^(k+1)
$

donde $Y$ es el vector de valores predichos, $X$ es una matriz de datos, $beta$ es el vector de parámetros del modelo, y $epsilon$ es el vector de errores. La matriz $X$ tiene su primera columna llena de unos para el intercepto $beta_0$, como se puede ver a continuación:

$
  Y = vec(Y_1, dots, Y_n); quad X = mat(1, X_(1,1), dots, X_(k,1); 1, X_(1,2), dots, X_(k,2); dots.v, dots.v, dots, dots.v; 1, X_(1,n), dots, X_(k,n)); quad bold(beta) = vec(beta_0, beta_1, dots, beta_k); quad bold(epsilon) = vec(epsilon_1, dots, epsilon_n)
$

#example(title: "Ejemplo de aplicación")[
  El precio de un vino, analizado mediante un gráfico donde la variable independiente son los años desde la cosecha, y la variable dependiente es el precio. Podemos entonces definir un modelo simple que tenga la siguiente relación, con $Y = Y_"precio"$ y $X = X_"años cosecha"$:

  $
    Y = beta_0 + beta_1 dot X + epsilon
  $

  El error de este modelo puede ser calculado como $epsilon = Y - m(X) = Y - beta_0 - beta_1 X$. Un modelo lineal es muy simple para modelar este fenómeno y varios más, pues los datos muestran una relación distinta, y hay muchos errores de predicción, como se puede ver en la @linear-model.

  #figure(image("images/classes/linear_model.svg", width: 60%), caption: [Representación gráfica de un modelo lineal. $Y_"pred"$ es el valor predicho (la recta), e $Y_"real"$ el valor real (los puntos azules).]) <linear-model>
]

== Mínimos cuadrados ordinarios (OLS)

El método de mínimos cuadrados ordinarios (OLS) es un método de estimación de los parámetros $beta_i$ para $i in {0, dots, k}$ que busca minimizar la suma de los cuadrados de los errores. Este método se basa en la idea de que el error cuadrático es una buena medida de la discrepancia entre el modelo y los datos observados, como se vio en el gráfico de la @linear-models.

El modelo de optimización para sólo una variable independiente (es decir, $k=1$), se define como $min_(beta_0, beta_1) epsilon^2$, donde $epsilon$ es una función de $beta_0$ y $beta_1$, es decir, $epsilon = epsilon(beta_0, beta_1)$.

=== Regresión multivariada

Como muy pocas veces tenemos modelos de sólo una variable independiente, necesitamos una siguiente generalización para $k$ variables independientes. Esta generalización es la que se vio en la @linear-models, para un $k>1$. El problema de optimización en este caso es el siguiente:

$
  min_beta norm(epsilon)^2 = min_beta epsilon^T epsilon &= min_beta (Y^T-beta^T X^T)dot (Y-X beta) \
  &= min_beta Y^T Y - Y^T X beta - beta^T X^T Y + beta^T X^T X beta \
  &= min_beta Y^T Y - 2 beta^T X^T Y + beta^T X^T X beta
$

Notar que el último paso se obtiene porque $Y^T X beta = (beta^T X^T Y)^T$, y ambas multiplicaciones son un número real realizando un análisis dimensional, por lo tanto, deben dar el mismo resultado.

Como el problema de optimización es irrestricto, el óptimo se encuentra cuando la derivada es $0$ (condición de primer orden). Entonces:

$
  & partial / (partial beta) lr([ Y^T Y - 2 X^T Y + 2 X^T X beta ]|_(beta = hat(beta)_"OLS")) = 0 \
  <==> & -2 X^T Y + 2 X^T X hat(beta)_"OLS" = 0 \
  <==> & X^T X hat(beta)_"OLS" = X^T Y \
  <==> & hat(beta)_"OLS" = (X^T X)^(-1) X^T Y
$

Esta última expresión toma especial importancia en la definición de un requisito para el uso de los mínimos cuadrados ordinarios. Se requiere que $X^T X$ sea invertible, es decir, las columnas de $X$ no pueden ser linealmente dependientes. 

#example[
  ¿Cuándo no usar OLS, dado que $X^T X$ no es invertible? Tomemos un caso donde $X$ es linealmente dependiente (l. d.):

  $
    X_"mujer" = cases(
      1 & "si es mujer",
      0 & "si no"
    ); quad X_"hombre" = cases(
      1 & "si es hombre",
      0 & "si no"
    )
  $

  Estas dos variables son completamente dependientes, pues $X_"mujer" = 1 - X_"hombre"$, por lo tanto, un modelo que esté definido mediante $Y = beta_0 + beta_1 dot X_"mujer" + beta_2 dot X_"hombre" + epsilon$ no es válido para usar OLS. 
  
  La solución es desprenderse de alguna de las dos variables, y esto depende de la interpretación que se le quiera dar al modelo. Por ejemplo, si se quiere ver el efecto de ser mujer, entonces se usa $X_"mujer"$ y se deja fuera $X_"hombre"$, y viceversa.

  #note-box[
    Generalmente, un _solver_ devolverá `NaN` cuando encuentre que la matriz $X^T X$ no es invertible.
  ]
]

Finalmente, nos cuestionaremos la insesgadez del estimador $hat(beta)_"OLS"$. Para ello, desarrollemos la expresión de su esperanza:

$
  EE[hat(beta)_"OLS"] &= EE[(X^T X)^(-1) X^T Y] \
  &= EE[(X^T X)^(-1) X^T (X beta + epsilon)] \
  &= EE[(X^T X)^(-1) X^T X beta] + EE[(X^T X)^(-1) X^T epsilon] \
  &= EE[beta] + EE[(X^T X)^(-1) X^T epsilon] \
  &= beta + (X^T X)^(-1) X^T dot EE[epsilon] \
$

La última igualdad es cierta porque $X$ es un dato. Así, la única forma de que $hat(beta)_"OLS"$ sea insesgado es que $EE[epsilon] = 0$. Si se quiere tener un estimador insesgado de OLS, se debe imponer este supuesto.