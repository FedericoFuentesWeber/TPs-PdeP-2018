{-# LANGUAGE NoMonomorphismRestriction #-}
import Text.Show.Functions
import Data.List
import Data.Maybe
import Test.Hspec

ejecutarTests = hspec $ do --1 a 10
 describe "Eventos: Cosas que pasan con una billetera de 10 monedas" $ do
  it "Depósito 10 monedas, ahora tiene 20 monedas" $ depósito 10 10 `shouldBe` 20
  it "Extrajo 3 monedas, ahora tiene 7 monedas" $ extracción 3 10 `shouldBe` 7
  it "Extrajo 15 monedas, ahora tiene 0 monedas" $ extracción 15 10 `shouldBe` 0
  it "Tuvo un upgrade, ahora tiene 12 monedas" $ upgrade 10 `shouldBe` 12
  it "Cuenta cerrada, no quedaron ni mariposas" $ cierreDeCuenta 10 `shouldBe` 0
  it "No hubo cambios, sigue con 10 monedas" $ quedaIgual 10 `shouldBe` 10
  it "Depósito 1000 monedas y tuvo un upgrade, ahora tiene 1020" $ (upgrade.depósito 1000) 10 `shouldBe` 1020
  it "Pepe tiene 10 monedas en su billetera" $ billetera pepe `shouldBe` 10
  it "Se cierra la cuenta de pepe y queda en 0" $ (cierreDeCuenta.billetera)pepe `shouldBe` 0
  it "A pepe se le depositan 15, se extraen 2 y tiene un upgrade, la billetera deberia ser 27.6" $ (upgrade.extracción 2.depósito 15.billetera) pepe `shouldBe` 27.6
 describe "Transacciones" $ do --11 a 15
  it "Se aplica la transacción 1 a pepe y el evento devuelto a una billetera de 20 que queda igual" $ transacción1 pepe 20 `shouldBe` 20
  it "Se aplica la transacción 2 a pepe y el evento devuelto a una billetera de 10 que queda en 15" $ transacción2 pepe 10 `shouldBe` 15
  it "Se aplica la transacción 2 a pepe2 y el evento devuelto a una billetera de 50 que queda en 55" $ transacción2 pepe2 50 `shouldBe` 55
  it "Se aplica la transacción 3 a lucho y el evento devuelto a una billetera de 10 que qeuda en 0" $ transacción3 lucho 10 `shouldBe` 0
  it "Se aplica la transacción 4 a lucho y el evento devuelto a una billetera de 10 que queda en 34" $ transacción4 lucho 10 `shouldBe` 34
 describe "Pago entre usuarios" $ do --16 a 17
  it "Se aplica la transacción 5 a pepe y el evento devuelto a una billetera de 10 que queda en 3" $ transacción5 pepe 10 `shouldBe` 3
  it "Se aplica la transacción 5 a lucho y el evento devuelto a una billetera de 10 que queda en 17" $ transacción5 lucho 10 `shouldBe` 17
 describe "Usuario luego de la transacción" $ do --18 a 20
  it "Se aplica la transacción 1 a pepe y se muestra que este queda igual" $ aplicarTransacciónAUsuario transacción1 pepe `shouldBe` pepe
  it "Se aplica la transacción 5 a lucho y se muestra que queda con 9 monedas" $ billetera (aplicarTransacciónAUsuario transacción5 lucho) `shouldBe` 9
  it "Se aplica la transacción 5 y luego la 2 a lucho y muestra que queda con 8 monedas" $ billetera ((aplicarTransacciónAUsuario transacción2.aplicarTransacciónAUsuario transacción5) pepe) `shouldBe` 8
 describe "Test con bloques" $ do --21 a 24
  it "Se aplica el bloque 1 a pepe y su billetera queda en 18" $ billetera (aplicarUsuarioBloque pepe bloque1) `shouldBe` 18
  it "Se aplica el bloque 1 a pepe y lucho, pepe es el unico con crédito mayor a 10" $ head (billeterasMayoresADespuesDeUnBloque 10 bloque1 conjuntoUsuarios) `shouldBe` pepe
  it "Se aplica el bloque 1 a pepe y lucho, pepe es el mas adinerado" $ head (usuarioMasAdineradoDespuesDeUnBloque bloque1 conjuntoUsuarios) `shouldBe` pepe
  it "Se aplica el bloque 1 a pepe y lucho, lucho es el menos adinerado" $ head (usuarioMenosAdineradoDespuesDeUnBloque bloque1 conjuntoUsuarios) `shouldBe` lucho
 describe "Test con block chains" $ do --25 a 29
  --it "Se aplica el block chain a pepe y se muestra que el bloque 1 es el que peor lo deja con 18 monedas" $ head (peorBloque pepe blockChain) `shouldBe` bloque1
  it "Se aplica el block chain a pepe y este queda con 115 monedas" $ billetera (aplicarUsuarioBlockChain pepe blockChain) `shouldBe` 115
  it "Aplicando los primeros 3 bloques del block chain pepe queda con 51 monedas" $ billetera (billeteraEnPosicionN 3 pepe blockChain) `shouldBe` 51
  it "Se aplica el block chain a un conjunto de usuarios y la sumatoria de billeteras da 115" $ sum ( map billetera ( aplicarBlockChainAConjuntoUsuarios blockChain conjuntoUsuarios )) `shouldBe` 115
  it "Se aplica el block chain infinito y a los 11 bloques pepe queda con 10000 monedas" $ bloquesNecesariosParaLlegar 10000 pepe (blockChainInfinita bloque1) 0 `shouldBe` 11

data Usuario = Usuario{
  nombre :: String,
  billetera :: Float
} deriving(Show, Eq)

type Billetera = Float
type Evento = Billetera -> Billetera
type Transacción = Usuario -> Evento -> Usuario -> Evento
type Bloque = [Transacción]
--Al hacer BlockChain = [[Transacción]] o [Bloque] marca error
type BlockChain = [[Usuario -> Evento]]
type ConjuntoDeUsuarios = [Usuario]

pepe = Usuario "José" 10
pepe2 = Usuario "José" 20
lucho = Usuario "Luciano" 2

depósito :: Billetera -> Evento
depósito = (+)

extracción :: Billetera -> Evento
extracción dineroAExtraer unaBilletera = max (unaBilletera - dineroAExtraer) 0

upgrade :: Evento
upgrade unaBilletera = depósito (min (unaBilletera * 0.2) 10) unaBilletera

cierreDeCuenta :: Evento
cierreDeCuenta _ = 0

quedaIgual :: Evento
quedaIgual = id

--Transacciones

mismoUsuario :: Usuario -> Usuario -> Bool
mismoUsuario unUsuario otroUsuario = (nombre unUsuario) == (nombre otroUsuario)

transacción :: Transacción --Usuario -> Evento -> Usuario -> Evento
transacción usuarioDeseado unEvento unUsuario
 |mismoUsuario usuarioDeseado unUsuario = unEvento
 |otherwise = quedaIgual

pagoEntreUsuarios :: TransacciónCompleja --Usuario -> Billetera -> Usuario -> Usuario -> Evento
pagoEntreUsuarios elQuePaga dineroAduedado elQueRecibe unUsuario
 |mismoUsuario elQuePaga unUsuario = (extracción dineroAduedado)
 |mismoUsuario elQueRecibe unUsuario = (depósito dineroAduedado)
 |otherwise = quedaIgual

tocoYMeVoy = cierreDeCuenta.upgrade.depósito 15
ahorranteErrante = depósito 10.upgrade.depósito 8.extracción 1.depósito 2.depósito 1

transacción1 = transacción lucho cierreDeCuenta
transacción2 = transacción pepe (depósito 5)
transacción3 = transacción lucho tocoYMeVoy
transacción4 = transacción lucho ahorranteErrante
transacción5 = pagoEntreUsuarios pepe 7 lucho

--Parte 2

nuevaBilletera dinero unUsuario = unUsuario { billetera = dinero }

--aplicarTransacciónAUsuario :: Transacción -> Usuario -> Usuario
aplicarTransacciónAUsuario transaccion usuario = nuevaBilletera (transaccion usuario (billetera usuario)) usuario

--Se usa composición, point free y orden superior
listaRepetida x = (replicate x)

conjuntoUsuarios = [pepe, lucho]
bloque1 = [transacción1, transacción2, transacción2, transacción2, transacción3, transacción4, transacción5, transacción3]
bloque2 = listaRepetida 5 transacción2

blockChain :: Blockchain
blockChain = [bloque2] ++ (listaRepetida 10 bloque1)


aplicarUsuarioBloque = foldl (flip aplicarTransacciónAUsuario)

aplicarBloqueAConjuntoUsuarios bloque = map (flip aplicarUsuarioBloque bloque)

billeteraSegunCriterio criterio bloque = criterio.billetera.(flip aplicarUsuarioBloque bloque)

billeterasMayoresADespuesDeUnBloque n bloque = filter (billeteraSegunCriterio (>=n) bloque)
billeterasMenoresADespuesDeUnBloque n bloque = filter (billeteraSegunCriterio (<=n) bloque)

--mejorSegun funcion listaElementos = fromJust (find funcion listaElementos)

usuarioMasAdineradoDespuesDeUnBloque bloque usuarios = billeterasMayoresADespuesDeUnBloque (billetera (head usuarios)) bloque usuarios
usuarioMenosAdineradoDespuesDeUnBloque bloque usuarios = billeterasMenoresADespuesDeUnBloque (billetera (head usuarios)) bloque usuarios

--point free, orden superior
aplicarUsuarioBlockChain :: Usuario -> Blockchain -> Usuario
aplicarUsuarioBlockChain usuario = (aplicarUsuarioBloque usuario).concat

--Hacerla con funciones mejorSegun y peorSegun
peorBloque usuario [] = []
peorBloque usuario (bloqueCabeza:[]) = bloqueCabeza
peorBloque usuario (bloqueCabeza:bloqueCola)
 |(billetera.aplicarUsuarioBloque usuario) bloqueCabeza <= (billetera. aplicarUsuarioBloque usuario) (head bloqueCola) = bloqueCabeza
 |otherwise = peorBloque usuario bloqueCola

billeteraEnPosicionN n usuario cadenaBloque
 |n < length cadenaBloque = (aplicarUsuarioBlockChain usuario.take n) cadenaBloque
 |otherwise = aplicarUsuarioBlockChain usuario cadenaBloque

--Recursividad, point free, orden superior
aplicarBlockChainAConjuntoUsuarios cadenaBloque = map (flip aplicarUsuarioBlockChain cadenaBloque)

--se usa recursividad
blockChainInfinita bloque = bloque : blockChainInfinita (bloque ++ bloque)

--se usan conceptos de recursividad, orden superior, evaluación diferida
bloquesNecesariosParaLlegar valorDeseado usuario (bloqueCabeza:bloqueCola) cantidadTotal
 |(billetera. aplicarUsuarioBloque usuario) bloqueCabeza >= valorDeseado = (cantidadTotal + 0)
 |otherwise = bloquesNecesariosParaLlegar valorDeseado usuario bloqueCola (cantidadTotal +1)
