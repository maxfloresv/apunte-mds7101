#import "utils/template.typ": *
#import "utils/variables.typ": *
#import "utils/packages.typ": *

#page(
  paper: "us-letter",
  header: none,
  footer: none,
  margin: 0pt,
  image("images/cover.svg")
)

#show: outline-rules

#outline()

#show: main-rules

= Semana 1: Repaso de probabilidades.

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

== Correlación de dos variables aleatorias.

Es una estandarización de la covarianza, para tener resultados interpretables en el rango $[-1, 1]$. Se calcula de la siguiente forma:

$
  corr(X, Y) = (cov(X, Y))/sqrt(var(X) dot var(Y)) = rho(X, Y)
$

= Semana 2: Repaso de probabilidad

- Cuando decimos $corr(X,Y) = 0$, quiere decir que no hay información sobre la relación lineal entre $X$ e $Y$. Esto no quiere decir que $X$ e $Y$ sean independientes, porque pueden tener un tipo de relación no lineal, por ejemplo, cuadrática.

  - Ejemplo: Sea $X ~ "U"[-1, 1]$ e $Y = X^2$, con $"U"(a,b)$ una distribución uniforme. Como los momentos de una variable $Z$ que distribuye uniformemente en el intervalo $(a, b)$ se calculan mediante la expresión:

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

== Inferencia estadística

#definition-box[
  La inferencia estadística es una rama de la estadística que se encarga de hacer #keyword[predicciones] o #keyword[caracterizaciones] sobre una población a partir de una muestra.
]

Normalmente, habrá una variable $Y ~ f(X)$, con $f$ una función genérica llamada #keyword[modelo], que encuentra una relación. $Y$ se llama #keyword[variable endógena], porque depende de $X$. Será la variable que estudiaremos. Por otro lado, $X$ se llama #keyword[variable exógena], porque en el mundo ideal no dependen de nada.

Haremos un estudio de $X$, con una sola variable. Por ejemplo, sea $Y := "demanda por poleras"$, y $X := "tallas" ("estaturas")$. En Chile, podríamos decir que el promedio de estatura en hombres es $overline(x)_H = "1.73 m"$ y en mujeres es $overline(x)_M = "1.58 m"$. Diremos que el mínimo es $"1 m"$, y el máximo es $"2.5 m"$.

Podemos decir que las estaturas distribuyen como una variable aleatoria normal, es decir, $X ~ normal(mu, sigma^2)$, porque usualmente las concentraciones de estaturas toman esta forma por naturaleza.

== Estimadores

En el caso anterior, no podemos conocer ni $mu$ ni $sigma$. Como habrán casos donde esto suceda, necesitamos instrumentos que "aproximen" estos valores para poder hacer la inferencia:

$
  overline(x) = 1/N dot sum_(i=1)^N x_i
$

- *¿Por qué nos gusta el promedio?* El promedio cumple con las siguientes propiedades, que hacen que sea una mejor medición estadística:

  + Insesgadez. Sea $T(X)$ estimador del parámetro $theta$. $T(X)$ es insesgado si $EE[T(X)] = theta$. Esto significa que su valor esperado está completamente centrado en el parámetro que estoy buscando. Esta propiedad la cumple el promedio:

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

    Queremos que la varianza sea lo más cercana a cero posible, porque esto hace que el estimador esté concentrado en el valor central. Lo malo del resultado obtenido con el promedio, es que si $N$ es muy grande, no podré estimar $sigma$ (que sigue siendo desconocido), porque $N$ tiene influencias en el resultado al estar dividiendo.

    De esto, nace la necesidad de buscar un estimador insesgado de $sigma^2$. Se define como sigue:

    $
      S^2 = 1/(N-1) dot sum_(i=1)^N (X_i - overline(X))^2
    $

    De esta forma, ya tenemos una estimación de $sigma^2$, por lo tanto, podemos decir que $var(overline(X)) = S^2\/N$ con un error $std(overline(X)) = sqrt(S^2\/N)$.

=== Muestra aleatoria

Para hacer las estimaciones, tomamos muestras aleatorias independientes e idénticamentte distribuidas (en adelante, i.i.d.). Así, la observación $i$ no depende de la $j$, y todas vienen de la misma distribución. En el curso trabajaremos sólo con distribuciones i.i.d., salvo que se diga lo contrario.

== Intervalos de confianza

Se anotan como $"IC"(overline(X))$, $"CI"(overline(X))$ o $"C"(overline(X))$, y corresponden a un rango de valores que con cierta probabilidad contienen al parámetro de interés $theta$. Lo importante es notar que el parámetro de interés está fijo, lo que varía es justamente el intervalo de confianza.

$
  "C"(overline(X)) = overline(X) plus.minus Z_alpha dot std(overline(X))
$

El valor $Z_alpha$ es el que escojo para que con "$alpha$" nivel de confianza $mu in "C"(X)$. 

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
    Z = (overline(X) - mu)/sqrt(sigma^2\/N) \/ (((N-1) dot S^2/sigma^2)\/ (N-1))^(1/2)
  $

  Ya sabemos que $(overline(X)-mu)\/sqrt(sigma^2\/N) ~ normal(0, 1)$. Nos falta estimar el resto. Desarrollando:

  $
    (N-1) dot S^2/sigma^2 = 1/(N-1) sum_(i=1)^N [(X_i - overline(X))^2] dot (N-1)/sigma^2 = sum_(i=1)^N ((X_i - overline(X))/(sigma))^2
  $

  y además, $(X_i - overline(X))\/sigma ~ normal(0,1)$, entonces $(N-1) dot S^2\/sigma^2 ~ chi^2_[N-1]$, pues es una normal al cuadrado con $N-1$ grados de libertad (como son i.i.d., su suma sigue distribuyendo $chi^2$ con la suma de todos sus grados de libertad). Finalmente, todo el denominador de la expresión conveniente para $Z$ distribuye como una $t$-Student de $N-1$ grados de libertad, ocupando la definición de esta variable aleatoria.

