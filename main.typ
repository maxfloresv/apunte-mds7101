#import "utils/template.typ": *
#import "utils/variables.typ": *
#import "utils/functions.typ": *
#import "@preview/theorion:0.3.3": *
#import cosmos.fancy: *
#show: show-theorion

#show: main-rules

= Repaso de probabilidades

- *¿Qué es una probabilidad?* Una probabilidad es una medida de incertidumbre.

- Tiene dos enfoques: frecuentista y bayesiano. Para el frecuentista, la probabilidad es algo inherente a la naturaleza, y su paradigma de cálculo es $"casos favorables"\/"casos totales"$. Para el bayesiano, la probabilidad es un invento del ser humano, y ya no se usa la fórmula anterior

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

+ Fisher ($F$): combinamos dos $chi^2$ independientes:

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

Cuando decimos $corr(X,Y) = 0$, quiere decir que no hay información sobre la relación lineal entre $X$ e $Y$. Esto no quiere decir que $X$ e $Y$ sean independientes, porque pueden tener un tipo de relación no lineal, por ejemplo, cuadrática.

#example-box[Sea $X ~ "U"[-1, 1]$ e $Y = X^2$, con $"U"(a,b)$ una distribución uniforme. Como los momentos de una variable $Z$ que distribuye uniformemente en el intervalo $(a, b)$ se calculan mediante la expresión:

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

  pero $Y$ sí depende de $X$, entonces no pueden ser independientes.
]

#pagebreak(weak: true)

= Inferencia estadística <statistic-inference>

La inferencia estadística es una rama de la estadística que se encarga de hacer predicciones o caracterizaciones sobre una población a partir de una muestra.

Normalmente, habrá una variable $Y ~ f(X)$, con $f$ una función genérica llamada modelo, que encuentra una relación. $Y$ se llama variable endógena, porque depende de $X$. Será la variable que estudiaremos. Por otro lado, $X$ se llama variable exógena, porque en el mundo ideal no depende de nada.

#example-box[
  Definimos las variables aleatorias $Y :=$ demanda por poleras, y $X :=$ tallas (estaturas). Acá surge naturalmente un problema: necesitamos estudiar más a fondo el caso, pues nunca conoceremos la media o desviación estándar exacta de la población. Para esto, definiremos una herramienta que se verá en la @estimators.
]

== Estimadores <estimators>

En el caso anterior, no podemos conocer ni $mu$ ni $sigma$. Como habrán casos donde esto suceda, necesitamos instrumentos que "aproximen" estos valores para poder hacer la inferencia, por ejemplo:

$
  overline(X) = 1/N dot sum_(i=1)^N X_i
$

- *¿Por qué nos gusta el promedio?* El promedio cumple con propiedades que hacen que sea un buen estimador. Una de ellas se enlista a continuación:

  - _Insesgadez_. Sea $T(X)$ estimador del parámetro $theta$. $T(X)$ es #annotate[insesgado] si $EE[T(X)] = theta$. Esto significa que su valor esperado está completamente centrado en el parámetro que estoy buscando. Esta propiedad la cumple el promedio:

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

- _Consistencia_: Un estimador $T(X_n)$ del parámetro $theta$ es #annotate("consistente") si converge en probabilidad al parámetro de interés, es decir:
 $
   lim_(n->infinity) PP(abs(T(X_n)-theta)<epsilon)=1
 $

=== Ejemplos de sesgo y consistencia <examples-bias-consistency>

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

=== Caracterización de la consistencia <caracterization-consistency>

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

== Teorema Central del Límite (TCL) <tcl>

Sea ${X_i}_(i=1)^N$ una muestra aleatoria i.i.d. con $EE(X_i) = mu < infinity$ y $var(X_i) = sigma^2 < infinity$ para todo $i in {1, 2, dots, N}$. Entonces:

$
  & 1/N dot sum_(i=1)^N (X_i - mu) ->_d normal(0, sigma^2) \
  ==>& (overline(X_n) - mu)/(sigma\/sqrt(N)) ->_d normal(0, 1)
$

donde $sigma\/sqrt(N)$ es la varianza de la variable aleatoria $overline(X_n)$.

La "gracia" de este teorema es que no importa cómo distribuyan las variables aleatorias ${X_i}_(i=1)^N$, siempre y cuando cumplan con las condiciones del TCL, la suma de ellas se comportará como una normal estándar. Una consecuencia directa es que cuando tenemos muestras grandes, podemos calcular los intervalos de confianza usando una $normal(0,1)$, dado que el estadístico $t$ converge a dicha distribución.

#pagebreak(weak: true)

= Introducción a los tests de hipótesis

== Test de hipótesis <hypothesis-test>

El test de hipótesis es una herramienta clave en la inferencia estadística que nos ayuda a decidir si los datos muestrales proporcionan suficiente evidencia para apoyar una determinada afirmación sobre la población.

Realizaremos el siguiente experimento para hacer comparaciones: escogemos $N=30$ personas con COVID, divididas en dos grupos de $N_1=N_2=15$ personas. A un grupo le damos un medicamento y al otro un placebo, para anular el efecto psicológico. Luego, medimos los días que se demoró cada paciente en recuperarse. Los resultados del promedio por grupo son:

$
  overline(X_1) = 3.5 "días" quad and quad overline(X_2) = 4.5 "días"
$

Una pregunta que surge naturalmente es: ¿podemos afirmar que el medicamento es efectivo? La respuesta es no, porque a pesar de que puedo hacer que las muestras sean altamente homogéneas, siempre habrán factores que no podemos controlar, por ejemplo, situaciones personales de cada paciente, medicamentos extras que no fueron informados, etc. Para enfrentar esta problemática, se definen las siguientes herramientas matemáticas:

