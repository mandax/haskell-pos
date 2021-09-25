# Learning Haskell developing a Point of Sale app 

This is not a full app, the goal here is to learn Haskell not develop a full Point of Sale app. Luckly we can have something usefull at the end of the studies.

## Goal

The main goal is to learn:

- how to develop a propper haskell app;
- how to handle async calls in haskell;
- how to transform/serialize data;
- how to connect/use a database with haskell;
- how to write tests with haskell;

## Stack

Develop a Point of Sale functional app with the following structure:
- Server - Haskell
- Client - Elm
- DB - PostgreSQL

## Desirable Features

### 1. Restaurant
#### 1.1 Menu Manager
  - CRUD dishes/drinks
  - CRUD categories of dishes/drinks
#### 1.2 Orders
  - Follow current orders
  - Change order status
  - Cancel order
#### 1.3 Tables management
  - Table checkin
  - Table checkout
### 2. POS
  - Table checkin (desirable multiple check-ins)
  - Pick multiple dishes/drinks and add it to the order
  - Execute the order
  - Order status 
  - Cancel the order
  - Checkout
    - If has multiple checkins, split the bill

