{-# LANGUAGE NoMonomorphismRestriction #-}
import Text.Show.Functions
import Data.List
import Data.Maybe
import Test.Hspec

data Usuario = Usuario{
  nombre :: String,
  billetera :: Float,
  nivel :: Int
} deriving(Show)

rodrigo = Usuario "Rodrigo" 10 0
pepe = Usuario "José" 10 0
lucho = Usuario "Luciano" 2 0

sumarDinero usuario dinero = (billetera usuario) + dinero
depósito usuario dineroDepositado = usuario{ billetera = sumarDinero usuario dineroDepositado}

restarDinero usuario dinero = (billetera usuario) - dinero
extracción usuario dineroExtraido
 |restarDinero usuario dineroExtraido > 0 = usuario{ billetera = restarDinero usuario dineroExtraido}
 |otherwise = usuario{ billetera = 0}
 
subirUnNivel usuario = (nivel usuario) + 1
upgrade usuario
 |billetera usuario <= 50 = usuario{ billetera = (billetera usuario) * 1.20, nivel = subirUnNivel usuario}
 |billetera usuario > 50 = usuario{ billetera = sumarDinero usuario 10, nivel = subirUnNivel usuario}

cierreDeCuenta usuario = usuario{ billetera = 0}

quedaIgual usuario = usuario

luchoCierraCuenta usuario
  |nombre usuario == "Luciano" = cierreDeCuenta usuario
  |nombre usuario != "Luciano" = quedaIgual usuario

  pepeDeposita usuario monedas
  |nombre usuario == "José" = depósito usuario monedas
  |nombre usuario != "José" = quedaIgual usuario

  
tocoYMeVoy usuario = cierreDeCuenta.upgrade.(depósito usuario 15)
ahorranteErrante usuario = (depósito (upgrade.depósito (extracción (depósito (depósito usuario 1) 2) 1) 8) 10)

luchoTocaYSeVa usuario
 |nombre usuario == "Luciano" = tocoYMeVoy usuario
 |nombre usuario != "Luciano" = quedaIgual usuario

luchoEsUnAhorranteErrante usuario
 |nombre usuario == "Luciano" = ahorranteErrante usuario
 |nombre usuario != "Luciano" = quedaIgual usuario

ejecutarTests = hspec $ do
 describe "Eventos: Cosas que pasan con una billetera de 10 monedas" $ do
  it "Depósito 10 monedas, ahora tiene 20 monedas" $ (billetera (depósito rodrigo 10)) `shouldBe` 20
  it "Extrajo 3 monedas, ahora tiene 7 monedas" $ (billetera (extracción rodrigo 3)) `shouldBe` 7
  it "Extrajo 15 monedas, ahora tiene 0 monedas" $ (billetera (extracción rodrigo 15)) `shouldBe` 0
  it "Tuvo un upgrade, ahora tiene 12 monedas" $ (billetera (upgrade rodrigo)) `shouldBe` 12
  it "Cuenta cerrada, no quedaron ni mariposas" $ (billetera (cierreDeCuenta rodrigo)) `shouldBe` 0
  it "No hubo cambios, sigue con 10 monedas" $ (billetera (quedaIgual rodrigo)) `shouldBe` 10
  it "Depósito 1000 monedas y tuvo un upgrade, ahora tiene 1020" $ ((billetera.upgrade.depósito rodrigo) 1000) `shouldBe` 1020
 describe "Usuarios: Casos con Pepe y Lucho" $ do 
  it "Pepe tiene 10 monedas" $ (billetera pepe) `shouldBe` 10
  it "A pepe le cierran la cuenta entonces queda con 0 monedas" $ (billetera (cierreDeCuenta pepe)) `shouldBe` 0
  it "A pepe le depositan 15 monedas, extrae 2 y recibe un upgrade, y le termina quedando 27.6 monedas" $ ((billetera.upgrade.extracción (depósito pepe 15)) 2) `shouldBe` 27.6
  it "Aplicar luchoCierraCuenta a pepe" $ (billetera(luchoCierraCuenta pepe) `shouldBe` 20
 describe "Transacciones: Casos con Pepe y Lucho" $ do
  it "pepe deposita 5 monedas en una billetera de 10, queda con 15" $ (billetera(pepeDeposita pepe 5)) `shouldBe` 15
  it "pepe2 deposita 5 monedas en una billetera de 20, queda con 25" $ (billetera(pepeDeposita pepe2 5)) `shouldBe` 25
  it "Lucho toca y se va" $ (billetera(luchoTocaYSeVa Lucho)) `shouldBe` 0
  it "Lucho es un ahorrante errante" $ (billetera(luchoEsUnAhorranteErrante Lucho)) `shouldBe` 34