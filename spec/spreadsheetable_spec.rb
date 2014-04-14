require 'spec_helper'

describe Spreadsheetable do
  it 'should have a version number' do
    Spreadsheetable::VERSION.should_not be_nil
  end

  describe "extendable object type" do
    subject{ obj.extend Spreadsheetable }

    context "ActiveRecord::Relation" do
      let(:obj){ User.unscoped }

      example{ expect{subject}.to_not raise_error }
    end

    context "Array of active_record" do
      before{ 3.times{ FactoryGirl.create :user } }
      let(:obj){ o = User.all.to_a }

      example{ expect{ subject }.to_not raise_error }
    end

    context "other" do
      let(:obj){ [ Object.new ] }

      example{ expect{ subject }.to raise_error }
    end
  end
end