- Hipótesis nula ($H_0$): Plantea que "no existe un efecto", y se asume que es cierta hasta que tengamos evidencia suficiente para rechazar esta afirmación. Afecta el tipo de experimento o procedimiento, y los datos que son recopilados.

  #example-box(title: "Efectividad de la urgencia de un hospital.")[
    Están las readmisiones, muertes hospitalarias, y la duración de la estadía. Si uno mira estos indicadores, suelen ser altos, entonces una conclusión apresurada sería decir que la urgencia funciona mal. Esto no necesariamente es cierto, porque los pacientes que entran a urgencia ya vienen con una situación grave previa.
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
  overline(X)-overline(Y) ~ normal(mu_X - mu_Y #annotate[\= 0], sigma^2 dot (1/N + 1/M)) & "(hipótesis del test)"
$

La varianza de la resta se calcula de la siguiente forma, dado que son variables aleatorias i.i.d.:

$
  var(overline(X)-overline(Y)) = var(overline(X)) + var(overline(Y)) = sigma_X^2/N + sigma_Y^2/M = sigma^2 dot (1/N + 1/M)
$

Si $sigma^2$ es conocido, entonces podemos decir que:

$
  Z = (overline(X)-overline(Y) #annotate[-0])/(sigma dot sqrt(1\/N + 1\/M)) ~ normal(0, 1)
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

  #example-box[Si $alpha=0.05$, debo buscar el valor para $alpha\/2 = 0.025$ en la _tail probability_ de la tabla de distribución de una $t$-Student con $N+M-2$ grados de libertad. El valor de $alpha$ se divide en $2$ dado que el test de diferencia de medias es de $2$ colas. Si $t$ es mayor que el valor tabulado, se rechaza la hipótesis nula. Si $t$ es menor que el valor tabulado, no se puede rechazar la hipótesis nula.

  Si la hipótesis alternativa contiene $<$ o $>$, se dice que es un test de una cola. Si la condición es $!=$, entonces es un test de dos colas.
  ]

+ Calcular el $p$-valor y comparar con $alpha$.

  #example-box[
    Es similar al método anterior, salvo que ahora tenemos los grados de libertad (`df`; filas) y el valor del estadístico $t$ (celdas de la tabla). Con esto, buscamos el $p$-valor más cercano en la tabla de la $t$-Student (_tail probability_; columnas). Si el $p$-valor es menor que $alpha$, se rechaza la hipótesis nula. Si el $p$-valor es mayor que $alpha$, no se puede rechazar la hipótesis nula.
  ]

+ Mirar el intervalo de confianza $"C"(overline(X)-overline(Y)) = overline(X)-overline(Y) plus.minus Z_alpha dot std(overline(X)-overline(Y))$

  #example-box[¿Qué pasa si el intervalo de confianza del $95 \%$ no contiene el $0$? Entonces, se rechaza la hipótesis nula, porque esta asumía que la diferencia de medias era $0$. Si el intervalo de confianza contiene el $0$, no se puede rechazar la hipótesis nula.]

Si rechazamos la hipótesis nula, tomando el ejemplo, podemos aseverar que hay una diferencia de medias significativa entre los grupos.

#pagebreak(weak: true)

= Ejemplos de tests de hipótesis

== Tests paramétricos y no paramétricos

Los tests de hipótesis paramétricos se usan cuando se conoce la distribución de las variables y se puede hacer inferencia sobre sus parámetros. Por ejemplo: $t$-test, test de diferencia en varianzas ($F$-Fisher), y ANOVA.

Por otro lado, los tests de hipótesis no paramétricos ("distribution-free test") son los que se hacen cuando no conocemos las distribuciones, o no se quiere hacer supuestos sobre las distribuciones. Por ejemplo: Mann-Whitney ($U$-test), Kruskal-Kallis ($H$-test), y Kolmogorov-Smirnov ($"KS"$-test).

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

#example-box(title: "Analizando fallas en equipos mineros.")[
  Definamos las siguientes variables aleatorias:

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

=== Test ANOVA

La idea de este test es extender el $t$-test, o test de diferencia de medias, a más de dos grupos.

#example-box(title: "Efectividad de un medicamento.")[
  Tenemos $16$ regiones, y a cada una le envío el medicamento. Tenemos $I$ grupos ${1, dots, I}$ y $J$ observaciones ${1, dots, J}$, y además definimos $Y_(i j) : "Observación" j "del grupo" i$. Esta variable se define como:

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

#pagebreak(weak: true)

= Introducción a OLS y sus supuestos <intro-ols-and-assumptions>

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

#example-box[
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

#example-box(title: "Precio de un vino vs. años desde la cosecha.")[
  Podemos definir un modelo simple que tenga la siguiente relación, con $Y = Y_"precio"$ y $X = X_"años cosecha"$:

  $
    Y = beta_0 + beta_1 dot X + epsilon
  $

  El error de este modelo puede ser calculado como $epsilon = Y - m(X) = Y - beta_0 - beta_1 X$. Un modelo lineal es muy simple para modelar este fenómeno y varios más, pues los datos muestran una relación distinta, y hay muchos errores de predicción, como se puede ver en la @linear-model.

  #figure(image("images/classes/linear_model.svg", width: 60%), caption: [Representación gráfica de un modelo lineal. $Y_"pred"$ es el valor predicho (la recta), e $Y_"real"$ el valor real (los puntos azules).]) <linear-model>
]

== Mínimos cuadrados ordinarios (OLS)

El método de mínimos cuadrados ordinarios (OLS) es un método de estimación de los parámetros $beta_i$ para $i in {0, dots, k}$ que busca minimizar la suma de los cuadrados de los errores. Este método se basa en la idea de que el error cuadrático es una buena medida de la discrepancia entre el modelo y los datos observados, como se vio en el gráfico de la @linear-models.

El modelo de optimización para sólo una variable independiente (es decir, $k=1$), se define como $min_(beta_0, beta_1) epsilon^2$, donde $epsilon$ es una función de $beta_0$ y $beta_1$, es decir, $epsilon = epsilon(beta_0, beta_1)$.

=== Regresión multivariada <multivariate-regression>

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

