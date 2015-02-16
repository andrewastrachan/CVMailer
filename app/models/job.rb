class Job < ActiveRecord::Base
  require 'csv'
  
  validates :user_id, :title, :email, presence: true
  validates :sent, :inclusion => {:in => [true, false]}
  # before_validation :sent_false
  before_validation :process_address
  
  belongs_to :user
  
  #
  # def sent_false
  #   self.sent = false
  # end
  
  def self.import(file, user)
      CSV.foreach(file.path, encoding: "r:ISO-8859-1", headers: true) do |row|
      next if row["company"].nil?
      row = row.to_hash
      j = user.jobs.new(row)
      j.sent = false
      j.save!
    end
  end
  
  def process_greeting    
    return "Dear #{self.company} team," if self.recipient.nil?
    return "Dear #{recipient},"
  end
  
  def process_address
    if (self.address) && (self.sent == false)
      parsed_address = GoogleMapsGeocoder.new(self.address)
      self.address = parsed_address.formatted_address
      self.street_address = parsed_address.formatted_street_address
      self.location = parsed_address.city + " " + parsed_address.state_short_name
      self.postal_code = parsed_address.postal_code
    end
  end
  
  def process_title
    return "#{self.title} -- #{self.location}" if self.location
    self.title
  end
  
  def parse_address
  end
  
  def send_job
    self.sent = true
    self.save!
  end
  
end
