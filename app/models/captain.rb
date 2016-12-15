class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).where("classifications.name = 'Catamaran'")
  end

  def self.sailors
    self.joins(boats: :classifications).distinct.where("classifications.name = 'Sailboat'")
  end

  def self.motorboaters
    self.joins(boats: :classifications).distinct.where("classifications.name = 'Motorboat'")
  end

  def self.talented_seamen
    ids = sailors.pluck(:id) & motorboaters.pluck(:id)
    self.where(id: ids)
  end

  def self.non_sailors
    self.where.not(id: sailors.ids)
  end

end
