data Expr = Num Int | Add Expr Expr | Mul Expr Expr

instance Show Expr where
    show (Num n) = show n
    show (Add a b) = (show a) ++ " + " ++ (show b)
    show (Mul a b) = "(" ++ (show a) ++ ") * (" ++ (show b) ++ ")"

simplify :: Expr -> Expr
simplify (Num x) = Num x
simplify (Add (Num 0) x) = x
simplify (Add x (Num 0)) = x
simplify (x) = x
