{-# LANGUAGE NoMonomorphismRestriction #-}
import Text.Show.Functions
import Data.List
import Data.Maybe
import Test.Hspec

ejecutarTests = hspec $ do
 describe "Eventos: Cosas que pasan con una billetera de 10 monedas" $ do
  it "Depósito 10 monedas, ahora tiene 20 monedas" $ billetera (depósito 10 pepe) `shouldBe` 20
  it "Extrajo 3 monedas, ahora tiene 7 monedas" $ (billetera (extracción 3 pepe)) `shouldBe` 7
  it "Extrajo 15 monedas, ahora tiene 0 monedas" $ (billetera (extracción 15 pepe)) `shouldBe` 0
  it "Tuvo un upgrade, ahora tiene 12 monedas" $ (billetera (upgrade pepe)) `shouldBe` 12
  it "Cuenta cerrada, no quedaron ni mariposas" $ (billetera (cierreDeCuenta pepe)) `shouldBe` 0
  it "No hubo cambios, sigue con 10 monedas" $ (billetera (quedaIgual pepe)) `shouldBe` 10
  it "Depósito 1000 monedas y tuvo un upgrade, ahora tiene 1020" $ ((billetera.upgrade.depósito 1000) pepe) `shouldBe` 1020
  it "Pepe tiene 10 monedas en su billetera" $ billetera pepe `shouldBe` 10
  it "Se cierra la cuenta de pepe y queda en 0" $ billetera (cierreDeCuenta pepe) `shouldBe` 0
  it "A pepe se le depositan 15, se extraen 2 y tiene un upgrade, la billetera deberia ser 27.6" $ billetera ((upgrade.extracción 2.depósito 15) pepe) `shouldBe` 27.6
 describe "Transacciones" $ do
  it "Se depósita 10 y aplica la transacción 1 a pepe, su billetera queda en 20" $ billetera ((transacción "Luciano" cierreDeCuenta.depósito 10) pepe) `shouldBe` 20
  it "Se aplica la transacción 2 a pepe y su billetera queda en 15" $ billetera (transacción "Jose" (depósito 5) pepe) `shouldBe` 15
  it "Se depósita 30 y aplica la transacción 2 a pepe2, su billetera queda en 55" $ billetera ((transacción "Jose" (depósito 5).depósito 30) pepe2) `shouldBe` 55
  it "Lucho toco se fue y su billetera quedo en 0" $ billetera (transacción "Luciano" (cierreDeCuenta.upgrade.depósito 15) lucho) `shouldBe` 0
  it "Pepe es un ahorrante errante y su billetera queda en 34" $ billetera (transacción "Luciano" (depósito 10.upgrade.depósito 8.extracción 1.depósito 2.depósito 1.depósito 8) lucho) `shouldBe` 34
 describe "Pago entre usuarios" $ do
  it "Se aplica la transacción 5 a pepe y queda con una billetera de 3" $ billetera (pagoEntreUsuarios "Jose" "Luciano" 7 pepe) `shouldBe` 3
  it "Se aplica la transacción 5 a lucho y queda con una billetera de 17" $ billetera ((pagoEntreUsuarios "Jose" "Luciano" 7.depósito 8) lucho) `shouldBe` 17

data Usuario = Usuario{
  nombre :: String,
  billetera :: Float
} deriving(Show)

pepe = Usuario "José" 10
pepe2 = Usuario "José" 20
lucho = Usuario "Luciano" 2

sumarDinero dinero usuario = (billetera usuario) + dinero
depósito dineroDepositado usuario = usuario{ billetera = sumarDinero dineroDepositado usuario}

restarDinero dinero usuario = (billetera usuario) - dinero
extracción dineroExtraido usuario
 |restarDinero dineroExtraido usuario > 0 = usuario{ billetera = restarDinero dineroExtraido usuario }
 |otherwise = usuario{ billetera = 0 }

upgrade usuario
 |billetera usuario * 0.2 < 10 = usuario { billetera = billetera usuario * 1.2}
 |otherwise = usuario { billetera = sumarDinero 10 usuario}

cierreDeCuenta usuario = usuario{ billetera = 0 }

quedaIgual usuario = usuario

--Transacciones
transacción unNombre tipoTransacción usuario
 |nombre usuario == unNombre = tipoTransacción usuario
 |otherwise = quedaIgual usuario


--Pago entre usuarios
pagoEntreUsuarios deudor acreedor dineroAduedado usuario
 |nombre usuario == deudor = extracción dineroAduedado usuario
 |nombre usuario == acreedor = depósito dineroAduedado usuario
 |otherwise = quedaIgual usuario

{-
Transacciones

1 = transacción "Luciano" cierreDeCuenta lucho
2 = transacción "Jose" (depósito 5) pepe
3 = tocoYMeVoy = (cierreDeCuenta.upgrade.depósito 15) lucho
4 = ahorranteErrante = (depósito 10.upgrade.depósito 8.extracción 1.depósito 2.depósito 1) lucho
5 = pepe le da 7 monedas a lucho

-}
