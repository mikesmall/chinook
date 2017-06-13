class Track < ApplicationRecord

  # Constants: (convention says these have to be all-caps)
  SHORT = 180000
  LONG = 360000

  # Scopes:
  scope :starts_with, -> (char) { where('name ILIKE ?', "#{ char }%") }

  scope :short,  -> { shorter_than(SHORT) }
  scope :medium, -> { longer_than(SHORT).shorter_than(LONG) }
  scope :long,   -> { longer_than(LONG) }

  # Methods (called by Scopes):
  def self.shorter_than(milliseconds)
    where('milliseconds < ?', milliseconds)
  end#self.shorter_than

  def self.longer_than(milliseconds)
    where('milliseconds >= ?', milliseconds)
  end#self.longer_than

  # def self.starts_with_method(char)  # (Method version of starts_with scope)
  #   if char.present?
  #     where('name ILIKE ?', "#{ char}%")
  #   else
  #     none
  #   end#if
  # end#self.starts_with_method



# Previous code:

  # def self.short
  #   # where('milliseconds < ?', SHORT)
  #   shorter_than(SHORT)
  # end#self.short

  # def self.medium
  #   # where('milliseconds >= ? AND milliseconds < ?', SHORT, LONG)
  #   longer_than(SHORT).shorter_than(LONG)
  # end#self.medium

  # def self.long
  #   # where('milliseconds >= ?', LONG)
  #   longer_than(LONG)
  # end#self.long

end#Track
