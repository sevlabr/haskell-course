# Fib numbers with tail recursion
def fib_acc(n, a=0, b=1):
  if n == 0:
    return a
  elif n == 1:
    return b
  elif n > 1:
    return fib_acc(n - 1, b, a + b)
  elif n < 0:
    return fib_acc(n + 1, b - a, a)

def fibonacci(n):
  return fib_acc(n)
