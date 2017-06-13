class Track < ApplicationRecord

  # Constants: (convention says these have to be all-caps)
  SHORT = 180000
  LONG = 360000

  # Scopes:
  scope :starts_with, -> (char) { where('name ILIKE ?', "#{ char }%") }

  scope :short,  -> { shorter_than(SHORT) }
  scope :medium, -> { longer_than(SHORT).shorter_than(LONG) }
  scope :long,   -> { longer_than(LONG) }

  # Validations:
  validates :name,         presence: true
  validates :milliseconds, presence: true
  validates :composer,     presence: true
  validates :bytes,        presence: true
  validates :unit_price,   presence: true

  validates :milliseconds, numericality: { greater_than: 0 }
  validates :unit_price,   numericality: { greater_than_or_equal_to: 0.0 }

  validate :name_must_be_titleized

  private # Private because it's only used within this class.
  # Make every method private until you realize there's a need for it not to be.
    def name_must_be_titleized
      # Make sure first char is uppercase
      first_char = name[0]
      first_char_is_not_upcased = (first_char != first_char.upcase)
      # If first character is not uppercase, add an error
      if first_char_is_not_upcased
        errors.add(:name, 'must be capitalized.')
      end#if
    end#name_must_be_titleized
  end#private

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
