# Santa Clara University - CSEN268 Fall 2024

[Table of Contents](/toc.md)


## Lecture 15 - Cloud Functions and Serverless Computing
We explore Cloud Functions in Firebase using NodeJS

### Step 3 - Deploying Cloud Functions
To be able to deploy Cloud Functions, you will need the **Blaze** billing plan. More information on that can be found here [Firebase Pricing Plans](https://firebase.google.com/docs/projects/billing/firebase-pricing-plans)

Once you've turned on the **Blaze** plan you are ready to deploy your functions

#### Deploying Cloud Functions
Before that make sure that you have the correct `node` version specified in the [package.json](/functions/package.json) file.
```js
  "engines": {
    "node": "20"
  },
```

The deployment of cloud functions is done with the following command:
```zsh
firebase deploy --only functions
```
With this, all existing functions will be deployed. 

If you only want to deploy a specific function:
```zsh
firebase deploy --only functions:<function-name>
```
A full list of the functions can be seen at `https://console.cloud.google.com/functions/list?project=<your-project-id>` where you can see the contents of the function, view logs, increase memory and runtime etc:

![Cloud Functions](/assets/images/CloudFunctionsView.png)

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



