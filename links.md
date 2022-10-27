### Links

#### Common things

- https://www.ohaskell.guide/pdf/ohaskell.pdf - базовый учебник
- https://www.haskell.org/onlinereport/haskell2010/ - стандарт 2010
- https://www.haskell.org/ - официальный сайт
- https://hoogle.haskell.org/ - онлайн справка
- https://www.youtube.com/playlist?list=PLlb7e2G7aSpRDR44HMNqDHYgrAOPp7QLr - лекции CSC, есть некоторые фундаментальные вещи; например, лямбда-исчисление
- http://mit.spbau.ru/sewiki/index.php/%D0%A4%D1%83%D0%BD%D0%BA%D1%86%D0%B8%D0%BE%D0%BD%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B5_%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5_2015 - материалы по лекциям CSC
- https://github.com/bitemyapp/learnhaskell - useful materials
- https://github.com/krispo/awesome-haskell - also useful materials

#### Specialized

- https://habr.com/ru/post/247213/ - статья про ленивые вычисления и Weak Head Normal Form; также чекай автора, у него есть некоторые другие
  интересные статьи (теория сложности и проч.)

### Running Haskell
To run Haskell in interactive mode in console via Docker:
```
docker run -it --rm haskell:7.8
```

Limit resources used by Haskell:

- shell command, versatile approach (use with caution)
  ```
  ulimit --help
  ```
- GHCi way (you need to install stack-haskell first)
  ```
  stack ghci --ghci-options="+RTS -M256m -K256m -RTS"
  ```
