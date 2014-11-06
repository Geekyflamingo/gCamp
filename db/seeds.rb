# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
   users = User.create([
     { first_name: 'AA',
     last_name: 'BB',
     email: 'aa@bb.com',
     password: 'aabb',
     password_confirmation: 'aabb' }
  ])
