{-# LANGUAGE NoMonomorphismRestriction #-}
import Text.Show.Functions
import Data.List
import Data.Maybe
--import Test.Hspec

data Usuario = Usuario{
  billetera :: Int,
  nivel :: Int
} deriving(Show)

rodrigo = Usuario 10 0

sumarDinero usuario dinero = (billetera usuario) + dinero
depósito usuario dineroDepositado = usuario{ billetera = sumarDinero usuario dineroDepositado}

restarDinero usuario dinero = (billetera usuario) - dinero
extracción usuario dineroExtraido
 |restarDinero usuario dineroExtraido > 0 = usuario{ billetera = restarDinero usuario dineroExtraido}
 |otherwise = usuario{ billetera = 0}

--upgrade usuario

--cierreDeCuenta usuario =
--quedaIgual usuario =
