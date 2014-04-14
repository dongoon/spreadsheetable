require 'active_record'
ActiveRecord::Base.establish_connection( :adapter => 'sqlite3', :database => ':memory:')

class CreateTestTables < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :name
      t.integer :rank
      t.datetime :registered_at
    end

    create_table :comments do |t|
      t.integer :user_id
      t.integer :count
      t.string :said
    end
  end
end

ActiveRecord::Migration.verbose = false
CreateTestTables.up


class User < ActiveRecord::Base
  has_many :comments

  def say comment
    comments.create(count: comments.count + 1, said: comment)
  end
end

class Comment < ActiveRecord::Base
  belongs_to :user
end

FactoryGirl.define do
  factory :user do
    sequence(:name){ |n| "No.#{n} user" }
    sequence(:email){ |n| "user#{n}@example.com" }
    registered_at Time.now
  end
end