#example-box(title: [¿Cuándo no usar OLS, dado que $X^T X$ no es invertible?])[
 Tomemos un caso donde $X$ es linealmente dependiente (l. d.):

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

  Generalmente, un _solver_ devolverá `NaN` cuando encuentre que la matriz $X^T X$ no es invertible.
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

Por otro lado, si calculamos la varianza del estimador, tenemos la siguiente expresión:

$
  var(hat(beta)_"OLS") &= var((X^T X)^(-1) X^T Y) \
  &= var(beta + (X^T X)^(-1) X^T epsilon) \
  &= var((X^T X)^(-1) X^T epsilon) \ 
  &= (X^T X)^(-1) X^T dot var(epsilon) dot ((X^T X)^(-1) X^T)^T & annotate("("var(A X) = A dot var(X) dot A^T")") \
  &= (X^T X)^(-1) X^T dot var(epsilon) dot X dot (X^T X)^(-1) & #h(6em) annotate("("(A^(-1))^T = (A^T)^(-1)")") \
  &= (X^T X)^(-1) X^T dot sigma^2_epsilon dot II_n dot X dot (X^T X)^(-1) & annotate(("asunción sobre" var(epsilon))) \
  &= sigma^2_epsilon dot (X^T X)^(-1) dot X^T X dot (X^T X)^(-1) & annotate("(el escalar" sigma^2_epsilon "conmuta)") \
  &= sigma^2_epsilon dot II_n dot (X^T X)^(-1)
$

La asunción que se hace sobre $var(epsilon)$ es que necesitamos que sea igual a una constante, que en esta ecuación denotamos por $sigma^2_epsilon dot II_n$, donde $II_n$ es la matriz identidad de $n times n$.

== Criterio de mínima varianza <minimum-variance>

Sean $hat(beta)$ un estimador insesgado fijo y $tilde(beta)$ cualquier otro estimador insesgado del parámetro $beta$. Se dice que $hat(beta)$ es de mínima varianza si se cumple la siguiente relación: $var(hat(beta)) <= var(tilde(beta))$.

== Supuestos de OLS <ols-assumptions>

1. #underline[Linealidad]: El modelo debe ser lineal en los parámetros.

  #example-box[
    El siguiente modelo no es lineal en los parámetros, y por lo tanto, no cumple este supuesto:

    $
      Y = beta_0 + underbrace(beta_1 dot beta_2, "no lineal") X_1 + underbrace(beta_3^2, "no lineal") X_2 + epsilon
    $

    Por otro lado, el siguiente modelo sí cumple el supuesto:

    $
      Y = beta_0 + beta_1 X_1 + beta_2 X_1 dot X_2 + beta_3 dot X_2^3 + beta_4 dot log(X_3) + epsilon
    $
  ]

  Además, el error debe ser aditivo, es decir, $Y = beta_0 + beta_1 X_1 + dots + beta_k X_k + epsilon$. No puede ser multiplicativo, como lo sería en el siguiente modelo: $Y = beta_0 + beta_1 X_1 epsilon$.

2. #underline[Muestra aleatoria]: Asumo que trabajo con ${Y_i, X_(i k)}_(i=1)^N$, con $k$ variables i.i.d. Entonces:

  $
    EE(hat(beta)_"OLS") &= beta "si" cov(x, epsilon) = 0 \
    var(hat(beta)_"OLS") &= var(beta + (X^T X)^(-1) X epsilon) \
  $

  Necesitamos variación en los datos, porque si escogemos un grupo muy específico en un estudio general, habrá un sesgo muy grande.

+ #underline[Multicolinealidad]: Se requiere que $"rango"(X^T X) = k$, o cualquier afirmación equivalente, por ejemplo, que las filas sean linealmente independientes (l. i.). Esto significa que no puede existir correlación perfecta entre $X_i$ y $X_j$ para todo $i != j$, con $i,j in {1, dots, k}$.

  Un ejemplo claro de multicolinealidad es el que se vio en la @multivariate-regression, con $X_"hombre"$ y $X_"mujer"$. Si el modelo es $Y = beta_1 X_"mujer" + beta_2 X_"hombre" + epsilon$, el coeficiente $beta_2$ captura el efecto de ser hombre. Acá, a pesar de que las variables son directamente dependientes, el hecho de eliminar el intercepto $beta_0$ mediante este "truco estadístico" permite usar OLS.

  #note-box[
    Si queremos añadir una interacción a un modelo, podemos añadir la multiplicación entre las dos variables que interactúan. Por ejemplo,

    $
      Y = beta_0 + beta_1 X_"mujer" + beta_2 X_(> 40 "años") + beta_3 X_"mujer" dot X_(> 40 "años") + epsilon
    $
  ]

  ¿Qué pasa si no es tan obvia la correlación? En el caso de mujeres y hombres, es claro que una depende de la otra, pero hay casos donde esto no es así. Tenemos estrategias para solucionar este problema:

  - Ver matriz de correlación entre las variables independientes $X$.

  - Supongamos que $X_1$ y $X_2$ están altamente correlacionadas, entonces se define el modelo:

    $
      X_1 = alpha_0 + alpha_1 X_2 + gamma; quad R^2 = "SSR"/"SST" = 1 - "SSE"/"SST" in [0,1]
    $

    donde $"SSR" = sum_(i=1)^N (hat(Y)_i - overline(Y))^2$, $"SST" = sum_(i=1)^N (Y_i - overline(Y))^2$ y $"SSE" = sum_(i=1)^N (Y_i - hat(Y)_i)^2$ y $R^2$ es una métrica de similitud. Además, se cumple que $"SST" = "SSR" + "SSE"$. Lo que se hace es analizar el modelo, y si $R^2$ es muy cercano a $1$, entonces ambas variables se explican muy bien en función de la otra, por lo tanto, se puede eliminar una de las dos variables.

