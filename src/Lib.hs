{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}

module Lib
    ( startApp
    , app
    ) where

import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant


-- TYPES

data User = User
  { id    :: Int
  , email :: String
  , name  :: String
  , role  :: String
  } deriving (Eq, Show)

$(deriveJSON defaultOptions 'User)



-- ROUTES

type API = "users" :> Get '[JSON] [User]



-- SERVER

startApp :: IO ()
startApp = do 
  let port = 8080 :: Port 
  putStrLn $ "server is running at port: " ++ show port
  run port app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = return users

users :: [User]
users = [ User 1 "Isaac" "Newton" "admin"
        , User 2 "Albert" "Einstein" "client"
        ]

