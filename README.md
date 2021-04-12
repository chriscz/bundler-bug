## Steps to reproduce
```
git clone git@github.com:chriscz/bundler-bug
make
```

After testing you should see the following:

```
=== PATH-based include
bar-path INCLUDES: bar-path-1
bar-path INCLUDES: bar-path-2
=== GIT-based include
bar-git   MISSES: bar-git-1
bar-git   MISSES: bar-git-2
=== GIT-based include (with fix)
bar-git-fixed INCLUDES: bar-git-fixed-1
bar-git-fixed INCLUDES: bar-git-fixed-2
```

This shows that the working directory when evaluating the gemspec for the second gem `bar-git` is incorrect since its executables could not be found.

## Steps to prepare for ocmmit
```
make clean
git add .
git commit -m "Your message here"
```