+ #underline[Supuesto de identificación]: No hay ninguna relación entre el error y las variables independientes, es decir, $EE[X^T epsilon] = 0$ o $cov(X, epsilon) = 0$. Si el modelo es:

  $
    Y = beta_0 + beta_1 X_1 + dots + beta_k X_k + epsilon
  $

  entonces no hay ninguna variable independiente que sea parcialmente explicada por el error.

  #example-box[
    Tenemos el siguiente modelo, con $Y :=$ Salario, y $X :=$ Educación:

    $
      Y = beta_0 + beta_1 dot X + epsilon
    $

    entonces se debe cumplir $(partial y)/(partial x) = beta_1$, donde $beta_1$ es el efecto que tiene $X$ en $Y$. Esto nos habla de que una variación en la variable $X$ explica perfectamente el coeficiente que tiene asignado en el modelo. Si la derivada es distinta del coeficiente asignado, entonces existe otra variable que está generando una afección, y como cada $X_i$ es independiente, este efecto está en $epsilon$.
  ]

+ #underline[Homocedasticidad]: Este efecto habla de que $var(epsilon) = sigma^2_epsilon dot II_N$, donde $II_N$ es la identidad de $N times N$. Esto significa que ningún error está correlacionado con otro.

== Teorema de Gauss-Markov

Bajos los supuestos #circled_numbering(1) a #circled_numbering(5) que se vieron en la sección anterior, el estimador $hat(beta)_"OLS"$ es el mejor estimador lineal insesgado. Esto significa que tiene la menor varianza, como se definió en la @minimum-variance. En inglés se dice que es el _Best Linear Unbiased Estimator_ (BLUE).

#pagebreak(weak: true)

= Interpretación de los estimadores

== Deducción de efectos <hyp-test-linear-models>

Al estimar un efecto de una variable independiente $X_k$ sobre la variable dependiente $Y$, se puede hacer un test de hipótesis para ver si ese efecto es significativo o no. Para esto, se define la hipótesis nula como $H_0: beta_k = 0$, y la hipótesis alternativa como $H_A: beta_k != 0$.

El estadístico corresponde al siguiente:

$
  t = (hat(beta_k) - cancel(beta_k))/("SE"(hat(beta)_k)) ~ normal(0,1) & annotate("(ya que" beta_k = 0))
$

== Selección del modelo

Definimos un ejemplo de modelo restricto $"(R)"$ y un modelo irrestricto $"(U)"$ como sigue:

$
  "(R)" & Y = beta_0 + beta_1 X_1 + epsilon \
  "(U)" & Y = beta_0 + beta_1 X_1 + beta_2 X_2 + beta_3 dot X_1 X_2 + epsilon
$

donde las hipótesis nula y alternativa que se postulan son, respectivamente, $H_0: beta_2=beta_3 = 0$, $H_A: beta_2 != 0 or beta_3 != 0$. De aquí, se entiende que aplicando $H_0$ sobre $"(U)"$ obtenemos $"(R)"$. 

Se hace un test tomando como estadístico la $F$ de Fisher:

$
  F = (("SSR"_(R) - "SSR"_(U))\/g)/("SSE"_(U)\/(N - k - 1)) ~ F_(g, N-k-1)
$

donde $g$ es el número de restricciones en el modelo restringido, que para este ejemplo son $2$ ($beta_2 = 0 and beta_3 = 0$).

Si este test se rechaza, entonces al menos un parámetro $beta_k$ tiene un efecto significativo, que nos diría que la variable $X_k$ sí tiene un efecto sobre $Y$. Este test entonces sirve para agregar variables a nuestro modelo, previamente verificando si aportan. Si no aportan, es decir, su parámetro cumple $beta_k = 0$, se pueden eliminar del modelo. Por otro lado, si el test no se rechaza, entonces se puede concluir que el modelo restringido es mejor que el irrestricto.

En este último caso, para dilucidar cuáles son los $beta_k$ que tienen un efecto significativo, se puede hacer un test de hipótesis para cada uno de ellos. Esto se hace mediante el estadístico $t$ que se definió anteriormente, en la @hyp-test-linear-models.

#note-box[
  En Python, existe la librería `statsmodels` que permite hacer regresiones con OLS, y tiene más funciones útiles para hacer análisis estadístico.
]

- Se define el valor de $R^2$ ajustado ($R^2_"adj"$) como $R^2_"adj" = 1 - ("SSE"\/(N-k-1))/("SST"\/(N-1))$. Esta métrica nace de que $R^2$ siempre nos dice que más información es mejor, lo que no siempre es cierto, porque si dicha información no contribuye, se debe hacer una penalización.

#important-box[
  Cuando hago una observación donde la variable dependiente $Y$ está con un cambio de escala logarítimico (es decir, $Y' = log(Y)$), los $beta_k$ indican la variación porcentual de $Y$ por cada variación $Delta X_k$.

  Si la variable $X_k$ es indicadora, como lo podría ser en el caso de categorías, entonces el $beta_k$ indica la variación porcentual de $Y$ al cambiar de categoría. Por ejemplo, sea el siguiente modelo:

  $
    log("Salario") = 7-0.025 dot X_"mujer" + epsilon    
  $

  De acá, podemos desprender que el hecho de ser mujer disminuye el salario en un $2.5" %"$. Si hay $N$ variables categóricas, dejamos $N-1$ dentro y $1$ fuera. La interpretación es la misma.
]

== Diferencias de interpretación

Pueden haber distintos casos donde podemos interpretar distintas propiedades del modelo. Los más comunes se enumeran a continuación:

+ $Y = beta_0 + beta_1 X_1 + epsilon$

  #example-box(title: "Nivel-Nivel.")[
   Supongamos que hicimos una regresión y obtuvimos los coeficientes que nos definen el modelo $Y = 963.191 + 18.501 dot "ROE"$, donde $"ROE"$ es la variable independiente. La interpretación es la siguiente: "si el $"ROE"$ aumenta en una unidad, el salario aumenta en $18.501$".
  ]

+ $log(Y) = beta_0 + beta_1 X_1 + epsilon$

  #example-box(title: [$log$-nivel.])[
    Ahora la regresión es la siguiente, con el mismo ejemplo del salario:

    $
      log(Y) = 0.584 + 0.083 dot X_"Años educación"      
    $

    Acá, la interpretación es distinta: "si los años de educación aumentan en una unidad, el salario aumenta en un $8.3" %"$".
  ]

