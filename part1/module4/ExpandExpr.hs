module Demo where


infixl 6 :+:
infixl 7 :*:
data Expr = Val Int | Expr :+: Expr | Expr :*: Expr
    deriving (Show, Eq)

expand' :: Expr -> Expr
expand' ((e1 :+: e2) :*: e) = expand' e1 :*: expand' e :+: expand' e2 :*: expand' e
expand' (e :*: (e1 :+: e2)) = expand' e :*: expand' e1 :+: expand' e :*: expand' e2
expand' (e1 :+: e2)         = expand' e1 :+: expand' e2
expand' (e1 :*: e2)         = expand' e1 :*: expand' e2
expand' e                   = e

-- Stopping expansion if the expression is expanded completely
expand :: Expr -> Expr
expand eCurr | eSucc == eCurr = eCurr
             | otherwise      = expand eSucc
  where
    eSucc = expand' eCurr
