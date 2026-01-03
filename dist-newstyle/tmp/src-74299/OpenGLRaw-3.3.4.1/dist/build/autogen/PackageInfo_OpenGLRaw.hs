{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_OpenGLRaw (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "OpenGLRaw"
version :: Version
version = Version [3,3,4,1] []

synopsis :: String
synopsis = "A raw binding for the OpenGL graphics system"
copyright :: String
copyright = "Copyright (C) 2009-2019 Sven Panne"
homepage :: String
homepage = "http://www.haskell.org/haskellwiki/Opengl"