+ $log(Y) = beta_0 + beta_1 log(X_1)$

  #example-box(title: [$log$-$log$.])[
    Para este caso, digamos que la regresión es la siguiente, donde $Y$ es el salario de un CEO de una empresa:

    $
      log(Y) = 4.822 + 0.257 dot log(X_"Ventas")      
    $

    La interpretación es: "un aumento de un $1" %"$ de las ventas produce un aumento del $0.257" %"$ en el salario del CEO".
  ]

#pagebreak(weak: true)

= OLS: Causalidad

En esta sección, nos enfocaremos en el supuesto $4$ de OLS visto en la @ols-assumptions, que es el de identificación (endogeneidad). Este supuesto es el que nos dice que $cov(X, epsilon) = 0$. Recordemos que la esperanza del estimador $hat(beta)_"OLS"$ es:

$
EE[hat(beta)_"OLS"] = beta + (X^T X)^(-1) X^T dot EE[epsilon] = beta + cov(X, epsilon)/var(X)
$

¿Qué pasa si este supuesto no se cumple? Se buscan contextos de experimentos naturales, es decir, que no fueron planeados como un experimento del investigador, sino que se dieron de manera espontánea en la vida real.

== Ejemplos de contextos experimentales naturales

Veremos estudios que se realizaron en distintos contextos, y que se pueden usar para estudiar fenómenos de causalidad. Estos estudios son ejemplos de experimentos naturales, donde se busca un contexto en el cual los grupos de tratamiento y control sean aleatorios, y no haya sesgo. Esto permite hacer un análisis de causalidad, y no sólo de correlación.

#example-box(title: "Apesteguia, Palacios Huerta (2010).")[
  Se les ocurrió estudiar los penales en partidos de fútbol, porque i) es una tarea "sencilla", ii) mis sujetos de estudio son comparables: profesionales de alto rendimiento en finales de torneos internacionales. Todos tienen las mismas condiciones, iii) el grupo tratamiento-control es aleatorio, es decir, se asigna al azar quién parte.

  El resultado es ganar la definición a penales. Con más del $60" %"$, gana el equipo que parte pateando. Según esta investigación, este es el efecto que tiene el hecho de patear segundo. Esto se puede usar para analizar fenómenos que involucren cuánto afecta la presión en la toma de una decisión.
]

#example-box(title: "Fabián Waldinger (2010).")[
  Él quería estudiar cuál es el impacto que tienen los profesores en el desarrollo académico de los estudiantes de doctorado. Para eso, definió las siguientes variables principales:

  $
    Y &:= "Éxito profesional" \
    X_1 &:= "Calidad del profesor" \
    X_2, dots, X_n &:= "Otros factores del modelo"
  $

  ¿Cómo definimos el "éxito profesional"? Acá se define el sesgo de autoselección, porque los estudiantes de doctorado de por sí suelen ser buenos estudiantes, entonces muy raramente van a empeorar su rendimiento. Así, se tiene que definir algún suceso azaroso que permita ver el impacto de los profesores.

  El contexto que este investigador encontró estaba ligado con un régimen totalitario en la historia mundial. Muchos departamentos perdieron académicos por no ser partidarios del régimen histórico de esa época. Esto permite estudiar el impacto de los profesores en el rendimiento de los estudiantes, porque se puede ver cómo se comportan los estudiantes con distintos profesores.

  El investigador encontró que sí existía un efecto significativo, pues analizó un gráfico donde se ve que el número de publicaciones en buenos _journals_ disminuyó después de los despidos. Esto se puede ver a continuación:

  #figure(image("images/classes/diff_and_diff.svg"), caption: [Representación gráfica del efecto de los despidos.]) <diff-in-diff>

  La técnica que se muestra en la figura anterior (@diff-in-diff) se llama "diff-in-diff".
]

#example-box(title: "Compra en línea y retiro en tienda en Estados Unidos.")[
  Se quería ver cuál era el impacto que tenía esta opción en las ventas. Se analizó el porcentaje de venta antes, y el porcentaje de venta después, y se encontró que el porcentaje de venta posterior había disminuido.

  La pregunta era: ¿por qué disminiuyeron las ventas? Para solucionar la interrogante, hicieron una comparación con Canadá, donde las tiendas no estaban cerca de los vecindarios, entonces no había posibilidad inmediata de retiro, porque se había encontrado que las personas de Estados Unidos veían las tiendas disponibles e iban directamente en vez de comprar en línea. Si en Canadá el efecto era distinto, entonces la cercanía de las tiendas es un factor que influye.
]

#pagebreak(weak: true)

= Estimación paramétrica

Habíamos descrito en la @statistic-inference que un modelo se puede anotar como $Y = f(X)$. Hasta este punto, sabemos que un modelo depende de parámetros, que generalmente se anotan con la letra $theta$. Así, el modelo toma la forma $Y = f(X bar theta)$.

En esta sección, veremos más métodos para estimar los parámetros, y así tener alternativas al método de los mínimos cuadrados ordinarios (OLS) visto en la @intro-ols-and-assumptions.

== Método de los momentos

Se basa en estimar los momentos de la distribución propuesta. El $k$-momento de una variable aleatoria $X$ se define como $mu_k = EE[X^k]$, para $k>=1$ natural. La estimación de los parámetros se hace mediante la siguiente fórmula:

$
  hat(mu)_k = 1/N sum_(i=1)^N X_i^k; quad k = 1, dots, K
$

#example-box(title: "Distribución de Poisson.")[
  Esta distribución se ocupa para contar. Si $X$ sigue esta distribución, se anota $X ~ Poisson(lambda)$, donde $lambda$ es el parámetro.

  $
    PP(X=x) = (lambda^x e^(-lambda))/x!; quad x in NN_0, quad EE[X] = lambda
  $

  Tenemos una muestra ${X_i}_(i=1)^N$. La estimación por el método de los momentos del primer momento es la siguiente:

  $
    hat(mu)_1 = 1/N sum_(i=1)^N X_i = overline(X) = hat(lambda)
  $

  ya que $mu = EE[X] = lambda$, y además, $overline(X) = hat(mu)$.
]

