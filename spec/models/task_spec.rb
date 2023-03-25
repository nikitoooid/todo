require 'rails_helper'

RSpec.describe Task do
  it { should belong_to :user }
  it { should validate_presence_of :title }
end
