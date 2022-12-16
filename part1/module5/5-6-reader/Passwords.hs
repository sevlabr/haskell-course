module Demo where


type User = String
type Password = String
type UsersTable = [(User, Password)]

data Reader r a = Reader { runReader :: (r -> a) }

instance Monad (Reader r) where
  return x = Reader $ \_ -> x
  m >>= k  = Reader $ \r -> runReader (k (runReader m r)) r

instance Applicative (Reader r) where
  pure  = undefined
  (<*>) = undefined

instance Functor (Reader r) where
  fmap = undefined

asks :: (r -> a) -> Reader r a
asks = Reader

pwds = [("user", "123456"), ("x", "hi"), ("v", "123456"), ("y", "qwerty"), ("t", "fer"), ("root", "123456")]

-- Эту функцию можно заменить на что-то более элегантное. См. решения других на Степике
searchUsersWithBadPwds :: String -> UsersTable -> [User]
searchUsersWithBadPwds _ [] = []
searchUsersWithBadPwds badPw (up:ups) | snd up == badPw = (fst up) : searchUsersWithBadPwds badPw ups
                                      | otherwise       = searchUsersWithBadPwds badPw ups

usersWithBadPasswords :: Reader UsersTable [User]
usersWithBadPasswords = asks (searchUsersWithBadPwds "123456")

test = runReader usersWithBadPasswords pwds == ["user", "v", "root"]
