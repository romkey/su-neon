# Managing the Neo Sign Controller at SU

These are instructions for updating and deploying the controller software.

## tl;dr

If you're already familiar with git, Heroku and Ruby and are ready to go:

1. Use your github account to access to `su-neon` repository. Talk to the right person at the iLab to be added as a collaborator.
2. Install `rbenv` on your computer to set up a local Ruby environment.
3. `git clone` the `su-neon` repo to your computer
4. `bundle install`
5. Install [Heroku command line interface](https://devcenter.heroku.com/categories/command-line)
6. `heroku login` to set your Heroku credentials, and `heroku git:remote` to allow you to push to the Heroku app
7. `heroku local` to start a local development server - point your browser to `localhost:3000` to access it
8. Make your changes, test them and `git commit -a` to save them
9. `git push` to push your work to the repository on Github
10. `git push heroku` to deploy your changes to Heroku

## Github

If you're going to contribute changes to the software you'll need to get access to the repository, which means you'll need a Github account and will need to talk to someone at the iLab. Ask them to add you as a collaborator on the repository.

To use Github, you'll need a Github account. You'll also need to share your public SSH key with Github.

[Connecting to GitHub with SSH](https://help.github.com/articles/connecting-to-github-with-ssh/)

## Ruby

Your Mac or Linux computer likely has its own copy of Ruby already installed. However, we want to insulate our use of Ruby for the controller from the system's copy of Ruby. Using a private copy of Ruby has several advantages:
- our changes to Ruby and its environment won't accidentally cause problems for the system
- system updates won't overwrite our changes to Ruby
- we can use different versions of Ruby from the version the system has installed
- we can use different versions of Ruby for different projects
- we can install Ruby gems without having to escalate privileges and become root

So you'll need to install a Ruby environment. On a Mac or Linux computer, the easiest way is to use [rbenv](https://github.com/rbenv/rbenv) and [rbenv-build](https://github.com/rbenv/ruby-build). Once you've installed them following their instructions you'll need to install a private copy of Ruby. Look at the file `.ruby-version` in this repository and install that version of Ruby. For instance,
```
rbenv install 2.3.5
```

You'll also need to install `bundler`, which almost all Ruby programs depend on.
```
gem install bundler 
```

## Git

In order to contribute changes to the repo you'll need to use `git` for revision control.

It's likely that your computer has a version of `git` installed already. It's also likely that it's horribly out of date. If it doesn't have `git` or you want the latest version, on a Mac use Homebrew to install it:
```
brew install git
```

Once you have a working `git`, decide where you want to keep your copy of `su-neon` and clone it:
```
git clone git@github.com:romkey/su-neon.git
```

## Gems

You should test your changes to `su-neon` on your computer before you deploy them. To do that you'll need to install the Ruby gems that it depends on. At the top level of the cloned `su-neon` repo:
```
bundle install
```

## Heroku

`su-neon` runs on a service called [Heroku](heroku.com). Heroku has a free tier, which su-neon uses. The free tier has very limited storage and sleeps servers when they're inactive. Waking from sleep takes a short period of time, which is why the it's so slow to load https://su-neon.herokuapp.com/ after it's been inactive.

If you're on a Mac, first install [Homebrew](https://brew.sh/) following its instructions. Then:
```
brew install heroku
```

will get you the [Heroku command line interface](https://devcenter.heroku.com/categories/command-line).

If you're not on a Mac, [follow the instructions for your platform](https://devcenter.heroku.com/articles/heroku-cli).

You'll need an account on [Heroku](https://heroku.com). Then you'll need to be added as a collaborator on the `su-neon` Heroku app.

At the command line on your computer (where you installed the `heroku` CLI):
```
heroku login
```

This will prompt you for the email address and password you use to login to Heroku.

You'll also need to add Heroku as a remote repository for git:
```
heroku git:remote
```

## Updating the code

1. Make local edits to the code

2. Test the edits locally:
```
heroku local
```
and then load the web page in your browser by going to `http://localhost:5000`

Templates for the web pages can be found in `app/views/`

3. Once your changes work, commit them to git and push them to Github:
```
git commit -a
git push
```

`commit` will pop up an editor window. You should add information
about the changes, save the file and exit.

4. Deploy them to Heroku:
```
git push heroku
```

For large or complex changes, consider using a branch and merging when
you're done:

```
git checkout -b BRANCH_NAME

make your changes and test them

git checkout master
git merge BRANCH_NAME
```

Be sure to use `git add` to add any new files to the project. You can
see a list of changed files and untracked files that need to be added
with `git status`.
