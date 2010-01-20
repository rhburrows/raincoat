# Raincoat

    http://github.com/rhburrows/raincoat

## Intro

Git hooks are scripts that git runs before and after it call some
commands. They can be specified by placing executable files in the
`.git/hooks` directory and naming them according to a certain
convention. However, the `.git/hooks` directory is not distributed
with the git repository, so any hooks that you install must be
reinstalled every time you or anyone else clones the project.

## Installation

Raincoat can be installed through rubygems.

    gem install raincoat

If you wish to run the tests, or build the documentation you will also
need to install rspec, cucumber, and yard

## Usage

The first step is to initialize the raincoat hooks in your
project. This can be done by running the following command from the
root directory of your project.

    raincoat install

At this time existing git-hooks that you have may be wiped out so be
sure to back up any hooks that you want to save.

Raincoat works by looking in your script directory for the directory
with the same name as the hook being executed, and then it runs each
command in there. For example, the when the `pre-commit` hook is
executed it will look in `<script_dir>/pre-commit` and run each script
in there.

By default the script directory is set to `script` but a different
script directory can be specified by passing it to the
install command:

    raincoat install hooks

This would create a hooks directory where all of the hook scripts
could be placed.

## Anatomy of a Raincoat Script

Raincoat expects each of the scripts within the various hook
directories to follow two conventions.

1. Define a class with a name corresponding to the file name
  i.e. `email_changes.rb` should contain a class called `EmailChanges`
2. The defined call should respond to the `call` method with one
  parameter

The parameter that is passed to the `call` method is a string
representation of the change that is being made in git. For example in
the case of `pre-commit` it is the difference between the files that
are currently staged and the `HEAD` commit.

## TODO

* Add support for additional git-hooks
