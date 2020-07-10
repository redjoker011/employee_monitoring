# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
if User.all.empty?
  User.roles.each do |k, v|
    user = User.new(
      email: "user_#{k}@example.com",
      password: "hello2020",
      role: v,
      name: k
    )
    if user.save
      print "✓"
    else
      print "ERROR: #{user.errors.full_messages.to_sentence}"
      print "Aborted seeding of User model."
      break
    end

  end
end
