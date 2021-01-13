# Drupal 8 Training Repository

Hello.

This is a training project, where you can learn how to install and work on a Drupal 8 project.
This documentation is very close to what you will find working with us.

Good luck.

## Installation and Usage

Add to your `hosts` file this line `127.0.0.1 dev.drupal_training.com` :
* Windows: `C:\Windows\System32\drivers\etc\host`
* Linux: `/etc/hosts`

Prerequisites:
* Docker
* Make command
* Composer

## First install

Start the application
```
$ make up
```

Get inside the container
PS: If you are running on windows terminal, you should type `winpty` as prefix
```
$ make in
```

Install Drupal CMS and all it's dependencies
PS: Before this step, please read the section `Known issues`
```
$ composer install
```

Add the configuration files (outside container)
```
$ make add-configs
```

Clear Drupal cache
PS: If you are not inside the container, type `make in`
```
$ drush cr
```

## Running Locally with Docker

The following command starts the application
```
$ make up
```

The following command puts you inside an container with bash
PS: If you are running on windows terminal, you should type `winpty` as prefix
```
$ make in
```

## Closing the application

The following command stops the application and let you work with others Docker's projects.
It is advisable to run this command after finishing coding.
```
$ make stop
```

### Known issues

#### Docker with windows
Docker has various problems with Windows permissions.  So, sometimes you may receive an error after executing `composer install`:
```
[RuntimeException]
Failed to execute git checkou 'e53e75b4582a5d2b454b08c318a17f57339e60e' -- && git reset --hard 'e53e75b4582a5d2b454b08c318a17f57339e60e' --
fatal: failed to read object e53e75b4582a5d2b454b08c318a17f57339e60e: Operation not permited
```

If this happens to you, just get out the container by typping `exit`, and execute the `composer install` direct in the project's root folder.
For this, you need to have the `composer` installed in you PC.
As we know, this is a permission problem between Docker and Windows.

#### Git tokens
Composer install will download all its dependencies, and some of them need a Github OAuth token. To proceed the installation, just follow the instructions received in the terminal.


## What you need to do

### Login on CMS

Enter the container and execute the follow command to access the CMS:
```
$ drush uli
```
Replace the domain and access the generated URL to login on CMS.

### Theming

[Create a new theme](https://www.drupal.org/docs/theming-drupal/how-to-create-a-basic-drupal-8-theme).