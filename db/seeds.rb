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

# OUSIA PRODUCTS SEED --------------------------------------------------------------------
spritz = Item.create!(
  name: "Spritz",
  description: "Originaire d’Italie et grand classique des apéritifs en été, nous vous proposons de voyager avec nous par ce cocktail.",
  price: rand(1.0..500.0).round(2),
  stock: rand(1..50)
)
spritz.images.attach(io: File.open("app/assets/images/items/OUSIA_1.png"), filename: "item_1")
puts "Create Item 1"

pinkGT = Item.create!(
  name: "Pink G&T",
  description: "Voici notre ré-interprétation sans alcool du très connu Gin Tonic façon Pink. Nous sommes sûrs qu’il vous séduira par la fraîcheur et le mordant de sa genièvre associée à l’acidité sucrée des fruits rouges sans oublier les herbes et écorces qui viennent sublimer le tout. 🥒",
  price: rand(1.0..500.0).round(2),
  stock: rand(1..50)
)
pinkGT.images.attach(io: File.open("app/assets/images/items/OUSIA_2.png"), filename: "item_2")
puts "Create Item 2"

green_spirit = Item.create!(
  name: "Green Spirit",
  description: "Elaboré à partir de houblon 🌾, de maté 🍃, de racines et d’autres plantes 🌹, ce cocktail aux notes herbales et fraîches sera comme un remède revitalisant dans n’importe lesquelles de vos soirées (et ceci toujours avec très peu de calories 🤫) !",
  price: rand(1.0..500.0).round(2),
  stock: rand(1..50)
)
green_spirit.images.attach(io: File.open("app/assets/images/items/OUSIA_3.png"), filename: "item_3")
puts "Create Item 3"

old_barrel = Item.create!(
  name: "Old Barrel",
  description: "Élaboré autour de notes de fût de chêne associées à la poire, la vanille, au piment et à d’autres plantes, ce cocktail aux notes épicées et gourmandes tire sur les notes chaudes d’un alcool ambré de type whisky ! 🥃",
  price: rand(1.0..500.0).round(2),
  stock: rand(1..50)
)
old_barrel.images.attach(io: File.open("app/assets/images/items/OUSIA_4.png"), filename: "item_4")
puts "Create Item 4"

10.times do
  CartItem.create!(cart: Cart.all.sample, item: Item.all.sample)
  puts "Put Item in Cart"
end
# ----------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------

3.times do
  ordering_user = User.all.sample
  new_order = Order.create!(user: ordering_user, status: 'payment_confirmed')
  puts "Create Order"
  ordered_item = Item.all.sample
  new_orderitem = OrderItem.create!(order: new_order, item: ordered_item, quantity: rand(1..3))
  new_order.update!(status:"confirmed")
  puts "Register Order Items"
end