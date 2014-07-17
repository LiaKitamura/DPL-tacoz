class MenuItem < ActiveRecord::Base
  include Elasticsearch::Model

  #  the indexes can take several arguments. type: string is the default if not specified
  mapping do
    indexes :name, boost: 10
    indexes :description, type: 'string'
  end

  mount_uploader :picture, MenuItemPictureUploader
  has_many :ingredients

  # We need this for nested forms. This saves ingredients when we save a menu item. and allow will allow _destroy to to actually destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: :has_blank_attributes

  # after we initialize a MenuItem. if its empty build ingredients
  after_initialize do
    if ingredients.empty?
      ingredients.build
    end
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def self.vegetarian
    # scoped to class method on itself to return on only vegetarian items
    where(vegetarian: true)
  end

  def ingredient_names
    ingredients.pluck(:name).join(', ')
  end

  private

  def has_blank_attributes(ingredient_attrs)
    ingredient_attrs['name'].blank?
  end
end
