# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
install ruby 2.4.1 into your machine

* System dependencies

* Configuration
clone code from: https://bitbucket.org/nldanang/sokuhaku
cd sokuhaku
mkdir -p vendor/bundle
bundle install --path vendor/bundle

* Database creation
create database sokuhaku_development DEFAULT CHARACTER SET utf8mb4;
create database sokuhaku_test DEFAULT CHARACTER SET utf8mb4;

grant all on sokuhaku_development.* to 'username'@'%' identified by 'password';
grant all on sokuhaku_test.* to 'username'@'%' identified by 'password';

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
