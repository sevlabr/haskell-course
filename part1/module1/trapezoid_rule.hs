module Trapezoid where

-- using Cotes formula for uniform grid
integration :: (Double -> Double) -> Double -> Double -> Double
integration f a b = tr_rule f a b 1000
  
  where
    tr_rule :: (Double -> Double) -> Double -> Double -> Double -> Double
    tr_rule f a b p_num | abs (a - b) <= 1e-15 = 0
                        | otherwise            =
                          let
                            h = (b - a) / p_num
                            edge_diff = (f a + f b) / 2
                            cum_sum = calc_cum_sum f (a + h) h (p_num - 1) 0
                          in h * (edge_diff + cum_sum)
      
      where
        calc_cum_sum :: (Double -> Double) -> Double -> Double -> Double -> Double -> Double
        calc_cum_sum f a h n res | n == 0    = res
                                 | otherwise = calc_cum_sum f (a + h) h (n - 1) (res + f a)

