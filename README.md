# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 16 - Step Implement Apple Sign In
The steps to implement are explained in the lecture notes that can be found here:

[Apple Authentication](https://docs.google.com/presentation/d/1u0sv3tB5BHsVdFCI4gmVp_0eLWKwY7QU5_Rfms5qxak/edit?usp=sharing)

### Setting up your environment before the lecture

Each lecture is stored under a separate tag. On your computer do the following

    git clone <Repository Name>
    git pull
    git tag -l

This will list all the tags in the repository such as

    Lecture4
    Lecture5
    Lecture6
    ...

In order to pull a particular tag to your computer

    git checkout tags/Lecture5_start -b Lecture5_study

### Cloning to Google IDX

1. Go to this link. [idx.dev](https://idx.google.com/import?url=https://github.com/mehmetartun/CSEN268-F24)
2. Name your project (default value is fine)
3. Click the Flutter Project checkbox
4. Wait for the setup to continue
5. Open the terminal and pull the requisite tag from the repo by
```zsh
git pull
git tag -l
git tags/<TagName> -b <NewLocalBranchName>
```



