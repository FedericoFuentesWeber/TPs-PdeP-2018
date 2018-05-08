{-# LANGUAGE NoMonomorphismRestriction #-}
import Text.Show.Functions
import Data.List
import Data.Maybe
import Test.Hspec

ejecutarTests = hspec $ do
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
 describe "Transacciones" $ do
  it "Se aplica la transacción 1 a pepe y el evento devuelto a una billetera de 20 que queda igual" $ transacción1 pepe 20 `shouldBe` 20
  it "Se aplica la transacción 2 a pepe y el evento devuelto a una billetera de 10 que queda en 15" $ transacción2 pepe 10 `shouldBe` 15
  it "Se aplica la transacción 2 a pepe2 y el evento devuelto a una billetera de 50 que queda en 55" $ transacción2 pepe2 50 `shouldBe` 55
  it "Se aplica la transacción 3 a lucho y el evento devuelto a una billetera de 10 que qeuda en 0" $ transacción3 lucho 10 `shouldBe` 0
  it "Se aplica la transacción 4 a lucho y el evento devuelto a una billetera de 10 que queda en 34" $ transacción4 lucho 10 `shouldBe` 34
 describe "Pago entre usuarios" $ do
  it "Se aplica la transacción 5 a pepe y el evento devuelto a una billetera de 10 que queda en 3" $ transacción5 pepe 10 `shouldBe` 3
  it "Se aplica la transacción 5 a lucho y el evento devuelto a una billetera de 10 que queda en 17" $ transacción5 lucho 10 `shouldBe` 17
 describe "Usuario luego de la transacción" $ do
  it "Se aplica la transacción 1 a pepe y se muestra que este queda igual" $ aplicarTransacciónAUsuario transacción1 pepe `shouldBe` pepe
  it "Se aplica la transacción 5 a lucho y se muestra que queda con 9 monedas" $ aplicarTransacciónAUsuario transacción5 lucho `shouldBe` Usuario {nombre = "Luciano", billetera = 9}
  it "Se aplica la transacción 5 y luego la 2 a lucho y muestra que queda con 8 monedas" $ (aplicarTransacciónAUsuario transacción2.aplicarTransacciónAUsuario transacción5) pepe `shouldBe` Usuario {nombre = "José", billetera = 8}
 describe "Test con bloques" $ do
  it "Se aplica el bloque 1 a pepe y su billetera queda en 18" $ foldl (flip aplicarTransacciónAUsuario) pepe bloque1 `shouldBe` Usuario {nombre = "José", billetera = 18}
  it "Se aplica el bloque 1 a pepe y lucho, pepe es el unico con crédito mayor a 10" $ aplicarTransacciónAUsuario transacción6 (head (filtroUsuarios 10 bloque1 conjuntoUsuarios)) `shouldBe` Usuario {nombre = "José", billetera = 10}
  it "Se aplica el bloque 1 a pepe y lucho, pepe es el mas adinerado" $ aplicarTransacciónAUsuario transacción6 (plataSegun (>=). mapBloque bloque1 $ conjuntoUsuarios) `shouldBe` Usuario {nombre = "José", billetera = 10}
  it "Se aplica el bloque 1 a pepe y lucho, lucho es el menos adinerado" $ aplicarTransacciónAUsuario transacción7 (plataSegun (<=). mapBloque bloque1 $ conjuntoUsuarios) `shouldBe` Usuario {nombre = "Luciano", billetera = 2}
 describe "Test con block chains" $ do
 it "Se aplica el block chain a pepe y se muestra que el bloque 1 es el que peor lo deja con 18 monedas" $ aplicarUsuarioBloque pepe (peorBloque pepe blockChain) `shouldBe` Usuario {nombre = "José", billetera = 18}
 it "Se aplica el block chain a pepe y este queda con 115 monedas" $ aplicarUsuarioBlockChain pepe blockChain `shouldBe` Usuario {nombre = "José", billetera = 115}
 it "Aplicando los primeros 3 bloques del block chain pepe queda con 51 monedas" $ billeteraEnPosicionN 3 pepe blockChain `shouldBe` Usuario {nombre = "José", billetera = 51}
 it "Se aplica el block chain a un conjunto de usuarios y la sumatoria de billeteras da 115" $ sum ( map billetera ( mapBlockChain blockChain conjuntoUsuarios )) `shouldBe` 115
 it "Se aplica el block chain infinito y a los 11 bloques pepe queda con 10000 monedas" $ (aplicarUsuarioBlockChain pepe. take 11) (blockChainInfinita bloque1) `shouldBe` Usuario {nombre = "José", billetera = 16386}

data Usuario = Usuario{
  nombre :: String,
  billetera :: Float
} deriving(Show, Eq)

type Billetera = Float
type Evento = Billetera -> Billetera
type Transacción = Usuario -> Evento -> Usuario -> Evento
type Bloque = [Usuario -> Evento]
type BlockChain = [[Usuario -> Evento]]

pepe = Usuario "José" 10
pepe2 = Usuario "José" 20
lucho = Usuario "Luciano" 2

depósito :: Billetera -> Evento
depósito dineroADepositar = (+) dineroADepositar

extracción :: Billetera -> Evento
extracción dineroAExtraer unaBilletera = max (unaBilletera - dineroAExtraer) 0

upgrade :: Evento
upgrade unaBilletera
 |unaBilletera * 0.2 < 10 = unaBilletera * 1.2
 |otherwise = unaBilletera + 10

cierreDeCuenta :: Evento
cierreDeCuenta unaBilletera = unaBilletera - unaBilletera

quedaIgual :: Evento
quedaIgual unaBilletera = unaBilletera

--Transacciones

transacción :: Transacción
transacción unUsuario unEvento otroUsuario
 |nombre unUsuario == nombre otroUsuario = unEvento
 |otherwise = quedaIgual

pagoEntreUsuarios :: Usuario -> Billetera -> Usuario -> Usuario -> Evento
pagoEntreUsuarios deudor dineroAduedado acreedor usuario
 |nombre usuario == nombre deudor = (extracción dineroAduedado)
 |otherwise = transacción acreedor (depósito dineroAduedado) usuario

tocoYMeVoy = cierreDeCuenta.upgrade.depósito 15
ahorranteErrante = depósito 10.upgrade.depósito 8.extracción 1.depósito 2.depósito 1
transacción1 = transacción lucho cierreDeCuenta
transacción2 = transacción pepe (depósito 5)
transacción3 = transacción lucho tocoYMeVoy
transacción4 = transacción lucho ahorranteErrante
transacción5 = pagoEntreUsuarios pepe 7 lucho
transacción6 = transacción pepe (extracción 8)
transacción7 = transacción lucho (depósito 2)

--Parte 2

aplicarTransacciónAUsuario transacción usuario = usuario {billetera = transacción usuario (billetera usuario)}

bloque1 = [transacción1, transacción2, transacción2, transacción2, transacción3, transacción4, transacción5, transacción3]
conjuntoUsuarios = [pepe, lucho]

aplicarUsuarioBloque = foldl (flip aplicarTransacciónAUsuario)
mapBloque bloque = map (flip aplicarUsuarioBloque bloque)

filtroUsuarios n bloque = filter ((>=n).billetera).mapBloque bloque
usuarioMasAdinerado bloque listaUsuarios = maximum.map billetera.mapBloque bloque $ listaUsuarios

plataSegun :: (Billetera -> Billetera -> Bool) -> [Usuario] -> Usuario
plataSegun _ [x] = x
plataSegun funcion (x:xs)
 |funcion (billetera x) (billetera (plataSegun funcion xs)) = x
 |otherwise = plataSegun funcion xs

bloque2 = [transacción2,transacción2,transacción2,transacción2,transacción2]
blockChain = [bloque2, bloque1, bloque1, bloque1, bloque1, bloque1, bloque1, bloque1, bloque1, bloque1, bloque1]

aplicarUsuarioBlockChain :: Usuario -> BlockChain -> Usuario
aplicarUsuarioBlockChain = foldl aplicarUsuarioBloque

peorBloque usuario (bloqueCabeza:bloqueCola)
 |(billetera.aplicarUsuarioBloque usuario) bloqueCabeza <= (billetera. aplicarUsuarioBloque usuario) (head bloqueCola) = bloqueCabeza
 |otherwise = peorBloque usuario bloqueCola

billeteraEnPosicionN :: Int -> Usuario -> BlockChain -> Usuario
billeteraEnPosicionN n usuario cadenaBloque
 |n < length cadenaBloque = (aplicarUsuarioBlockChain usuario.take n) cadenaBloque
 |otherwise = aplicarUsuarioBlockChain usuario cadenaBloque

mapBlockChain cadenaBloque = map (flip aplicarUsuarioBlockChain cadenaBloque)

duplicarBloque bloque = (concat.replicate 2)bloque
blockChainInfinita bloque = iterate duplicarBloque bloque
