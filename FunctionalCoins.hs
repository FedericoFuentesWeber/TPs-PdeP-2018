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

ejecutarTests = hspec $ do
 describe "Cosas que pasan" $ do
  it "Depósito 10 monedas, ahora tiene 20 monedas" $ (billetera (depósito rodrigo 10)) `shouldBe` 20
  it "Extrajo 3 monedas, ahora tiene 7 monedas" $ (billetera (extracción rodrigo 3)) `shouldBe` 7
  it "Extrajo 15 monedas, ahora tiene 0 monedas" $ (billetera (extracción rodrigo 15)) `shouldBe` 0
  it "Tuvo un upgrade, ahora tiene 12 monedas" $ (billetera (upgrade rodrigo)) `shouldBe` 12
  it "Cuenta cerrada, no quedaron ni mariposas" $ (billetera (cierreDeCuenta rodrigo)) `shouldBe` 0
  it "No hubo cambios, sigue con 10 monedas" $ (billetera (quedaIgual rodrigo)) `shouldBe` 10
  it "Depósito 1000 monedas y tuvo un upgrade, ahora tiene 1020" $ ((billetera.upgrade.depósito rodrigo) 1000) `shouldBe` 1020