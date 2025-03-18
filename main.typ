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

=== Distribuciones continuas

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

=== Covarianza de dos variables aleatorias

Medida de cómo en promedio varían linealmente dos variables aleatorias entre sí.

$
  cov(X,Y) &= EE[(X-EE(X))(Y-EE(Y))] \
  &= EE(X Y)-EE(X)EE(Y)
$

Si estas variables $X, Y$ son independientes, entonces su covarianza será cero, pues $EE[X Y] = EE[X] dot EE[Y]$ por la propiedad heredada de la esperanza.

#warning-box[La implicancia $cov(X, Y) = 0 => X, Y "son independientes"$ es falsa, y es un error muy común asumir que es cierta.] 
=== Correlación de dos variables aleatorias.

Es una estandarización de la covarianza, para tener resultados interpretables en el rango $[-1, 1]$. Se calcula de la siguiente forma:

$
  corr(X, Y) = (cov(X, Y))/sqrt(var(X) dot var(Y)) = rho(X, Y)
$