require 'faker'

namespace :generate do
  task test_data: :environment do
    name = Faker::Name.name
    username = Faker::Internet.username(specifier: name)
    email = Faker::Internet.safe_email(name: name)
    password = Faker::Internet.password(min_length: 8)

    user = User.new(username: username, email: email, password: password)
    user.save!
    print '.'

    categories = 20.times.map do
      category = user.categories.new(
        title: Faker::Lorem.unique.words(number: rand(1..3)).join(' '),
        color: Faker::Color.hex_color,
      )
      category.save!
      print '.'
      category
    end

    tags = 50.times.map do
      tag = user.tags.new(title: Faker::Lorem.unique.word, color: Faker::Color.hex_color)
      tag.save!
      print '.'
      tag
    end

    (
      [[false, 0], [true, 0], [false, 1], [true, 1], [true, 10]] +
      395.times.map do [Faker::Boolean.boolean(true_ratio: 0.8), 10 - Math.sqrt(rand(0..120)).to_i] end
    ).each do |has_category, number_of_tags|
      task = user.tasks.new(
        title: Faker::Lorem.words(number: rand(1..3)).join(' '),
        note: Faker::Boolean.boolean(true_ratio: 0.7) ? Faker::Lorem.sentence : nil,
        is_done: Faker::Boolean.boolean,
        deadline_at: Faker::Boolean.boolean ? Faker::Time.forward : nil,
      )
      task.category = categories.sample if has_category
      task.tags = tags.sample(number_of_tags)
      task.save!
      print '.'
    end

    print "\n\n"
    puts "Testing user generated:"
    puts "  Email: #{email}"
    puts "  Password: #{password}"
  end
end
