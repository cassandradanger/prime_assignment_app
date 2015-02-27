require 'rails_helper'
require 'rspec/its'

describe Admin do
  it { should respond_to(:name) }
  it { should respond_to(:name_and_email) }
  it { should respond_to(:name_or_email) }
end