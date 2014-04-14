require 'spec_helper'

describe Spreadsheetable do
  I18n.load_path += Dir[ File.join(File.dirname(__FILE__), '*.yml') ]
  I18n.default_locale = :ja
  I18n.enforce_available_locales = false

  before{
    Organization.create name: "The group"
    3.times{ FactoryGirl.create :user }
  }
  let(:users){ User.all }
  let(:sheet_users){ users.extend Spreadsheetable }

  it 'should have a version number' do
    Spreadsheetable::VERSION.should_not be_nil
  end

  describe "initialize" do

    describe "#sheet_columns" do
      example{ expect(sheet_users.sheet_columns).to be_an_instance_of(Array) }
    end

    describe "extendable object type" do
      subject{ users.extend Spreadsheetable }

      context "ActiveRecord::Relation" do
        let(:users){ User.unscoped }

        example{ expect{subject}.to_not raise_error }
      end

      context "Array of active_record" do
        let(:users){ o = User.all.to_a }
        before{ expect(sheet_users).to be_an_instance_of(Array) }

        example{ expect{ subject }.to_not raise_error }
      end

      context "other" do
        let(:users){ [ Object.new ] }

        example{ expect{ subject }.to raise_error }
      end
    end
  end

  describe "#sheet_columns=" do
    subject{ sheet_users.sheet_columns = set_columns }

    context "set array instance" do
      let(:set_columns){ %w(a b c) }

      example{ expect{ subject }.to_not raise_error }
      example "should over write sheet_columns" do
        expect(sheet_users.sheet_columns).to eq([])
        subject
        expect(sheet_users.sheet_columns).to eq(set_columns)
      end
    end

    context "set NOT array instance" do
      let(:set_columns){ "a b c" }

      example{ expect{ subject }.to raise_error }
    end

  end

  describe "private methods" do

    describe "#_sheet_header" do
      subject{ sheet_users.send :_sheet_header }

      before{
        sheet_users.sheet_columns += %w(id organization.name name email)
      }

      shared_examples_for "_sheet_header" do
        example "should be generated with sheet_columns config" do
          expect(subject.length).to eq(sheet_users.sheet_columns.length)
        end

        example "column header is resolved by I18n" do
          expect(subject).to eq(%w(Id 組織名 氏名 メールアドレス))
        end
      end

      context "ActiveRecord::Relation" do
        before{ expect(sheet_users.is_a?(ActiveRecord::Relation)).to eq(true) }

        it_should_behave_like "_sheet_header"
      end

      context "Array of active_record" do
        let(:users){ o = User.all.to_a }
        before{ expect(sheet_users).to be_an_instance_of(Array) }

        it_should_behave_like "_sheet_header"
      end
    end
  end
end