#example-box(title: "Distribución normal.")[
  Se anota $X ~ normal(mu, sigma^2)$, donde $mu$ es la media y $sigma^2$ la varianza. Denotemos $mu_1 = EE[X]$, y $mu_2 = EE[X^2]$, y además sabemos que:
  
  $
    sigma^2 = var(X) = EE[X^2] - (EE[X])^2 = mu_2 - mu_1^2
  $

  Si tenemos una muestra aleatoria ${X_i}_(i=1)^N$, la estimación por el método de los momentos del primer momento es la siguiente:

  $
    hat(mu)_1 = 1/N sum_(i=1)^N X_i = overline(X)
  $

  y la estimación del segundo momento es:

  $
    hat(mu)_2 = 1/N sum_(i=1)^N X_i^2
  $

  Con la relación encontrada para $sigma^2$, podemos estimar la varianza como:

  $
    hat(sigma^2) = hat(mu)_2 - hat(mu)_1^2 = 1/N sum_(i=1)^N X_i^2 - (1/N sum_(i=1)^N X_i)^2 = 1/N sum_(i=1)^N (X_i - overline(X))^2
  $

  Este último estimador es sesgado y consistente, y lo vimos previamente en la @examples-bias-consistency.
]

== Método de máxima verosimilitud (MLE)

Sean $X=(X_1, X_2, dots, X_N)$ variables aleatorias con densidad conjunta.

$
  f(X, theta) = f(X_1, X_2, dots, X_N, theta)
$

con $theta in Theta$, donde $Theta$ es un espacio paramétrico. Entonces, la función de verosimilitud se define como:

$
  L &: Theta -> [0, +infinity) \
  theta &|-> f(X bar theta)
$

y representa una medida de la explicación de los datos según el modelo $f$, dado $theta$. Esto se anota como $L(theta bar X) = f(X bar theta)$, donde $X$ es el contexto, es decir, las variables aleatorias con las cuales se trabaja.

Como queremos los parámetros que mejor expliquen los datos, el objetivo es buscar $hat(theta)_"MLE"$, que es el estimador de máxima verosimilitud, es decir, el que maximiza la función $L$. Este parámetro entonces se define como:

$
  hat(theta)_"MLE" = arg max_(theta in Theta) L(theta bar X) = arg max_(theta in Theta) f(X bar theta)
$

#note-box[
  La función de verosimilitud es una función de $theta$, y no es una PDF porque no está normalizada, por lo tanto, no se puede usar para calcular probabilidades.
]

Tenemos que tener las siguientes consideraciones:

+ Necesitamos asumir una distribución, es decir, una función $f$.

+ Las variables aleatorias se asumen independientes e idénticamente distribuidas (i.i.d.). De esta forma, podemos escribir:

  $
    L(theta bar X) = f(X_1, X_2, dots, X_N bar theta) = product_(i=1)^N f(X_i bar theta)
  $

  que es un cálculo más simple.

Computacionalmente, es más fácil trabajar con el logaritmo de la función de verosimilitud, que se define como:

$
  ell(theta) = ln (L(theta)) = sum_(i=1)^N ln f(X_i bar theta)
$

Finalmente, como la función logaritmo conserva el valor maximizador, se cumple que:

$
  hat(theta)_"MLE" &= arg max_(theta in Theta) L(theta bar X) \
  &= arg max_(theta in Theta) ell(theta bar X)  \
  &= arg max_(theta in Theta) sum_(i=1)^N ln f(X_i bar theta)
$

#example-box(title: [Cálculo de $hat(lambda)_"MLE"$ con una distribución de Poisson.])[
  Tenemos una variable $X ~ Poisson(lambda)$. La función de verosimilitud es:

  $
    L(lambda bar X) &= product_(i=1)^N (lambda^(X_i) e^(-lambda))/(X_i !) \
    ell(lambda bar X) &= sum_(i=1)^N ln ((lambda^(X_i) e^(-lambda))/ (X_i !)) \
  $

  Aplicando propiedades de suma y resta de logaritmos, se obtiene:

  $
    ell(lambda bar X) &= ln(lambda) sum_(i=1)^N X_i - sum_(i=1)^N ln (X_i !) - N lambda \
  $

  El estimador de máxima verosimilitud se calcula mediante la condición de primer orden:

  $
    hat(lambda)_"MLE" &-> lr((partial ell (lambda))/(partial lambda)|)_(lambda = hat(lambda)_"MLE") = 0 \
    &<==> 1 / (hat(lambda)_"MLE") sum_(i=1)^N X_i - N = 0 \
    &<==> hat(lambda)_"MLE" = 1/N sum_(i=1)^N X_i = overline(X)
  $
]

#pagebreak(weak: true)

= Método de máxima verosimilitud

En el ejemplo anterior, no verificamos la condición de segundo orden para ver que efectivamente es un máximo global. Para verificar esto, se usa el hessiano:

$
  H_N (theta ; Y bar X) = (partial^2 ell (theta))/(partial theta theta^T)
$

Su estimador se calcula de la siguiente forma:

$
  hat(H) = lr(-(partial^2)/(partial theta^2) (1/N sum_(i=1)^N ln f(X_i bar theta))|)_(theta = hat(theta)_"MLE")
$

el cual tiene que ser definido negativo para asegurar la existencia de un máximo. De esta forma, se calculan los errores asociados a la estimación como sigue:

$
  "SE"(hat(theta)_"MLE") = sqrt(-(hat(H) dot N)^(-1)); quad "SE"(hat(theta)_"MLE") = sqrt([N dot I(hat(theta))]^(-1))
$

donde $I$ es la matriz de información de Fisher, que se define como:

$
  I(theta) = EE[(partial)/(partial theta) ln f(X bar theta)]^2
$

