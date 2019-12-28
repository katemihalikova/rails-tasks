class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def build_resource(hash=nil)
    super(hash)

    categories = ['Osobní', 'Škola', 'Práce'].map do |title|
      category = resource.categories.new(title: title, color: helpers.random_color)
      category.save
      [title, category]
    end.to_h

    tags = ['UCL', 'JSE', 'WEB', '3DT', 'PR1', 'PES', 'Nákupy', 'Wishlist'].map do |title|
      tag = resource.tags.new(title: title, color: helpers.random_color)
      tag.save
      [title, tag]
    end.to_h

    resource.tasks.new(title: 'Toto je jednoduchý úkol', note: '', is_done: false).save
    resource.tasks.new(title: 'Toto je už dokončený úkol', note: '', is_done: true).save
    resource.tasks.new(title: 'Nakoupit na večeři', note: '', is_done: false, category: categories['Osobní'], tags: [tags['Nákupy']]).save
    resource.tasks.new(title: 'Udělat semestrální práci z předmětu WEB', note: '', is_done: false, category: categories['Škola'], tags: [tags['UCL'], tags['WEB']]).save
  end
end
