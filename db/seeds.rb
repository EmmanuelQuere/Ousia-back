Admin.destroy_all
User.destroy_all
Item.destroy_all
Cart.destroy_all
Order.destroy_all

Admin.create!(email: 'admin@admin.com', password: 'ousia123')

5.times do
  new_user = User.create!(
    email: Faker::Name.first_name + "@yopmail.com",
    password: "azerty",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
  Cart.create!(user_id: new_user.id)
  puts "Create User and Cart"
end

10.times do |index|
  Item.create!(
    name: Faker::Creature::Cat.breed,
    description: Faker::Lorem.sentence(word_count: 8),
    price: rand(1.0..500.0).round(2),
    stock: rand(1..50)
  )
  puts "Create Item"
end

10.times do
  CartItem.create!(cart: Cart.all.sample, item: Item.all.sample)
  puts "Put Item in Cart"
end

3.times do
  ordering_user = User.all.sample
  new_order = Order.create!(user: ordering_user, status: 'confirmed')
  puts "Create Order"
  ordered_item = Item.all.sample
  new_orderitem = OrderItem.create!(order: new_order, item: ordered_item, quantity: rand(1..3))
  ordered_item.stock -= new_orderitem.quantity
  puts "Register Order Items"
end
