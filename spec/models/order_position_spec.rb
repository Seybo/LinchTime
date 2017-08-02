# frozen_string_literal: true

require 'rails_helper'

describe OrderPosition do
  it { should validate_presence_of(:person) }
  it { should validate_presence_of(:meal) }
  it { should validate_presence_of(:order) }
end