¿Es $hat(theta)_"MLE"$ un buen estimador? ¿Es insesgado? ¿Es consistente? ¿Cómo es su varianza? Esto depende de la elección de la función de verosimiliud $f$, como vemos en la matriz $I$.

== Condiciones de regularización

Recordemos que $L(theta)$ depende de la distribución conjunta de las variables y los parámetros.

- #underline[Condición R1]: Las primeras $3$ derivadas de $ln f(X bar theta)$ con respecto a $theta$ deben ser continuas y finitas para casi todo $x_i$ y $forall theta in Theta$. Esta condición asegura la existencia de ciertas expansiones de Taylor y que la varianza esa finita. 

  Cuando se cumple esta condición, se dice que el estimador $hat(theta)_"MLE"$ es asintóticamente insesgado, y como su varianza es finita y tiende a $0$, se dice que es consistente, por el teorema visto en la @caracterization-consistency.

- #underline[Condición R2]: Se tienen las condiciones necesarias para obtener la esperanza de la primera y segunda derivada de $ln f(X bar theta)$, es decir, se deben poder capturar los siguientes términos:

  $
    EE[(partial)/(partial theta) ln f(X bar theta)]; quad EE[(partial^2)/(partial theta theta^T) ln f(X bar theta)]
  $

  Con esto, podemos asegurar una convergencia en distribución a una normal, es decir:

  $
    & sqrt(N dot I(theta_0)) dot (hat(theta)_"MLE" - theta_0) ->_d normal(0,1) \
    & sqrt(N) dot (hat(theta)_"MLE" - theta_0) ->_d normal(0, -H^(-1)) \
  $
  
  donde $theta_0$ es el parámetro original (real), $hat(theta)_"MLE" - theta_0$ es la estimación del error MLE, y $-H^(-1)$ es el hessiano, la varianza asintótica.

- #underline[Condición R3]: Para todo parámetro $theta$, la siguiente función:

  $
    abs((partial^3 ln f(X bar theta))/(partial theta_i partial theta_j partial theta_k))
  $

  es menor que una función con esperanza finita. Esta condición permite truncar la expansión de Taylor, y permite demostrar que el estimador cumple la cota de Cramer-Rao, que se verá en la @cramer-rao.

Cuando se cumplen las condiciones R1, R2 y R3, se dice que $hat(theta)_"MLE"$ es eficiente, es decir, es el mejor estimador insesgado (BUE).

#note-box[
  Ser el mejor estimador insesgado (BUE) no significa ser el mejor estimador lineal insesgado (BLUE). La implicancia al revés tampoco es cierta. Para modelos lineales, conviene ocupar OLS, pero también se puede ocupar MLE.
]

#important-box[
  + MLE es un método de inferencia.

  + $hat(theta)_"MLE"$ es un buen estimador cuando se cumplen las condiciones de regularización.

  + Vamos a depender siempre de $f, X$ y $theta$.
]

=== Cota de Cramer-Rao <cramer-rao>

Sea $hat(theta)$ un estimador insesgado de $theta$. Entonces, se cumple que:

$
  var(hat(theta)) >= 1/(N dot I(theta))
$

== Criterios de información para evaluar ajuste

Los criterios de información son herramientas estadísticas que permiten evaluar la calidad de un modelo ajustado a los datos. Tenemos el AIC (_Akaike Information Criterion_) y el BIC (_Bayesian Information Criterion_). Ambos criterios buscan penalizar la complejidad del modelo, es decir, el número de parámetros estimados. La idea es que un modelo más complejo no necesariamente es mejor, y por lo tanto, se debe penalizar.

Estas métricas se definen de la siguiente forma:

$
  "AIC" &= 2k - 2 ln L \
  "BIC" &= k ln N - 2 ln L
$

donde $N$ es el número de datos, y $k$ el número de parámetros. Un AIC o BIC más alto es peor, y más bajo es mejor.

#important-box[
  Estas métricas se comparan siempre bajo un mismo modelo. Si tenemos dos modelos, donde el primero es de regresión lineal y el segundo de regresión polinomial, no podemos comparar las métricas (AIC, $log$-likelihood, BIC, etc.) entre ambos métodos, porque provienen de un modelo $f$ distinto.

  Por otro lado, si agrego más parámetros a un mismo modelo, por ejemplo, el de regresión lineal, entonces puedo comparar las métricas entre ambos modelos bajo dicha regresión. Esto es porque provienen del mismo modelo $f$.
]

== Uso aplicado de MLE

En esta sección, se verán $3$ ejemplos asociados al uso de MLE, realizando la estimación teórica de los parámetros de distintos modelos en casos aplicados.

#example-box(title: "Retención de clientes.")[
  Modelos en fuga (_churn_). Definimos $p$ como la probabilidad de que un cliente se fugue en el periodo $t$, y $T$ como la variable aleatoria que modela cuántos periodos permanece un cliente en la compañía. Entonces tendremos que:

  $
    PP(T=t bar p) &= (1-p)^(t-1) dot p \
    PP(T > t bar p) &= (1-p)^t
  $

  con $t in NN_0$. Para un modelo general, donde tenemos $N$ clientes, $M$ periodos, e $Y_t$ es la cantidad de clientes que se fueron en el periodo $t$, tendremos que:

  $
    N - sum_(i=1)^t Y_i
  $

  es la cantidad de clientes que permanecen en el periodo $t$.

  Entonces, para los $N$ clientes se cumple lo siguiente:
  
  $
    PP(T > t bar p) = [(1-p)^(t-1) dot p]^(Y_t) dot [(1-p)^t]^(N - sum_(i=1)^t Y_i)
  $

  y en particular, se define la función de verosimilitud como $L(p) = product_(t=1)^M PP(T > t bar p)$.

  Para encontrar la estimación del parámetro $p$ por MLE, es decir, $hat(p)_"MLE"$, primero calculamos la $log$-verosimilitud:

  $
    ell(p) &= sum_(t=1)^M ln [[(1-p)^(t-1) dot p]^(Y_t) dot [(1-p)^t]^(N - sum_(i=1)^t Y_i)] \
    &= sum_(t=1)^M Y_t ln[(1-p)^(t-1) dot p] + sum_(t=1)^M (N - sum_(i=1)^t Y_i) ln[(1-p)^t] \
    &= sum_(t=1)^M Y_t dot (t-1) dot ln(1-p) + sum_(t=1)^M Y_t ln p + sum_(t=1)^M (N - sum_(i=1)^t Y_i) dot t dot ln(1-p) \
    &= ln(1-p) dot [sum_(t=1)^M Y_t dot (t-1) + sum_(t=1)^M (N - sum_(i=1)^t Y_i) dot t] + ln p dot sum_(t=1)^M Y_t \ 
    &= ln(1-p) dot c_1 + ln p dot c_2
  $

  Este último paso es posible porque $c_1$ y $c_2$ no dependen de $p$, entonces se pueden ver como constantes en la derivada. De esta forma:

  $
    (partial ell(p))/(partial p) &= -c_1/(1-p) + c_2/p \
  $
  
  Esta derivada cumple el punto crítico en $p=hat(p)_"MLE"$, es decir:

  $
    hat(p)_"MLE" = (c_2)/(c_1 + c_2)
  $
]

