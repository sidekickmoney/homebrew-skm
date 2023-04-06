# homebrew-skm

## 123
If you install mpg123 with skm, from our Tap, then you will need to add the following to your .rc override (~/.skm/rc/999-user-defined-rc):
```
export MPG123_MODDIR="/Users/[unix username here]/.local/homebrew/Cellar/mpg123/1.31.3/lib/mpg123"
```
otherwise it won't work!

