require 'active_record'
ActiveRecord::Base.establish_connection( :adapter => 'sqlite3', :database => ':memory:')

class CreateTestTables < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :name
      t.integer :rank
      t.integer :organization_id
      t.datetime :registered_at
    end

    create_table :organizations do |t|
      t.string :name
    end
  end
end

ActiveRecord::Migration.verbose = false
CreateTestTables.up


class User < ActiveRecord::Base
  belongs_to :organization

  def say comment
    comments.create(count: comments.count + 1, said: comment)
  end
end

class Organization < ActiveRecord::Base
  has_many :users
end

FactoryGirl.define do
  factory :organization do
    sequence(:name){ |n| "The group No.#{n}" }
  end

  factory :user do
    sequence(:name){ |n| "No.#{n} user" }
    sequence(:email){ |n| "user#{n}@example.com" }
    registered_at Time.now
    organization
  end
end
