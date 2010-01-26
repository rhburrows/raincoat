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

Make sure to back up any existing git hooks you have first as raincoat
will be writing its own hooks at this point.

Raincoat works by looking in your script directory for the directory
with the same name as the hook being executed, and then it runs each
command in there. For example, the when the `pre-commit` hook is
executed it will look in `<script_dir>/pre-commit` and run each script
in there.

By default the script directory is set to `script` but a different
script directory can be specified by defining it in the configuration
file (see below).

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

If the `call` method returns `false` then the operation will be
unsuccessful and git will not proceed. If it returns `true` the hook
will have a `0` exit status so git can continue.

## Configuring Raincoat

Raincoat is configured through a YAML file. By default raincoat checks
the root directory of the project for `raincoat.yml`, but a different
configuration file can be specified when installing raincoat into the
project by passing it to the install command

    raincoat install my-config.yml

Will install raincoat to read the my-config.yml configuration file.

Raincoat can understand the following values in the configuration
file.

* `script_dir`: the base directory for raincoat scripts. The actual
  scripts will be in something like `<script_dir>/precommit`

## TODO

* Add support for additional git-hooks
* Change diff passed to hooks from raw string to real object
