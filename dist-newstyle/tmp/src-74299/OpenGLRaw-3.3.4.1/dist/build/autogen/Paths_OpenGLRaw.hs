{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
#if __GLASGOW_HASKELL__ >= 810
{-# OPTIONS_GHC -Wno-prepositive-qualified-module #-}
#endif
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_OpenGLRaw (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [3,3,4,1] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath




bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/kianbroderick/.local/state/cabal/store/ghc-9.6.7/OpnGLRw-3.3.4.1-7ed82a43/bin"
libdir     = "/Users/kianbroderick/.local/state/cabal/store/ghc-9.6.7/OpnGLRw-3.3.4.1-7ed82a43/lib"
dynlibdir  = "/Users/kianbroderick/.local/state/cabal/store/ghc-9.6.7/lib"
datadir    = "/Users/kianbroderick/.local/state/cabal/store/ghc-9.6.7/OpnGLRw-3.3.4.1-7ed82a43/share"
libexecdir = "/Users/kianbroderick/.local/state/cabal/store/ghc-9.6.7/OpnGLRw-3.3.4.1-7ed82a43/libexec"
sysconfdir = "/Users/kianbroderick/.local/state/cabal/store/ghc-9.6.7/OpnGLRw-3.3.4.1-7ed82a43/etc"

getBinDir     = catchIO (getEnv "OpenGLRaw_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "OpenGLRaw_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "OpenGLRaw_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "OpenGLRaw_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "OpenGLRaw_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "OpenGLRaw_sysconfdir") (\_ -> return sysconfdir)



joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
