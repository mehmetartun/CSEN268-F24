# Santa Clara University - CSEN268 Fall 2024

## Lecture 12 - Dialogsheets and BottomSheet

The implementation details are presented in the attached slides.

![Slide 1](/assets/images/Mod02.png)
![Slide 2](/assets/images/Mod03.png)
![Slide 3](/assets/images/Mod04.png)
![Slide 4](/assets/images/Mod05.png)
![Slide 5](/assets/images/Mod06.png)
![Slide 6](/assets/images/Mod07.png)
![Slide 7](/assets/images/Mod08.png)
![Slide 8](/assets/images/Mod09.png)
![Slide 9](/assets/images/Mod10.png)



### Setting up your environment before the lecture

Each lecture is stored under a separate tag. In your computer do the following

    git clone <Repository Name>
    git pull
    git tag -l

This will list you all the tags in the repository such as

    Lecture4
    Lecture5
    Lecture6
    ...

In order to pull a particular tag to your computer

    git checkout tags/Lecture5_start -b Lecture5_study

### Cloning to Google IDX

1. Go to this link. [idx.dev](https://idx.google.com/import?url=https://github.com/mehmetartun/CSEN268-F24)
2. Name your project (default value is fine)
3. Click Flutter Project checkbox
4. Wait for the setup to continue
5. Open the terminal and pull requisite tag from the repo by
```zsh
git pull
git tag -l
git tags/<TagName> -b <NewLocalBranchName>
```



