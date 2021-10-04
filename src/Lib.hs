{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}

module Lib (startApp, app) where

import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import Control.Monad.IO.Class
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromField
import Database.PostgreSQL.Simple.FromRow
import GHC.Generics (Generic)
import GHC.Enum
import Composite.Aeson.Enum




-- TYPES

data Role = Admin | Client 

roleFormat = enumJsonFormat "role"



instance FromField UserRole where
  fromField field mdata = do
    role <- fromField field mdata
    case role :: String of
      "admin" -> return Admin
      "client" -> return Client
      _ -> return Client

data User = User
  { id       :: Int
  , password :: String
  , email    :: String
  , name     :: String
  , role     :: Role
  } deriving (Generic, FromRow)


$(deriveJSON defaultOptions 'User)




-- ROUTES

type API = "users" :> Get '[JSON] [User]




-- SQL TEST

localPG :: ConnectInfo
localPG = defaultConnectInfo
        { connectHost = "127.0.0.1"
        , connectDatabase = "pos_dev"
        , connectUser = "postgres"
        , connectPassword = ""
        }

users :: IO [User]
users = do
  conn <- connect localPG
  query_ conn "SELECT * FROM users;" :: IO [User]





-- SERVER

startApp :: IO ()
startApp = do 
  let port = 8080 :: Port 
  putStrLn $ "server is running at port: " <> show port
  run port app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = do
  u <- liftIO users
  return u

