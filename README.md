# Citizen

# Installation

```ruby
# Gemfile

gem "citizen", :github => "easygive/citizen"
```

# Usage

```ruby
# app/models/transient.rb

class Transient < Citizen::Base
  attr_accessor :name, :email
  attr_accessible :email

  validates_presence_of :email

  before_save :set_name_to_email

  def set_name_to_email
    self.name = email
  end
end

# app/controllers/transients_controller.rb

class TransientsController < ApplicationController
  respond_to :html, :json, :xml

  def new
    @transient = Transient.new(:email => "test@localhost")
    respond_with(@transient)
  end
end
```