#example-box(title: "Utilización de camas UCI.")[
  Vamos a modelar el tiempo de utilización de las camas UCI dentro de un hospital. Para ello, diremos que hay $M$ pacientes que ya desocuparon su cama UCI, y $N$ pacientes que aún están en la UCI. Acá tenemos "datos censurados", porque tenemos una foto de un instante de tiempo.

  Para modelar tiempo, se suele usar la variable aleatoria exponencial. Así, diremos que $X$ es el tiempo de estadía de una persona en la UCI (en días), con $X ~ exp(lambda)$. Las funciones de densidad de una exponencial son:

  $
    f(x) = lambda e^(-lambda x); quad F(x) = 1 - e^(-lambda x)
  $

  con $x >= 0$, y $lambda > 0$. La función de verosimilitud es la siguiente:

  $
    L(lambda) = [product_(m=1)^M lambda e^(-lambda X_(1,m))] dot [product_(n=1)^N (1-(1-e^(-lambda X_(2,n))))] \
  $

  donde los primeros $M$ términos corresponden a los pacientes que ya desocuparon la cama y estuvieron $X_(1,i)$ días ($i in {1, dots, M}$), y los $N$ términos que siguen corresponden a los pacientes que aún no se han ido, y no se sabe cuándo se van a ir, pero han estado al menos $X_(2,j)$ días $j in {1, dots, N}$. Por este motivo se ocupa el complemento.

  Acá, tenemos que la $log$-verosimilitud es:

  $
    ell(lambda) &= M dot ln lambda - lambda dot underbrace([sum_(m=1)^M X_(1,m) + sum_(n=1)^N X_(2,n)], S) \
    &= M dot ln lambda - S lambda
  $

  y así, aplicando condición de primer orden, se obtiene el estimador de máxima verosimilitud:

  $
    (partial ell(lambda))/(partial lambda) &= lr(M/lambda - S|)_(lambda = hat(lambda)_"MLE") = 0 \
    &<==> hat(lambda)_"MLE" = M/S
  $
]

#example-box(title: "Modelos de elección discreta: Multinomial Logit.")[
  McFadden, un economista, postuló que las personas son agentes racionales y toman la decisión que maximiza su función de utilidad. Entonces, si tenemos $N$ personas e $I$ alternativas, la función de utilidad se define como:

  $
    U_(n, i) = V_(n, i) + epsilon_(n, i); quad n in {1, dots, N}; quad i in {1, dots, I}
  $

  donde $epsilon_(n,i)$ son los factores no observables, y $V_(n,i)$ es la utilidad observada. La utilidad observada se define como:

  $
    V_(n, i) = beta_0 + beta_1 X_1 + dots + beta_k X_(k); quad n in {1, dots, N}; quad i in {1, dots, I}
  $

  Luego, definimos la variable aleatoria $Y_(n,i)$ como:

  $
    Y_(n,i) = cases(
      1 & "si la persona" n "elige la alternativa" i \
      0 & "en otro caso"
    )
  $

  Así, la probabilidad de que la persona $n$ escoja la alternativa $i$ es:

  $
    PP(Y_(n,i) = 1) &= PP(U_(n,i) >= U_(n,j)) & forall i != j \
    &= PP(V_(n,i) + epsilon_(n,i) >= V_(n,j) + epsilon_(n,j)) & forall i != j \
    &= PP(V_(n,i) + epsilon_(n,i) - V_(n,j) >= epsilon_(n,j)) & quad forall i != j \
  $

  Para calcular esta probabilidad, necesitamos una distribución para $epsilon_(n,j)$. La más común es la de Gumbel, o valor extremo tipo $1$, que se define como:
  
  $
    f(epsilon_(i,j)) = e^(-epsilon_(i,j)) e^(-e^(-epsilon_(i,j))); quad F(epsilon_(i,j)) = e^(-e^(-epsilon_(i,j)))
  $

  Con esta distribución, la probabilidad de que la persona $n$ escoja la alternativa $i$ es:

  $
    PP(V_(n,i) + epsilon_(n,i) - V_(n,j) >= product_(j != i) e^(-e^(-epsilon_(n, i) + V_(n,i) - V_(n,j)))) &= integral [product_(j != i) e^(-e^(-epsilon_(n, i) + V_(n,i) - V_(n,j)))] dot f(epsilon_(i,j)) dif epsilon_(i,j) \
    &= (e^(V_(n,i)))/(sum_(j=1)^I e^(V_(n,j))) \
  $

  Cuando existen dos alternativas, se habla de un modelo binomial _logit_, que se usa en regresión logística. En este caso, la probabilidad de que la persona $n$ escoja la alternativa $i$ es:

  $
    PP(Y_(n,i) = 1) = (e^(V_(n,i)))/(1 + e^(V_(n,i))) \
  $
]