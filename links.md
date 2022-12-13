### Links

#### Common things

- https://www.ohaskell.guide/pdf/ohaskell.pdf - базовый учебник
- https://www.haskell.org/onlinereport/haskell2010/ - стандарт 2010
- https://www.haskell.org/ - официальный сайт
- https://hoogle.haskell.org/ - онлайн справка
- https://hackage.haskell.org/ - справка по основным и доп. модулям; base -> Prelude -> reverse - пример; есть ссылки на исходники
- https://www.youtube.com/playlist?list=PLlb7e2G7aSpRDR44HMNqDHYgrAOPp7QLr - лекции CSC, есть некоторые фундаментальные вещи; например, лямбда-исчисление
- http://mit.spbau.ru/sewiki/index.php/%D0%A4%D1%83%D0%BD%D0%BA%D1%86%D0%B8%D0%BE%D0%BD%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B5_%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5_2015 - материалы по лекциям CSC
- https://github.com/bitemyapp/learnhaskell - useful materials
- https://github.com/krispo/awesome-haskell - also useful materials
- http://learnyouahaskell.com/ - еще один онлайн учебник; говорят, что хороший
- https://github.com/quchen/articles/blob/master/build.md - статьи о Haskell
- https://www.haskellforall.com/ - какой-то блог по Haskell (говорят, тут хорошо написано про линзы)
- https://patternsinfp.wordpress.com/ - что-то более "научное" про Hakell FP
- https://www.schoolofhaskell.com/ - ещё полезности про Haskell
- https://ruhaskell.org/ - о Haskell на русском
- https://kseo.github.io/ - Kwang's Haskell Blog

#### Specialized

- https://habr.com/ru/post/247213/ - статья про ленивые вычисления и Weak Head Normal Form; также чекай автора, у него есть некоторые другие
  интересные статьи (теория сложности и проч.)
- https://habr.com/ru/post/581234/ - написание компилятора на Haskell + LLVM; может пригодиться в будущем для pet-project; также чекай связанные ссылки,
  хотя ты их уже читал и это не обязательно
- https://stackoverflow.com/questions/13042353/does-haskell-have-tail-recursive-optimization - о tail/guarded-рекурсии в Hakell и прочие связанные полезности
- https://www.reddit.com/r/haskell/comments/1f48dc/what_does_the_haskell_runtime_look_like/ - что-то про runtime и потребляемую память / эффективность,
  но пока не начинал читать
- http://pointfree.io/ - автоматический перевод конструкций языка Haskell в point-free стиль
- https://stackoverflow.com/questions/18934882/haskell-line-of-code-not-compiling-illegal-datatype-context - как наложить ограничение (контекст)
  на пользовательский тип данных (Note: эта функция убрана из новых версий Haskell)
- https://downloads.haskell.org/~ghc/7.0.1/docs/html/users_guide/rewrite-rules.html - rewrite rules для оптимизаций компилятора (например, как сказать ему,
  чтобы он считал fmap (g . h) xs, а не (fmap g . fmap h) xs, потому что так быстрее из-за отсутствия промежуточных списков)
- https://en.wikibooks.org/wiki/Haskell/Category_theory - теория категорий в контексте Haskell. Можно также посмотреть другие статьи на сайте (https://en.wikibooks.org/wiki/Haskell)
- https://bartoszmilewski.com/2014/10/28/category-theory-for-programmers-the-preface/ - теория категорий для программистов (остальной сайт тоже стоит посмотреть)
- https://habr.com/ru/post/245797/ - переводы некоторых статей по ссылке выше
- https://www.youtube.com/watch?v=I8LbkfSSR58&list=PLbgaMIhjbmEnaH_LTkxLI7FMa2HsnawM_&index=1&ab_channel=BartoszMilewski - YT, связанный с 2 ссылками выше
- https://stackoverflow.com/questions/7746894/are-there-pronounceable-names-for-common-haskell-operators - имена операторов в Haskell

##### Smth about Functors and Monads
- https://adit.io/ - useful resource (Functors, Applicative Functors, Monads, Lenses etc.)
- https://habr.com/ru/post/183150/ - Functors, Applicative Functors and Monads (translated from adit)
- https://habr.com/ru/post/184722/ - 3 Useful Monads (translated from adit)
- https://egghead.io/courses/professor-frisby-introduces-composable-functional-javascript - maybe useful
- https://www.youtube.com/watch?v=IkXg_mjNgG4&ab_channel=TverIO - Виталий Брагилевский — Монады - не приговор
- https://habr.com/ru/post/127556/ - серия переводов статей про монады в Haskell; в конце есть ссылки на сайты с полезной инфой
- https://mvanier.livejournal.com/ - оригиналы статей, переводы которых расположены ссылкой выше

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
