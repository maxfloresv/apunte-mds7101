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

#definition[
  Se dice que $X$ es una v. a. discreta si toma valores de un conjunto finito, o infinito numerable, y además $forall x$, $PP(X=x) != 0$.
]

=== Variables aleatorias continuas

#definition[
  Se dice que $X$ es una v. a. continua si $X$ toma cualquier valor real con probabilidad cero, es decir, $forall x, PP(X=x) = 0$.
]

=== Funciones de densidad

Existen dos funciones de densidad.

- PDF: _Probability Density Function_ ($f(x)$).

- CDF: _Cummulative Density Function_ ($F(x)$).

Estas funciones están directamente relacionadas mediante la fórmula $F(x) = integral_(-infinity)^(x) f(x) dif x$, lo que puede ser observado gráficamente en la @fig-pdf-cdf.

#figure(
  caption: [Funciones "PDF" ($f(x)$) y "CDF" ($F(x)$).],
  image("images/classes/pdf_cdf.svg")
) <fig-pdf-cdf>

=== Varianza de una variable aleatoria

Definimos la varianza de una variable aleatoria discreta como:

$
  var(X) = EE[(X-EE[X])^2]
$

Mientras que para las variables aleatorias continuas se tiene:

$
  var(X) = integral_RR_X (X-EE(X))^2 dot f(x) dif x
$

Con esto mismo podemos definir la desviación estándar de una variable aleatoria, la cual viene a ser la raíz cuadrada de la varianza de esta, se le conoce también como $sigma$ o #std[$X$].

=== Estandarización de una variable aleatoria
Sea $X$ una variable aleatoria, se define la variable $Z=(X-mu)\/sigma$ con $mu = EE[X]$ y $sigma = sqrt(var(X))$. Se dice que $Z$ es la estandarización de $X$, pues cumple $EE[Z] = 0$ y $var(Z) = 1$.

#warning-box[
  En algunas librerías de programación, la "estandarización" de una v. a. se considera como su "normalización", pero estos términos no son equivalentes.
]

== Distribuciones discretas
- *Bernoulli*: Cuando queremos lanzar una moneda una sola vez.
$
X ~ "Bernoulli"(p)\
X= cases(1 "si es exitoso.",0 "si fracasa.")\
PP(X=1)=p and PP(X=0)=1-p
$
Si se realiza el experimento multiples veces, se define otra distribución.

*Binomial*: 
$
X ~ "Binomial"(p,n)\
PP(X=k)= binom(n,k) dot p^k dot (1-p)^(n-k)\
EE(X)=n p\
VV"ar"(X)=n p dot (1-p)
$
Si $p$ es un vector multivariado, se transforma en una distribución multinomial.
Es decir 
$
p=(x_0,...,x_n) -> "Multinomial"
$

Con esto tenemos algunas distribuciones más comunes.
=== Distribuciones continuas
*Normal*
$
X ~ #normal (mu, sigma^2) \
f(x)=1/(sqrt(2 pi sigma^2)) e^(-((x-mu)/(2 sigma^2)))
$
- *Normal estándar*: Si $X$ es $normal(mu, sigma^2)$ y $Z=(X-mu)/omega$ entonces $Z ~ normal(0,1)$.
- *Chi cuadrado $chi^2$*: Si $Z~cal(N)(0,1)$ entonces 
  $
  Y=Z^2=> Y~Chi^2_[1]
  $
- $t$-Student. Sea $Z ~ normal(0,1)$ e $Y~Chi^2_[n]$. Entonces definimos T-Student como:
  $
  t= Z/sqrt(Y\/n) ~ t_[n]
  $
- *Fischer*: Combinamos dos *$Chi^2$* independientes.
  $
  X_1~Chi_[n_1]^2 and X_2~Chi_[n_2]^2\
  F=(X_1\/n_1)/(X_2\/n_2)~F_(n_1,n_2)
  $
=== Covarianza de dos variables aleatorias.

Medida de como en promedio varían linealmente dos variables aleatorias entre sí.

$
  cov(X,Y) &= EE[(X-EE(X))(Y-EE(Y))] \
  &= EE(X Y)-EE(X)EE(Y)
$

Si estas variable son independientes, entonces su covarianza será cero y su correlación también es cero, pero no puedo asumir que son independientes si la correlación es cero.

=== Correlación de dos variables aleatorias.

$
  corr(X, Y) = (cov(X, Y))/sqrt(var(X) dot var(Y)) = rho(X, Y)
$

Ojo: Correlación en cero no implica que serán variables aleatorias independientes, un caso clave para esto es de que estas estén relacionadas de forma no lineal (por verse en clases).

#let circled_numbering = (n) => {
  let circled_numbers = ("①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", "⑨")
  if n >= 1 and n < 10 {
    circled_numbers.at(n - 1)
  } else {
    [#n.]
  }
}

#set enum(numbering: circled_numbering)

1. Hola

+ Hola qué tal

+

